class Todo
  def initialize
    @title = "Todo"
    @items = ["Decide supervisor and driver roles", "Implement Milestone 1"]
  end

  def render_title
    raise "Not allowed on abstract class"
  end

  def render_items
    raise "Not allowed on abstract class"
  end

  def display
    raise "Not allowed on abstract class"
  end
end

class HtmlTodo < Todo
  def render_title
    "<title>#{@title}</title>"
  end

  def render_items
    s = "<ul>\n"
    @items.each do |item|
      s << "      <li>#{item}</li>\n"
    end
    s << "    </ul>"
  end

  def display
    puts %{\
<html>
  <head>
    #{render_title}
  </head>
  <body>
    #{render_items}
  </body>
</html>}
  end
end

class PlainTodo < Todo
  def render_title
    puts "*** #{@title} ***"
  end

  def render_items
    @items.each do |item|
      puts "- #{item}"
    end
  end

  def display
    render_title
    render_items
  end
end

todo = HtmlTodo.new
todo.display
todo = PlainTodo.new
todo.display

# Pros:
# - Easy to add a new formatter
# - No need for conditional statements
# - Separate logic in separate classes
# Cons:
# - Need to know which class to use before hand
# - More code to write
