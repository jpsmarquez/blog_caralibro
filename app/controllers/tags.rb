get "/tags_settings" do
	erb :tags_settings
end

post "/tags_settings" do
	redirect ("/tags_settings")
end

post "/all_tags" do
	@all_tags = Tag.all
	erb :all_tags
end

post "/search_tags" do
    @tags = params[:search_tags]
  	@tags.split(',').each do |tag|
  	@new_tag = tag.strip
  	@found_tags = Tag.where(tag: @new_tag)
  	end 
		if @found_tags.empty?
		erb :tag_not_found
		else
	    erb :specific_tag
	    end
end



get "/link_tag/:tag" do
 @tags = params[:tag]
 @found_tags = Tag.where(tag: @tags)
 erb :specific_tag
end