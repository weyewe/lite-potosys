class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :office_id 
      t.integer :creator_id 
      
      t.string :title 
      t.text :concept 
      t.boolean :is_concept_finished 
      t.date :concept_finish_date 
      t.integer :concept_finisher_id 
      
      t.boolean :is_property_hunting_finished 
      t.date :property_hunting_finish_date 
      t.integer :property_hunting_finisher_id 
      
      t.date :shoot_date 
      t.date :shoot_starting_date 
      t.date :shoot_ending_date 
      t.string :shoot_location 
      
      t.integer  :total_raw_file
      t.integer :total_project_file 
      t.string :raw_file_storage_location
      t.string :project_file_storage_location 
      
      t.boolean :is_production_started 
      t.date :production_starting_date 
      t.boolean :is_production_finished
      t.date :production_finishing_date
      t.integer :production_starter_id 
      t.integer :production_finisher_id  
      
      t.boolean :is_post_production_started 
      t.date :post_production_starting_date 
      t.boolean :is_post_production_finished 
      t.date :post_production_finishing_date 
      t.integer :post_production_starter_id 
      t.integer :post_production_finisher_id 
      
      
      t.integer :package_id 
      

      t.timestamps
    end
  end
end
