class WorkspaceController < ApplicationController

	def index
		@workspace = current_user.workspaces
	end


	def create
		@workspace = current_user.workspaces(workspace_params)
	end

	private

	def workspace_params
		params(:workspace).permit(:name, :url, :api_key)
	end
end
