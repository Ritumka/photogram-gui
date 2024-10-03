class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "/photo_templates/index" })
  end

  def show
    url_id = params.fetch("path_id")

    @the_photo = Photo.where({ :id => url_id }).at(0)
  
    render({ :template => "/photo_templates/show" })
  end

  def create
    @new_photo = Photo.new
    @new_photo.image = params.fetch("input_image")
    @new_photo.caption = params.fetch("input_caption")
    @new_photo.owner_id = params.fetch("input_owner_id")

    @new_photo.save
    redirect_to("/photos/" + @new_photo.id.to_s, { :notice => "Photo added successfully." })
  end

  def update
    the_id = params.fetch("path_id")
    @the_photo = Photo.where({ :id => the_id }).at(0)

    @the_photo.image = params.fetch("input_image")
    @the_photo.caption = params.fetch("input_caption")

    @the_photo.save
    redirect_to("/photos/#{@the_photo.id}", { :notice => "Photo updated successfully."} )
  end

  def addcomment
    the_id = params.fetch("path_id")
    @the_photo = Photo.where({ :id => the_id }).at(0)

    @new_comment = Comment.new

    @the_photo.id = params.fetch("input_photo_id")
    @new_comment.photo_id = @the_photo.id
    @new_comment.author_id = params.fetch("input_author_id")
    @new_comment.body = params.fetch("input_comment")

    @new_comment.save
    redirect_to("/photos/#{@the_photo.id}", { :notice => "Comment added successfully."} )
  end

  def destroy
    the_id = params.fetch("path_id")
    
    @the_photo = Photo.where({ :id => the_id }).at(0)

    @the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end

end
