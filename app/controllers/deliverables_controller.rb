class DeliverablesController < ApplicationController
  def new
    @new_deliverable = Deliverable.new 
    
    @office = current_office 
  end
  
  def create
    @office = current_office
    
    @new_deliverable =  @office.create_deliverable( current_user, params[:deliverable])
    
    if  @new_deliverable.persisted?
      flash[:notice] = "The component '#{@new_deliverable.name}' has been created." 
      redirect_to new_deliverable_url 
      return 
    else
      flash[:error] = "Hey, do something better"
      
      render :file => "deliverables/new"
    end
  end
  
=begin
  CREATING THE COMPONENT for PRODUCTION + POST PRODUCTION monitoring 
=end
  
  def select_deliverable_to_create_component
    @deliverables = current_office.deliverables 
    add_breadcrumb "Search Deliverable", 'select_deliverable_to_create_component_url' 
  end

end
