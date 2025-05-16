class HomeController < ApplicationController
  def index
    set_timezone_and_first_date
    Time.use_zone(session[:timezone]) do
      date = Date.parse(session[:first_date]).advance(days: get_page).strftime("%Y-%m-%d")
      time_indexed_records = get_time_indexed_records(date)
      @records = make_hourly_records(date, time_indexed_records)
    end
  end

  private
  def permitted_params
    params.permit(:page)
  end

  def get_page
    permitted_params[:page].to_i || 0
  end

  def get_time_indexed_records(date)
      date_hour_0000 = Time.zone.parse(date + " 00:00")
      date_hour_2300 = Time.zone.parse(date + " 23:00")
      records = Record.where(recorded_at: (date_hour_0000..date_hour_2300))
      records.index_by { |record| record.recorded_at.hour }
  end

  def make_hourly_records(date, time_indexed_records)
      date_hours = (0..23).map { |hour| Time.zone.parse(date + " " + format("%02d:00", hour)) }
      (0..23).map do |hour|
        time_indexed_records[hour] || Record.new(recorded_at: date_hours[hour])
      end
  end
end
