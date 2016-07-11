class Todo
  def initialize
    @title = "Todo"
    @items = ["Decide supervisor and driver roles", "Implement Milestone 1"]
  end

  def display_html
    puts %{
<html>
  <head>
    <title>Todo</title>
  </head>
  <body>
    <ul>
}.strip
    @items.each do |item|
      puts "      <li>#{item}</li>"
    end
    puts %{\
    </ul>
  </body>
</html>
}
  end

  def display_plain
    puts "*** #{@title} ***"
    @items.each do |item|
      puts "- #{item}"
    end
  end

  def display(format = :html)
    method = "display_#{format}"
    send(method) if respond_to?(method)
  end
end
