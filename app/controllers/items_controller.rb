class ItemsController < ApplicationController
	before_filter :get_todolist
	def get_todolist
		@todolist = current_user.todolists.find(params[:todolist_id])
	end
	
	def index
		@items = @todolist.items.where(done: false)
		render layout: false if params[:is_ajax] = "true"
	end
	
	def show
		@item = @todolist.items.find(params[:id])
	end
	
	def new
		@item = @todolist.items.new
		render layout: false
	end
	
	def update
		@item = @todolist.items.find(params[:id])
		params[:item][:done] = params[:item][:done] == "1" ? true : false
		if @item.update_attributes(params[:item])
			render :text => 'successful'
		else
			render :text => 'failure'
		end
	end
	
	def create
		@item = @todolist.items.create(name: params[:name])
		if @item.save
			render text: '#uncheck:/todolists/' + (@todolist.id).to_s + '/items'
		else
			render text: 'failure'
		end
	end
	
	def edit
	end
	
	def sort
	  @items = @todolist.items.find(:all,order: 'position ASC')
	  render layout: false
	end
	
	def update_position
	  json = params[:json]
	  json.each do |key,value|
	    id = value['id']
	    position = value['position']
	    @todolist.items.find_by_id(id).update_attribute(:position,position)
	  end
	  render text: '/todolists/' + (@todolist.id).to_s
	end
	
	def edit_multiple_item
		@items = @todolist.items.find(:all,order: 'position ASC')
		render layout: false
	end
	
	def multiple_update_items
		json = params[:json]
		json.each do |name,value|
			name = value['name']
			id = value['id']
			@todolist.items.find_by_id(id).update_attribute(:name,name)
		end
		render text: '#list:/todolists/' + (@todolist.id).to_s + '?is_ajax=true'
	end
	
	def destroy
		@item = @todolist.items.find(params[:id])
		@item.destroy
		render text: 'ok'
	end
end
