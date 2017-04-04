
#VIEW FRONT PAGE CREATED POST
post "/posts" do 
  title = params[:title]
  body = params[:body]
  tags = params[:tags] 
  		@post = Post.new(title: title, body: body , date: Time.now)
  	 tags.split(',').each do |tag|
    	 	@new_tag = tag.strip
        verify_tag = Tag.find_by(tag: @new_tag)
        if verify_tag
          @post.tags << verify_tag
        else
      	 	tag = Tag.new(tag: @new_tag)
      	 	@post.tags << tag
        end
  	 end

  		@post.save

  erb :post
end

#POSTS VIEW
get "/posts_settings" do
 erb :posts
end

post "/posts_settings" do
 redirect ("/posts_settings")
end


#ALL POSTS


post "/all_posts" do
  @all_posts = Post.all
 	erb :all_posts
end


# DELETE POSTS

get "/delete_post" do
  @all_posts = Post.all
  erb :delete_post
end

post "/delete_post" do

  @all_posts = Post.all
  redirect ("/delete_post")
end

get "/post_to_delete/:id" do
  post_to_delete = params[:id]
  real_post_to_delete = Post.find(post_to_delete)
  tag_to_delete = real_post_to_delete.tags

  tag_to_delete.destroy_all
  real_post_to_delete.destroy
  redirect ("/delete_post")
end

#EDIT POSTS

post "/select_post" do
  @all_posts = Post.all
  erb :edit_posts
end

get "/post2edit/:id" do
  post_to_update = params[:id]
  @post2edit = Post.find(post_to_update)
  
erb :post2edit
end



post "/edit_post/:id" do
  @id = params[:id]
  @title = params[:title]
  @body = params[:body]
  @tag = params[:tag]

  @post = Post.find(@id)
  @post.update_attributes(title: @title, body: @body)

  @post_tags = PostTag.where(post_id: @id)

    @post_tags.each do |tag|
       @ttag = tag.tag
      @tag.each_value do |value| 
        @verify_tag = Tag.find_by(tag: value)

        if @verify_tag 
          @post.tags <<  @verify_tag
        else


          @relation = PostTag.find_by(tag_id: @ttag.id, post_id: @id)
          "____Rel_____"*30
          @relation.destroy

          new_tag = Tag.create(tag: value)
          "____NEW_____"*30

           @post.tags << new_tag
          p @post.tags 
          p "*"*30
        end 
      end
    end

 erb :edited_post
end



