class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : Chronic.parse(options[:due])
    @priority = options[:priority].to_s
    @type = "todo"
  end

  def update_priority_status(update)
    @priority = update
  end

  def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
end
