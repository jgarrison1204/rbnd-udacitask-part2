class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    case type
      when "todo"
        @items.push TodoItem.new(description, options)
      when "event"
        @items.push EventItem.new(description, options)
      when "link"
        @items.push LinkItem.new(description, options)
      else
        raise InvalidItemType, "Oops, we can't upload that type of file."
    end
  end

  def delete(index)
    @items.delete_at(index - 1)
    nummber_of_items = @items.length
    #Not sure this error works. Need to test.
    if nummber_of_items < index
      raise IndexExceedsListSize, "Oops, that item number doesn't exist."
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
