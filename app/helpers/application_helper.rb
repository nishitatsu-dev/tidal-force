module ApplicationHelper
  def extract_date_hour(record)
    record.recorded_at.in_time_zone(session[:timezone]).strftime("%m-%d_%H")
  end
end
