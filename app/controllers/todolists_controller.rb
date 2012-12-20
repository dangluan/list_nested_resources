class TodolistsController < ApplicationController
	before_filter :authenticate_user!
  
	def index
		@todolists = current_user.todolists.paginate(:per_page => 5, :page => params[:page]).order('id DESC')
    respond_to do |format|
       format.html {render layout: false if params[:is_ajax] == "true"}
       format.csv {send_data @todolists.to_csv}
       format.xls {send_data @todolists.to_csv}
     end
	end
	
	def list
	  @todolists = current_user.todolists.paginate(:per_page => 5, :page => params[:page]).all
	  render :partial => "/todolists/list"
	  #render layout: false
	end
	

	def show
		@todolist = current_user.todolists.find(params[:id])
		@checked_items = @todolist.items.where(done: true).find(:all,order: 'position ASC')
		@uncheck_items = @todolist.items.where(done: false).find(:all,order: 'position ASC')
		render layout:false if params[:is_ajax] = "true"
	end
	
	def search_form
	  @todolist = current_user.todolists.new
	  render layout: false  if params[:is_ajax] = "true"
	end
	
	def new
		@todolist = current_user.todolists.new
		render layout: false
	end
	
	def create
		@todolist = current_user.todolists.create(name: params[:name])
		if @todolist.save
			render text: '#list:/todolists/list'
		else
			render text:'failure'
		end
	end
	
	def update
		
	end
	
	def edit_multiple
		@todolists = current_user.todolists.limit(5)
		render layout: false
	end
	
	def multiple_update
		json = params[:json]
		json.each do |name,value|
			name = value['name']
			id = value['id']
			current_user.todolists.find_by_id(id).update_attribute(:name,name)
		end
		#render text: '/todolists?is_ajax=true'
		render text: '#list:/todolists/list'
	end
	
	def edit
	end
	
	def destroy
		@todolist = current_user.todolists.find(params[:id])
		@todolist.destroy
		render text: '/todolists?is_ajax=true'
	end
end
