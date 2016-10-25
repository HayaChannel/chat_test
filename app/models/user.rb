class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :me_logings
  has_many :rooms, through: :me_logings
  has_many :messages
  has_many :sessions, dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: true
  validates :password,
            presence: true,
            length: { minimum: 6}, if: -> { new_record? || changes["password"]}

  def self.login?(access_token)
    session = Session.find_by_access_token(access_token)
    return false if !session || !session.before_expired? || !session.active
    return !self.find(session.user_id).nil?
  end

  def activate
    if !session
      return Session.create(user_id: self.id)
    else
      if !session.active
        session.set_active
        session.save
      end
      if !session.before_expired?
        session.set_expiration
        session.save
      end
      return session
    end
  end

  def inactivate
    session.active = false
    session.save
  end

  private

  def session
    @session ||= Session.find_by_user_id(self.id)
  end

end
