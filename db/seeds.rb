puts "Photography Studio Management: lite-potosys: striped down version of potosys"

puts "\n*********APPLICATION WIDE SETUP*********\n"
puts "creating roles"
admin_role = Role.create :name => USER_ROLE[:admin] 


# crew is defined as the people flying to the shoot location, shooting for the client 
crew_role = Role.create :name => USER_ROLE[:crew]



project_manager_head_role = Role.create :name => USER_ROLE[:project_manager_head]
project_manager_role = Role.create :name => USER_ROLE[:project_manager]

account_executive_role = Role.create :name => USER_ROLE[:account_executive]

# production => can be designer + editor (project role specific) 
production_head_role = Role.create :name => USER_ROLE[:production_head]
production_role = Role.create :name => USER_ROLE[:production]


# maybe the post production head is not even needed anymore.. too small for such functional division
post_production_head_role = Role.create :name => USER_ROLE[:post_production_head]
post_production_role = Role.create :name => USER_ROLE[:post_production]

# PROJECT_ROLE = {
#   :account_executive => "AccountExecutive",
#   :project_manager => "ProjectManager" ,
#   :designer => "Designer",
#   :editor => "Editor",
#   :main_crew => "Crew",  # crew is those people going out to take picture (handling the supply side)
#   :assisting_crew => "AssistingCrew", 
#   :quality_control => "QC",  # QC is the person responsible to ensure that the quality satisfies company's standard 
#   :post_production => "PostProduction"
# }


account_executive_project_role = ProjectRole.create(:name => PROJECT_ROLE[:account_executive] )
project_manager_project_role = ProjectRole.create(:name => PROJECT_ROLE[:project_manager] )
designer_project_role = ProjectRole.create(:name => PROJECT_ROLE[:designer] )
editor_role = ProjectRole.create(:name => PROJECT_ROLE[:editor] )
main_crew_project_role =  ProjectRole.create(:name => PROJECT_ROLE[:main_crew] )
assisting_crew_project_role =  ProjectRole.create(:name => PROJECT_ROLE[:assisting_crew] )
quality_control_project_role =  ProjectRole.create(:name => PROJECT_ROLE[:quality_control] )
post_production_project_role =  ProjectRole.create(:name => PROJECT_ROLE[:post_production] )


puts "\n*********OFFICE WIDE SETUP***********"
puts "creating office"
office = Office.create :name => COMPANY_NAME

if office.nil?
  puts "3333 the office is nil"
else
  puts "The office is not nil, the id is #{office.id}"
end


puts "creating user"
admin_employee = office.create_main_user( [admin_role,project_manager_head_role,  
                            production_head_role,  post_production_head_role], 
                  :email => 'admin@gmail.com',
                  :password => 'willy1234',
                  :password_confirmation => 'willy1234'  ) 
 
   
                    
