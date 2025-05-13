class HomeController < ApplicationController
  def index
    date = permitted_params[:first_date] || Time.zone.now.strftime("%Y-%m-%d")
    time_indexed_records = get_time_indexed_records(date)
    @records = make_hourly_records(date, time_indexed_records)
  end

  private
  def permitted_params
    params.permit(:first_date, :page)
  end

  def get_time_indexed_records(date)
    Time.use_zone(user_timezone) do
      date_hour_0000 = Time.zone.parse(date + " 00:00")
      date_hour_2300 = Time.zone.parse(date + " 23:00")
      records = Record.where(recorded_at: (date_hour_0000..date_hour_2300))
      records.index_by { |record| record.recorded_at.hour }
    end
  end

  def make_hourly_records(date, time_indexed_records)
    Time.use_zone(user_timezone) do
      date_hours = (0..23).map { |hour| Time.zone.parse(date + " " + format("%02d:00", hour)) }
      (0..23).map do |hour|
        time_indexed_records[hour] || Record.new(recorded_at: date_hours[hour])
      end
    end
  end
end
