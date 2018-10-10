class TagsController < ApplicationController
  before_action :require_user
  before_action :find_tag, except: [:new, :create, :index]

  def index
  	@tags = Tag.all.order("name asc").paginate(page: params[:page], per_page: 20)
  end

  def new
    @tag = Tag.new
  end

  def create
		@tag = Tag.new(tag_params)
		if @tag.save
			redirect_to tags_path, notice: 'Tag Created Successfully.'
		else
      flash[:notice] = @tag.errors.full_messages.first.gsub("Body","")
			render :new
		end
	end

  def edit
  end

  def update
		if @tag.update_attributes(tag_params)
			redirect_to tags_path, notice: 'Tag updated Successfully.'
		else
      flash[:notice] = @tag.errors.full_messages.first
			render :edit
		end
  end

  def show
  end

  def destroy
    if @tag.destroy
		redirect_to tags_path, notice: 'Tag deleted Successfully.'
	else
		render :index
	end
  end

  private
  def find_tag
    @tag = Tag.find_by(id: params[:id])
    redirect_to tags_path unless @tag
  end
	 def tag_params
		params.require(:tag).permit(:name)
	end
end
