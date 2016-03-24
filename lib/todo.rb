class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @priority = options[:priority].to_s
  end

  def details
    if @priority
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
end
