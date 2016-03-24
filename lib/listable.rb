module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(date, end_date="")
    dates = date.strftime("%D") if date
    dates << " -- " + end_date.strftime("%D") if !end_date == ""
    dates = "No due date" if !dates
    return dates
  end

  def format_priority(priority)
    case priority
      when "high"
        value = " ⇧"
      when "medium"
        value = " ⇨"
      when  "low"
        value = " ⇩"
      when ""
        value = ""
      return value
    end
  end
end
