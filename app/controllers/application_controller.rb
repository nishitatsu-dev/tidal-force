class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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

  def get_db_records(date)
    date_hour_0000 = Time.zone.parse(date + " 00:00")
    date_hour_2300 = Time.zone.parse(date + " 23:00")
    Record.where(user_id: current_user.id).where(recorded_at: (date_hour_0000..date_hour_2300))
  end

  def make_hourly_records(date, db_records)
    time_indexed_records = db_records.index_by { |record| record.recorded_at.hour }
    date_hours = (0..23).map { |hour| Time.zone.parse(date + " " + format("%02d:00", hour)) }
    (0..23).map do |hour|
      time_indexed_records[hour] || Record.new(recorded_at: date_hours[hour])
    end
  end

  def make_record_titles
    column_number_indexed_titles = RecordTitle.where(user_id: current_user.id).index_by { |title| title.column_number }
    (0..5).map do |column_number|
      column_number_indexed_titles[column_number] || RecordTitle.new(column_number: column_number, title: "Column_#{column_number + 1}")
    end
  end
end
