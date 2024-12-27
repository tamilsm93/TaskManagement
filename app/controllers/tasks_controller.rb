class TasksController < ApplicationController

	before_action :authenticate_user!, only: [:create, :update, :destroy]

	def index
		tasks = current_user.tasks.page(params[:page]).per(2)
		render json: {message: 'Tasks', tasks: tasks}
	end


	def create
		task = current_user.tasks.create(task_params)
		if task.save
			render json: {message: 'Task created successfully', task: task}, status: :created
		else
			render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
		end
	end


	def update
		task = current_user.tasks.find_by(params[:id])
		if task.update(task_params)
			render json: {message: 'Task updated successfully', task: task}
		else
			render json: {message: "check the fields"}
		end
	end


	def destroy
		task = current_user.tasks.find_by(params[:id])
		if task.destroy
			render json: {message: 'Task deleted successfully', task: task}
		else
			render json: {errors: task.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def category
		id = params[:id].to_i
		tasks = current_user.tasks.find_by(category_id: id)
		render json: {message: 'task based on category', tasks: tasks}
	end

	def sort_tasks
		tasks = Task.joins(:category).order('categories.name ASC').pluck('tasks.title', 'categories.name')

		tasks = tasks.map do |task| {
			task_title: task[0],
			category_name: task[1]
		}
	end
	render json: tasks
	end


	def search
		tasks = Task.all
		if params[:tasks][:title].present?
			tasks = tasks.where(title: params[:tasks][:title])
		elsif params[:tasks][:due_date].present? 
			tasks = tasks.where(due_date: params[:tasks][:due_date])
		elsif params[:tasks][:assignee_id].present?
			tasks = tasks.where(assignee_id: params[:tasks][:assignee_id])
		elsif params[:tasks][:completion_status].present?
			tasks = tasks.where(completion_status: params[:tasks][:completion_status])
		elsif params[:tasks][:description].present?
			tasks = tasks.where(description: params[:tasks][:description])
		else
			tasks = tasks.all
		end
		render json: tasks
	end

	private
	def task_params
		params.require(:task).permit(:title, :description, :due_date, :priority, :remind_before_at,  :completion_status, :category_id).merge(assignee_id: current_user.id)
	end
end
