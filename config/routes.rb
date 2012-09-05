LitePotosys::Application.routes.draw do
  devise_for :users
  root :to => 'home#homepage'

  resources :suppliers 
  
=begin
  CREATING MASTER DATA for resources 
=end
  resources :packages do 
    resources :package_assignments 
    resources :deliverable_subcriptions 
  end
  
  resources :deliverables do
    resources :deliverable_components
  end
  
 
=begin
  SETUP, Create User +  Office Role
=end

  match 'new_employee_creation' => "offices#new_employee_creation", :as => :new_employee_creation
  match 'create_employee' => "offices#create_employee" , :as => :create_employee, :method => :post 
  match 'show_role_for_employee/:employee_id' => "offices#show_role_for_employee" , :as => :show_role_for_employee
  match 'assign_role_for_employee' => "offices#assign_role_for_employee" , :as => :assign_role_for_employee, :method => :post


=begin
  MASTER DATA, company specific
  CREATE DELIVERABLE  + PACKAGE
=end
  match 'select_deliverable_to_create_component' => 'deliverables#select_deliverable_to_create_component', :as => :select_deliverable_to_create_component
  

  match 'create_package_assignment' => 'package_assignments#create_package_assignment', :as => :create_package_assignment, :method => :post 
  match 'edit_price_package/:package_id/crew/:crew_id' => 'package_assignments#edit_crew_specific_package_price', :as => :edit_crew_specific_package_price, :method => :post 

  match 'contact_person_info/:supplier_id' => 'suppliers#contact_person_info', :as => :contact_person_info

    
=begin
  INITIATE BACK OFFICE PROCESS : assign project Membership + PROJECT ROLE to employee
=end
  match 'select_project_for_project_membership_assignment' => 'projects#select_project_for_project_membership_assignment', :as => :select_project_for_project_membership_assignment
  match 'select_role_to_assign_employee/:project_id' => 'projects#select_role_to_assign_employee', :as => :select_role_to_assign_employee
  match 'assign_member_with_selected_project_role/:project_role_id/to_project/:project_id' => 'project_memberships#assign_member_with_selected_project_role_to_project', :as => :assign_member_with_selected_project_role_to_project

end
