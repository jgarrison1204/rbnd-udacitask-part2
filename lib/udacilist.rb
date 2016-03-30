class UdaciList
  #NOT SURE HOW UdaciListErrors::IndexExceedsListSize calls the module without needing to type include UdaciListErrors
  include Listable
  attr_reader :title, :items
  @@priority_levels = ["low", "medium", "high"]

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
      when "todo"
          if (@@priority_levels.include? options[:priority]) || !options[:priority]
            @items.push TodoItem.new(description, options)
          else
            raise UdaciListErrors::InvalidPriorityValue, "Oops, that priority level doesn't exist."
          end
      when "event"
        @items.push EventItem.new(description, options)
      when "link"
        @items.push LinkItem.new(description, options)
      else
        raise UdaciListErrors::InvalidItemType, "Oops, we can't upload that type of file."
    end
  end

  #splat operator to allow multiple deletions at a time.
  def delete(*index)
    index.each do |item|
      if @items.length < item
        raise UdaciListErrors::IndexExceedsListSize, "Oops, that item number doesn't exist."
      end
      @items.delete_at(item - 1)
    end
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(type)
    filter_by_type = @items.select {|filter| filter.type == type}
    if filter_by_type
      @filter_by_type_details = filter_by_type.map {|item_type| item_type.details}
      format_filter_by_type
    else
      "There are no #{type}s in #{@title}"
    end
  end

  def format_filter_by_type
    @table = Terminal::Table.new do |t|
      t << @filter_by_type_details[0].split(",")
      t << :separator
      t << @filter_by_type_details[1].split(",")
      t << :separator
      t << @filter_by_type_details[2].split(",")
    end
    print_format_filter_by_type
  end

  def print_format_filter_by_type
    puts
    @table.title = "List of items for events"
    @table.headings = ['Event', 'Date']
    puts @table
  end

  def update_priority(item, update)
    if @@priority_levels.include? update
      @items.map {|item_in_array| item_in_array.update_priority_status(update) if item_in_array.description == item}
    else
      raise UdaciListErrors::InvalidPriorityValue, "Oops, that priority level doesn't exist."
    end
  end
end
