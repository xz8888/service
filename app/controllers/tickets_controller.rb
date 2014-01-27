class TicketsController < ApplicationController
  layout false
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :status]
  before_filter :authenticate_user!
  respond_to :json
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.order(id: :desc).all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end
   
  def search

    @tickets = Ticket.select('*')
    if !params['status'].blank?
       conditions = params['status']
       conditions.delete('any')

       if conditions.length > 0
          @tickets = @tickets.where(status: conditions)
       end
    end

    if !params['departments'].blank?
      departments = params['departments'].collect{|ind| ind['id']}
      
      if departments.length > 0
        @tickets = @tickets.where(department_id: departments)
      end
    end

    if !params['reporters'].blank?
      reporters = params['reporters'].collect{|ind| ind['id']}

      if reporters.length > 0
        @tickets = @tickets.where(reporter_id: reporters)
      end
    end

    if !params['assignees'].blank?
      assignees = params['assignees'].collect{|ind| ind['id']}

      if assignees.length > 0
        @tickets = @tickets.where(user_id: assignees)
      end
    end

    if defined?(@tickets)
      @tickets = @tickets.all
    else
      @tickets = Ticket.all
    end
  end

  def updatedate
    @ticket = Ticket.find(params[:id])
    @ticket.update_attributes(params[:type] => params[:new_date])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  # POST /tickets
  # POST /tickets.json
  def create
    @user = current_user
    @ticket = Ticket.new(ticket_params)
   
    if params.has_key?("products")
      #add the products
      @ticket.products.new(params[:products])
    end
    
    if params.has_key?("assignee_id")
      @ticket.user_id = params[:assignee_id][:id]
    end
    
    @ticket.reporter_id = @user.id

    if params.has_key?("department_id")
      theDepartment = Department.find(params[:department_id])
      @ticket.department = theDepartment
    end

    @ticket.status = 'new'

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  #update the ticket status
  def status
    respond_to do |format|
     if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  #add comments method 
  def comment
    @ticket = Ticket.includes(:comments).find(params[:ticket_id])

    @ticket.comments.create(:title => params[:title], 
      :description => params[:description], 
      :is_private => params[:is_private])
    
    respond_to do |format|
      if @ticket.save
        @ticket.reload
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.includes(:comments).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:id, :title, :description, :status, 
         :first_name, :last_name, :address, :city, :province, :postalcode, :department_id,
         :address_confirm, :user_id, :date_in, :country, :phone_number, :reporter_id, :user_id)
    end
end
