class HomeController < ApplicationController
  def index
    if user_signed_in?
      @record_titles = make_record_titles
      set_session
      @records = make_one_day_records
    end
  end

  private
  def set_session
    session[:timezone] = if !params[:timezone].blank?
      params[:timezone]
    elsif !session[:timezone].blank?
      session[:timezone]
    else
      "Asia/Tokyo"
    end

    session[:first_date] = if !params[:first_date].blank?
      params[:first_date]
    elsif !session[:first_date].blank?
      session[:first_date]
    else
      Date.today.strftime("%Y-%m-%d")
    end

    session[:page_id] = params[:page_id].to_i || 0
  end
end
