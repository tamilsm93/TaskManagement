class TaskNotifyMailer < ApplicationMailer
	default from: 'notifications@example.com'


	def remainder_email(task)
		@task = task
		mail(to: task.assignee.email, subject: 'Task Remainder')
	end
end