project_manager_head = office.create_user( [project_manager_head_role], 
                    :email => 'pm_head@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
project_manager  = office.create_user( [project_manager_role], 
                    :email => 'pm1@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
                    
pm2  = office.create_user( [project_manager_role], 
                    :email => 'pm2@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
 
                    
production_head = office.create_user( [production_head_role], 
                    :email => 'prod_head@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
production_1 = office.create_user( [production_role], 
                    :email => 'prod_1@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
production_2 = office.create_user( [production_role], 
                    :email => 'prod_2@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
    
pp_head = office.create_user( [post_production_head_role], 
                    :email => 'pp_head@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
pp1 = office.create_user( [post_production_role], 
                    :email => 'pp1@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
                    
pp2 = office.create_user( [post_production_role], 
                    :email => 'pp2@gmail.com',
                    :password => 'willy1234',
                    :password_confirmation => 'willy1234'  )
 
account_executive =   office.create_user( [account_executive_role], 
                      :email => 'ae1@gmail.com',
                      :password => 'willy1234',
                      :password_confirmation => 'willy1234'  )
 
ae2 =   office.create_user( [account_executive_role], 
                      :email => 'ae2@gmail.com',
                      :password => 'willy1234',
                      :password_confirmation => 'willy1234'  )
         

puts "creating crew"
crew1 = office.create_user( [crew_role], 
                  :email => 'crew1@gmail.com',
                  :password => 'willy1234',
                  :password_confirmation => 'willy1234'  )
                  
crew2 = office.create_user( [crew_role], 
                  :email => 'crew2@gmail.com',
                  :password => 'willy1234',
                  :password_confirmation => 'willy1234'  )
                  
crew3 = office.create_user( [crew_role], 
                  :email => 'crew3@gmail.com',
                  :password => 'willy1234',
                  :password_confirmation => 'willy1234'  )


     
puts "\n\n***DONE WITH CORE OFFICE USER, ROLE  and PROJECT ROLE*****\n\n"

puts "Project-Specific Objects: supplier, package, deliverable,  deliverable component"

puts "create supplier"
(1..10).each do |count|
  office.create_supplier( admin_employee, :name => "Supplier #{count}") 
end


puts "\n creating deliverable"
#  for photos
portrait_album_deliverable = office.create_deliverable(admin_employee,  
                      :name => "Portrait Album", 
                      :independent_price => "5000000",
                      :has_sub_item => true,
                      :sub_item_name => "Edited Pic",
                      :sub_item_quantity => '40',
                      :independent_sub_item_price => "100000")
                      
cd_high_res_pics_deliverable = office.create_deliverable( admin_employee,
              :name => "CD with high res pics", 
              :independent_price => "500000",
              :has_sub_item => true,
              :sub_item_name => "Edited Pic",
              :sub_item_quantity => '30',
              :independent_sub_item_price => '70000')
framed_canvas_60_x_40_deliverable = office.create_deliverable(admin_employee,  :name => "Framed Canvas 60x40cm", :independent_price => "1500000", :has_sub_item => false)
photoclip_deliverable = office.create_deliverable( admin_employee, :name => "Photoclip with selected photos", :independent_price => "50000",:has_sub_item => false)

# for videos
original_video_copy = office.create_deliverable(admin_employee, :office_id => office.id, :name => "Original Video Copy", :has_sub_item => false)

puts "****Create DeliverableComponent****"
portrait_album_deliverable.create_component( admin_employee, :name => "Cover Album")
portrait_album_deliverable.create_component( admin_employee, :name => "Content ")
portrait_album_deliverable.create_component( admin_employee, :name => "Packaging")

cd_high_res_pics_deliverable.create_component( admin_employee, :name => "CD Cover")
cd_high_res_pics_deliverable.create_component( admin_employee, :name => "Casing Cover")
cd_high_res_pics_deliverable.create_component( admin_employee, :name => "Content")

framed_canvas_60_x_40_deliverable.create_component( admin_employee, :name => "Frame")
framed_canvas_60_x_40_deliverable.create_component( admin_employee, :name => "Image") 

photoclip_deliverable.create_component( admin_employee, :name => "PhotoClip")
photoclip_deliverable.create_component( admin_employee, :name => "CD Cover")

original_video_copy.create_component( admin_employee, :name => "CD Cover")
original_video_copy.create_component( admin_employee, :name => "Edited Video")


puts "\n*Assign deliverable to Package*\n"

# puts "\n creating package"
puts "create package"
package_1 = office.create_package( admin_employee, :name => "Junia Candid Photo Sessions", 
              :base_price => "1000000",
              :number_of_crew => 2,  
              :is_crew_specific_pricing => true ) # if it is crew specific, the client can choose the main crew 
              
package_1.assign_deliverable(admin_employee, :deliverable_id => cd_high_res_pics_deliverable.id, :package_specific_sub_item_quantity => '15' )
package_1.assign_deliverable(admin_employee, :deliverable_id => framed_canvas_60_x_40_deliverable.id, :package_specific_sub_item_quantity => '15' )

 

puts "create package 2: nomina baby wash"

package_2 = office.create_package( admin_employee, :name => "Junia Maternity Sessions", 
              :base_price => "2000000",
              :number_of_crew => 1,  
              :is_crew_specific_pricing => true ) # if it is crew specific, the client can choose the main crew 
              
package_2.assign_deliverable(admin_employee, :deliverable_id => cd_high_res_pics_deliverable.id, :package_specific_sub_item_quantity => '15' )
package_2.assign_deliverable(admin_employee, :deliverable_id => framed_canvas_60_x_40_deliverable.id, :package_specific_sub_item_quantity => '15' )

 


puts "create package 3: nomina mommy and child"

package_3 = office.create_package( admin_employee, :name => "Junia Mommy and Child", 
              :base_price => "2000000",
              :number_of_crew => 1,  
              :is_crew_specific_pricing => true ) # if it is crew specific, the client can choose the main crew 
              
package_3.assign_deliverable(admin_employee, :deliverable_id => cd_high_res_pics_deliverable.id, :package_specific_sub_item_quantity => '15' )
package_3.assign_deliverable(admin_employee, :deliverable_id => framed_canvas_60_x_40_deliverable.id, :package_specific_sub_item_quantity => '15' )

 
 
 