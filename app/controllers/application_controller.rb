class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
  def get_db_records(date)
    date_hour_0000 = Time.zone.parse(date + " 00:00")
    date_hour_2300 = Time.zone.parse(date + " 23:00")
    current_user.records.where(recorded_at: (date_hour_0000..date_hour_2300))
  end

  def make_hourly_records(date, db_records)
    time_indexed_records = db_records.index_by { |record| record.recorded_at.hour }
    date_hours = (0..23).map { |hour| Time.zone.parse(date + " " + format("%02d:00", hour)) }
    (0..23).map do |hour|
      time_indexed_records[hour] || Record.new(recorded_at: date_hours[hour])
    end
  end

  def make_record_titles
    column_number_indexed_titles = current_user.record_titles.index_by { |title| title.column_number }
    (0..5).map do |column_number|
      column_number_indexed_titles[column_number] || RecordTitle.new(column_number: column_number, title: "Column_#{column_number + 1}")
    end
  end
end
