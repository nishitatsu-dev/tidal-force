class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
  def set_timezone_and_first_date
    session[:timezone] = params[:timezone] || session[:timezone] || "Asia/Tokyo"
    session[:first_date] = params[:first_date] || session[:first_date] || Date.today.strftime("%Y-%m-%d")
  end
end
