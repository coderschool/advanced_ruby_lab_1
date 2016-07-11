class Task
  attr_reader :name
  def initialize(name)
    @name = name
  end

  # an empty default for a subclass to implement
  def get_time_required
    0 # number of minutes
  end
end

class ReadingTask < Task
  def initialize
    super('Read the task out loud')
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
end

class MilestoneTask < CompositeTask
  def initialize(name)
    super(name)
    add_sub_task ReadingTask.new
    add_sub_task CodingTask.new
    add_sub_task ProofingTask.new
  end
end

milestone = MilestoneTask.new 'Milestone 8'
puts "Time required for #{milestone.name}: #{milestone.get_time_required} minutes"
