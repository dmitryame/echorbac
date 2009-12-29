class SubjectsController < ApplicationController
  before_filter :authenticate_user!

  before_filter :find_client, :except => :login


  # GET /subjects
  # GET /subjects.xml
  def index
    @subjects = @client.subjects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subjects }
    end
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show
    @subject = @client.subjects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject }
    end
  end

  # GET /subjects/new
  # GET /subjects/new.xml
  def new
    @subject = Subject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subject }
    end
  end

  # GET /subjects/1/edit
  def edit
    @subject = @client.subjects.find(params[:id])
  end

  # POST /subjects
  # POST /subjects.xml
  def create
    @subject = Subject.new(params[:subject])

    respond_to do |format|
      if @client.subjects << @subject && @client.save && @subject.save
        if @subject.respond_to?(:confirm!)
          flash[:success] = t('devise.confirmations.send_instructions')
          sign_in @subject if @subject.class.confirm_within > 0
        else
          flash[:success] = t('flash.users.create.notice', :default => 'User was successfully created.')
        end
        
        format.html { redirect_to client_subject_url(@client, @subject) }
        format.xml  { render :xml => @subject, :status => :created, :location => [@client, @subject] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.xml
  # def update
  #   @subject = @client.subjects.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @subject.update_attributes(params[:subject])
  #       flash[:notice] = 'Subject was successfully updated.'
  #       format.html { redirect_to client_subject_url(@client, @subject) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /subjects/1
  # DELETE /subjects/1.xml
  def destroy
    @subject = @client.subjects.find(params[:id])
    @subject.destroy

    respond_to do |format|
      flash[:notice] = 'Subject was successfully removed.'      
      format.html { redirect_to(client_subjects_url(@client)) }
      format.xml  { head :ok }
    end
  end


  def login    
    # preallowed_client = Client.preallowed_client
    # subject = preallowed_client.subjects.find(session[:subject_id]) 
    redirect_to clients_path
  end


  # custom restful methods 
  # this method is a core of figuring out if a particulalr subject has access to a particular resource.
  # TODO: optimize performance    
  #this method should never fails, returns either <a>0<a> or <a>1</a>  
  def has_access
    # be careful, the :id param is actually expected to be a subject name
    @subject = Subject.find_by_name_and_client_id(params[:id],params[:client_id])
    # @resource = Resource.find_by_name_and_client_id(params[:resource],params[:client_id])    
    roles = @subject.roles    
    
    puts @client.resources.all(:roles => roles).size
      
    @client.resources.all(:roles => roles).each do |resource|      
        if params[:resource] =~ Regexp.new(resource.name) #the resource string will be matched agains regular expression -- very powerful
          render :text => "<a>1</a>" 
          return
        end
    end
    # if no matching resouces found by the end of the iteration, return false
    render :text => "<a>0</a>"
  end

  #this method should never fails, returns either <a>0<a> or <a>1</a>  
  # def is_subject_in_role
  #   @subject = @client.subjects.find(params[:id])    
  #   number_of_roles = @subject.roles.count :conditions => ["role_id = ?", params[:role_id]] 
  #   if number_of_roles == 1
  #     render :text => "<a>1</a>" 
  #   else
  #     render :text => "<a>0</a>" 
  #   end
  # end

  def add_role
    @subject = @client.subjects.find(params[:id])
    @role = @client.roles.find(params[:role_id])
    respond_to do |format|
      if @subject.roles << @role.id
        @subject.save
        format.xml { head :ok }
        format.js
      else
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  def remove_role
    @subject = @client.subjects.find(params[:id])  
    @role = @client.roles.find(params[:role_id])
    respond_to do |format|
      if @subject.roles.delete(@role.id)
        @subject.save
        format.xml  { head :ok }
        format.js
      else
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end        
    end
  end


private

  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end


end
