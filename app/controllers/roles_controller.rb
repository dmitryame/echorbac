class RolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_client

  # GET /roles
  # GET /roles.xml
  def index
    @roles = @client.roles

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = @client.roles.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = @client.roles.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @client.roles << @role
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to client_role_url(@client, @role) }
        format.xml  { render :xml => @role, :status => :created, :location => [@client, @role] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = @client.roles.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to client_role_url(@client, @role) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = @client.roles.find(params[:id])
    @role.destroy

    respond_to do |format|
      flash[:notice] = 'Role was successfully removed.'      
      format.html { redirect_to(client_roles_url(@client)) }
      format.xml  { head :ok }
    end
  end


private

  def find_client
    @client_id = params[:client_id]
    redirect_to clients_url unless @client_id
    @client = Client.find(@client_id)
  end


end
