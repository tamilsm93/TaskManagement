class TasksController < ApplicationController

	before_action :authenticate_user!, only: [:create, :update, :destroy]

	def index
		tasks = current_user.tasks.all
		render json: {message: 'Tasks', tasks: tasks}, status: :ok
	end


	def create
		task = current_user.tasks.create(task_params)
		if task.save
			render json: {message: 'Task created successfull', task: task}, status: :created
		else
			render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
		end
	end


	def update
		@task = current_user.tasks.find_by(params[:id])
		if @task.update(task_params)
			render json @task
		else
			render json: {message: "check the fields"}
		end
	end


	def destroy
		@task = current_user.tasks.find_by(params[:id])
		@task.destroy
	end

	private
		def task_params
			params.require(:task).permit(:title, :description, :due_date, :priority, :remind_before_at,  :completion_status).merge(assignee_id: current_user.id)
		end
end
