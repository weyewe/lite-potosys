class DeliverableComponentSubcription < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :drafts  # to track the production
  belongs_to :deliverable_component
  belongs_to :deliverable_item 
  
  # how can we track the post_production?
  # does every deliverable component need purchase order on their own? 
  # or separate?
  # still, the tracking is using the PurchaseOrder to supplier.. 
  # ok, make 2 modes: combined purchase order for delivery item || separate purchase order  for each delivery component  
  
end
