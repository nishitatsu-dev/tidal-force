module ApplicationHelper
  def extract_date_hour(record)
    record.recorded_at.in_time_zone(session[:timezone]).strftime("%m-%d_%H")
  end

  def display_line_breaks(original_text)
    original_text.nil? ? nil : safe_join(original_text.split("\n"), tag.br)
  end
end
