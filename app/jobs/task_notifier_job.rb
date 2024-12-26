class TaskNotifierJob < ApplicationJob
  queue_as :default

  def perform(taskid)
    task = Task.find_by(id: taskid)
    if task && task.remind_before_at >= Time.current
      TaskNotifyMailer.remainder_email(task).deliver_now
    end
  end
end
