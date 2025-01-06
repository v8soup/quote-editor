class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_company
    @current_company ||= Current.user.company if authenticated?
  end
  helper_method :current_company
  # before_action -> { sleep 3 }
end
