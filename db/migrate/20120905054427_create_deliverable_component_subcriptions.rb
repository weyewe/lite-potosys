class CreateDeliverableComponentSubcriptions < ActiveRecord::Migration
  def change
    create_table :deliverable_component_subcriptions do |t|
      t.integer :deliverable_component_id 
      t.integer :deliverable_item_id 
      
      t.integer :project_id 

      t.timestamps
    end
  end
end
