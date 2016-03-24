module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date(date, end_date="")
    dates = date.strftime("%D") if date
    dates << " -- " + end_date.strftime("%D") if !end_date == ""
    dates = "No due date" if !dates
    return dates
  end

  def format_priority
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
  end
end
