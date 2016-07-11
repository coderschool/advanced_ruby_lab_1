class Todo
  def initialize
    @title = "Todo"
    @items = ["Decide supervisor and driver roles", "Implement Milestone 1"]
  end

  def display
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
end
