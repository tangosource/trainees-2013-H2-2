class BackersController < ApplicationController
 before_action :set_project_id

 def index
     
 end

 def new
  @backer = @project.backers.new
 end

 private
 def set_project_id
   @project = Project.find(params[:project_id])
 end
 
end