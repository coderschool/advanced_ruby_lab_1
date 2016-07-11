class Todo
  attr_accessor :formatter, :title, :items

  def initialize(formatter = nil, &block)
    @title = "Todo"
    @items = ["Decide supervisor and driver roles", "Implement Milestone 1"]
    if block_given?
      @formatter = block
    else
      @formatter = formatter
    end
  end

  # delegate!
  def display
    if formatter.respond_to?(:call)
      formatter.call(self)
    else
      formatter.display(self)
    end
  end
end

class Formatter
  def display(context)
    raise "TO BE IMPLEMENTED"
  end
end

class HtmlFormatter < Formatter
  def render_title(title)
    "<title>#{title}</title>"
  end

  def render_items(items)
    s = "<ul>\n"
    items.each do |item|
      s << "      <li>#{item}</li>\n"
    end
    s << "    </ul>"
  end

  def display(context)
    puts %{\
<html>
  <head>
    #{render_title(context.title)}
  </head>
  <body>
    #{render_items(context.items)}
  </body>
</html>}
  end
end

class PlainTextFormatter < Formatter
  def render_title(title)
    puts "*** #{title} ***"
  end

  def render_items(items)
    items.each do |item|
      puts "- #{item}"
    end
  end

  def display(context)
    render_title(context.title)
    render_items(context.items)
  end
end

todo = Todo.new(HtmlFormatter.new)
todo.display

todo = Todo.new(PlainTextFormatter.new)
todo.display

todo = Todo.new do |context|
  s = "# #{context.title}\n"
  context.items.each do |item|
    s << "- [ ] #{item}\n"
  end
  puts s
end
todo.display
