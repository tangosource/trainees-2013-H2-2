class ProjectsController < ApplicationController
  def index
    @project = Project.new
    @subcategories = Subcategory.all
  end

  def new
    @project = Project.new
    @subcategories = Subcategory.all
  end

  def show
    @project = Project.find(params[:id])
    @count = ((@project.created_at + @project.period.days).to_date - Time.now.to_date).to_i 
    @count = 0 unless @count > 0 
    @pledges = Pledge.where(:project_id => @project.id)
    @faqs    = Faq.where(project_id: [params[:id]])
    @project = Project.find(params[:id]);
  end

  def create
    @subcategories = Subcategory.all
    @project = Project.new(project_params)
    category = Subcategory.find(" #{@project.subcategory_id}")
    @project.category_id = category.category_id
    if (@project.video =~ /^(https?:\/\/)?(www\.)?youtube.com\/watch\?v=([a-z0-9-]+)/i) 
     @project.video = format_video(@project.video)
    end
    if @project.save 
      redirect_to @project
    else
      render "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
    video = @project.video.split("embed/")
    video_user_format = "http://www.youtube.com/watch?v=" + video[1]
    @video = video_user_format
    @subcategories = Subcategory.all
  end

  def update
    @subcategories = Subcategory.all
    @project = Project.find(params[:id])
    if (project_params['video'] =~ /^(https?:\/\/)?(www\.)?youtube.com\/watch\?v=([a-z0-9-]+)/i) 
      @project.update(:video => format_video(project_params['video']))
    end  
    if  @project.update_attributes(project_params_update)
      category = Subcategory.find(" #{@project.subcategory_id}")
      category_id = category.category_id
      @project.update(:category_id => category_id)
      redirect_to show
    else
      render 'edit'
    end
  end
 

private
  def format_video(video)
    video_parts = video.split('=')
    video_format = "//www.youtube.com/embed/" + video_parts[1]
  end

  
  def project_params
    params.require(:project).permit(:name,:description, :content, :picture, :video, :goal, :period, :subcategory_id, :location)
  end
   
  def project_params_update
    params.require(:project).permit(:description, :content, :picture, :subcategory_id)
  end



end
