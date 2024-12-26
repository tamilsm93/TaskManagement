class WorkspacesController < ApplicationController

	before_action :authenticate_user!

	def index

		workspaces = current_user.workspaces.all
		render json: {message: 'workspaces' ,workspaces: workspaces}
	end


	def create
		api_key = 'WKS-'+ SecureRandom.urlsafe_base64
		workspace = current_user.workspaces.build(workspace_params.merge(api_key: api_key))
		if workspace.save
			render json: {message: 'workspace created successfully', workspace: workspace}, status: :created
		else
			render json: {errors: workspace.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def add_member
		workspace_id = params[:id].to_i
		role = params[:membership][:role]
		user_id = params[:membership][:user_id]
		member = Membership.create(workspace_id:  workspace_id, role: role, user_id: user_id)
		if member.save
			render json: {message: 'member added successfully', member: member}
		else
			render json: {message: 'member.errors.full_messages', member: member}
		end
	end

	private
	def workspace_params
		params.require(:workspace).permit(:name, :url)
	end
end
