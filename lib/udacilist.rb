class UdaciList
  #NOT SURE HOW UdaciListErrors::IndexExceedsListSize calls the module without needing to type include UdaciListErrors
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

  def delete(index)
    @items.delete_at(index - 1)
    nummber_of_items = @items.length
    if nummber_of_items < index
      raise UdaciListErrors::IndexExceedsListSize, "Oops, that item number doesn't exist."
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
end
