module ApplicationHelper
  def extract_date_hour(record)
    record.recorded_at.in_time_zone(session[:timezone]).strftime("%m-%d_%H")
  end

  def display_line_breaks(original_text)
    original_text.nil? ? nil : safe_join(original_text.split("\n"), tag.br)
  end

  def each_home_index_path
    user_signed_in? ? memo_index_home_path(current_user.id) : home_index_path
  end
end
