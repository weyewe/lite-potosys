NumberValidator
class Deliverable < ActiveRecord::Base
  
  attr_accessible :name, :description, :sub_item_quantity, :independent_price, 
            :has_sub_quantity, :office_id, :has_sub_item, :sub_item_name, :independent_sub_item_price
  belongs_to :office
  
  has_many :packages, :through => :deliverable_subcriptions 
  has_many :deliverable_subcriptions 
  
  has_many :projects, :through => :deliverable_items
  has_many :deliverable_items # the subcription from project 
  
  has_many :deliverable_components 
  
  
  validates_presence_of :name 
  
  def set_office(office)
    self.office_id = office.id
    self.save 
  end
  
=begin
  Create Component needs to be monitored for production and post-production
=end

  def create_component(employee, component_params)
    if not employee.has_role?(:admin)
      return nil
    end
    
    component = DeliverableComponent.new 
    component.office_id = self.office_id 
    component.name = component_params[:name]
    component.deliverable_id = self.id 
    component.save 
    
    return component 
  end
  
  
  
  
  
end
