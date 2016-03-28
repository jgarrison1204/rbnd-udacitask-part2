module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(due_and_start_date, end_date="")
    if end_date == ""
      due_and_start_date ? due_and_start_date.strftime("%D %R") : "No due date"
    else
      dates = due_and_start_date.strftime("%D") if due_and_start_date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      return dates
    end
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
