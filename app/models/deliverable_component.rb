class DeliverableComponent < ActiveRecord::Base
  belongs_to :deliverable 
  validates_presence_of :name
  
  has_many :deliverable_component_subcriptions  
  has_many :deliverable_items, :through => :deliverable_component_subcriptions
end
