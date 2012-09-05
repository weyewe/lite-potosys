module OfficesHelper
  def add_default_hidden_create_deadline_for_new_employee(params)
    if params[:action] != 'create_employee'
      return  'default-hidden'
    end
  end
   
end

 