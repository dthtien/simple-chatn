module ApplicationHelper
  def display_time(time)
    if (Time.zone.now - time) > 1.day
      l(time, format: "%d %B at %H:%M")
    else
      l(time, format: "%H:%M")
    end
  end
end
