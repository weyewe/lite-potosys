class CreateDeliverableComponents < ActiveRecord::Migration
  def change
    create_table :deliverable_components do |t| 
      t.string :name
      t.integer :deliverable_id 
      t.boolean :is_deleted => false 
      
      t.integer :office_id

      t.timestamps
    end
  end
end
