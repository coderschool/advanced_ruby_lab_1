class Todo
  attr_accessor :formatter

  def initialize(formatter)
    @title = "Todo"
    @items = ["Decide supervisor and driver roles", "Implement Milestone 1"]
    @formatter = formatter
  end

  # delegate!
  def display
    formatter.display(@title, @items)
  end
end

class Formatter
  def display(title, items)
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

  def display(title, items)
    puts %{\
<html>
  <head>
    #{render_title(title)}
  </head>
  <body>
    #{render_items(items)}
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

  def display(title, items)
    render_title(title)
    render_items(items)
  end
end

todo = Todo.new(HtmlFormatter.new)
todo.display

todo = Todo.new(PlainTextFormatter.new)
todo.display

# Pros:
# - Simple Todo model
# - Can change formatter half way
# - No need for conditional statements
# - Separate logic in separate classes
# Cons:
# - Need to know which class to use before hand
# - More code to write
