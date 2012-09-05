class DeliverableComponentsController < ApplicationController
  def new
    @new_deliverable_component = DeliverableComponent.new 
    @deliverable = Deliverable.find_by_id params[:deliverable_id]
    @deliverable_components = @deliverable.deliverable_components.order("created_at DESC")
    @office = current_office 
    
    add_breadcrumb "Search Deliverable", 'select_deliverable_to_create_component_url' 
    set_breadcrumb_for @deliverable, 'new_deliverable_deliverable_component_url' + "(#{@deliverable.id})", 
          "Create/Delete Component"
  end
  
  def create
    @office = current_office
    @deliverable = Deliverable.find_by_id params[:deliverable_id]
    @new_deliverable_component =  @deliverable.create_component( current_user, params[:deliverable_component])
    
    if  @new_deliverable_component.persisted?
      flash[:notice] = "The component '#{@new_deliverable_component.name}' has been created." 
      redirect_to new_deliverable_deliverable_component_url(@deliverable) 
      return 
    else
      flash[:error] = "Hey, do something better"
      @deliverable_components = @deliverable.deliverable_components.order("created_at DESC")
      add_breadcrumb "Search Deliverable", 'select_deliverable_to_create_component_url' 
      set_breadcrumb_for @deliverable, 'new_deliverable_deliverable_component_url' + "(#{@deliverable.id})", 
            "Create/Delete Component"
      
      render :file => "deliverable_components/new"
    end
  end
end
