class Todo
  include Enumerable

  attr_reader :title, :tasks
  def initialize(title)
    @title = title
    @tasks = []
  end

  def add_task(task)
   @tasks << task
  end

  def each(&block)
    @tasks.each(&block)
  end
end

class Task
  attr_reader :name
  def initialize(name)
    @name = name
  end

  # an empty default for a subclass to implement
  def get_time_required
    0 # number of minutes
  end

  def total_number_basic_tasks
    1
  end
end

class ReadingTask < Task
  def initialize(name = nil)
    super(name || 'Read the task out loud')
  end

  def get_time_required
    1
  end
end

class CodingTask < Task
  def initialize
    super('Coding')
  end

  def get_time_required
    15
  end
end

class ProofingTask < Task
  def initialize
    super("Double check to make sure things look good")
  end

  def get_time_required
    5
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
  end

  def get_time_required
    @sub_tasks.map(&:get_time_required).reduce(0, :+)
  end
  
  def [](index)
    @sub_tasks[index]
  end

  def []=(index, task)
    @sub_tasks[index] = task
  end

  def <<(task)
    add_sub_task(task)
  end

  def total_number_basic_tasks
    @sub_tasks.map(&:total_number_basic_tasks).reduce(0, :+)
  end
end

class MilestoneTask < CompositeTask
  def initialize(name)
    super(name)
    add_sub_task ReadingTask.new
    add_sub_task CodingTask.new
    add_sub_task ProofingTask.new
  end
end

todo = Todo.new "Lab 1"
todo.add_task MilestoneTask.new("Milestone 8")
todo.add_task Task.new("Discuss with my partner")
todo.add_task Task.new("Ask the instructor some questions")
todo.add_task ReadingTask.new("Look up the any? method")

puts "Are any composite tasks? %s" % todo.any? {|task| task.total_number_basic_tasks > 1}
puts "Any complex tasks in #{todo.title}: %s" % todo.select {|task| task.total_number_basic_tasks > 1}.map(&:name)
puts "Loop all tasks by todo.each:"
# print all tasks
todo.each do |task|
  puts "- #{task.name}"
end

puts "Look for easy tasks based on time required:"
todo.group_by(&:get_time_required).each do |key, tasks|
  puts "%4s minutes: %s" % [ key, tasks.map(&:name).join(', ') ]
end
