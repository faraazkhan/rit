class UsersController < ApplicationController
  before_filter :get_user, :only => [:index, :new, :edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show, :new, :destroy, :edit, :update]
  
  # GET /users
  # GET /users.xml
  # GET /users.json
  
  def index 
    @users = User.accessible_by(current_ability, :index).limit(20)
    respond_to do |format|
      format.json { render :json => @users }
      format.xml
      format.html
    end
  end
  
  def new 
    respond_to do |format|
      format.json { render :json => @user }
      format.xml { render :xml => @user }
      format.html
    end
  end
    
    def show
      respond_to do |format|
        format.json { render :json => @user }
        format.xml
        format.html
      end
      
    rescue ActiveRecord::RecordNotFound
      respond_to_not_found(:json, :xml, :html)
    end
    
    def destroy
      @user.destroy!
      
      respond_to do |format|
        format.json { respond_to_destroy(:ajax) }
        format.xml { head :ok }
        format.html { respond_to_destroy(:html) }
      end
    end
    
    def create 
      @user = User.new(params[:user])
    
      if @user.save
        respond_to do |format|
          format.json { render :json => @user.to_json, :status => 200 }
          format.xml { head :ok }
          format.html { redirect_to :action => :index }
        end
      else 
        respond_to do |format|
          format.json { render :text => "Could not create user", :status => :unprocessable_entity }
          format.xml { head :ok }
          format.html { render :action => :new, :status => :unprocessable_entity }
        end
      end
    end
    
    def accessible_roles
       @accessible_roles = Role.accessible_by(current_ability,:read)
     end

     # Make the current user object available to views
     #----------------------------------------
     def get_user
       @current_user = current_user
     end
  end


