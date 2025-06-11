class HomeController < ApplicationController
  def index
    if user_signed_in?
      @record_titles = make_record_titles
      set_session
      Time.use_zone(session[:timezone]) do
        date = Date.parse(session[:first_date]).advance(days: get_page).strftime("%Y-%m-%d")
        db_records = get_db_records(date)
        @records = make_hourly_records(date, db_records)
      end
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
  end

  def get_page
    params[:page].to_i || 0
  end
end
