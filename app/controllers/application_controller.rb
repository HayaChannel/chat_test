class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :require_valid_token

  private

  def require_valid_token
    access_token = request.headers[:HTTP_ACCESS_TOKEN]
    if !User.login?(access_token)
      respond_to do |format|
        format.json { render nothing: true, status: :unauthorized }
      end
    end
  end
end
