class HomeController < ApplicationController
  def index
    @record_titles = make_record_titles
      set_session
    Time.use_zone(session[:timezone]) do
      date = Date.parse(session[:first_date]).advance(days: get_page).strftime("%Y-%m-%d")
      db_records = get_db_records(date)
      @records = make_hourly_records(date, db_records)
    end
  end
end
