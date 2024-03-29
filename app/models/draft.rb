class Draft < ActiveRecord::Base
  attr_accessible :overall_feedback,  :proposed_deadline_date
  belongs_to :project 
  
  belongs_to :deliverable_component_subcription 
  belongs_to :deliverable_item # make it easier to query db 
  
  has_many :tasks
  validates_presence_of :overall_feedback,  :proposed_deadline_date 
  
  def set_granted_deadline_date( employee,start_date,  deadline_date ) 
    # if employee is not a member of this project, or wrong role 
    
    if deadline_date.nil? or deadline_date < self.project.project_start_date 
      self.errors.add(  :granted_deadline_date , "Date must not be nil" +  " and " + 
                        "it must not be earlier than the project start date")
                        
      return nil 
    end
    
    if start_date.nil? or start_date < self.project.project_start_date  or
      start_date > deadline_date
      self.errors.add(  :start_draft_date , "Start Date must not be nil" +  " and " + 
                        "it must not be earlier than the project start date" +  " and " +
                        " it must not be later than the deadline" )
                        
      return nil
    end
    
    self.start_draft_date = start_date
    self.granted_deadline_date = deadline_date 
    self.save 
    past_job_requests = self.draft_creation_deadline_job_request
    if past_job_requests.count == 0 
      self.create_job_request (employee)
    else                      
      self.update_job_request( start_date, deadline_date)
    end
  end
  
  def draft_creation_deadline_job_request
    JobRequest.where(:job_request_source => JOB_REQUEST_SOURCE[:production_scheduling],
    :source_id => self.id , 
    :project_id => self.project_id , 
    :is_canceled => false  ) 
  end
  
  def create_job_request(employee)
    self.project.production_team.each do |project_membership|
      job_request = JobRequest.new  
      job_request.source_id = self.id
      job_request.project_id = self.project_id 
      job_request.user_id = project_membership.user_id 
      job_request.office_id = employee.active_job_attachment.office_id 
      
      job_request.job_request_source =  JOB_REQUEST_SOURCE[:production_scheduling]
      job_request.title = "[#{self.project.title}] Draft #{self.number}"
      job_request.description = "#{self.overall_feedback}"


      job_request.starting_date =self.start_draft_date
      job_request.ending_date = self.granted_deadline_date
      job_request.save
    end
  end
  
  def update_job_request( start_date, deadline_date )
    self.project.production_team.each do |project_membership|
      job_request = JobRequest.where(:job_request_source => JOB_REQUEST_SOURCE[:production_scheduling], 
        :source_id => self.id , 
        :user_id => project_membership.user_id 
      ).first 
      
      job_request.starting_date =self.start_draft_date
      job_request.ending_date = deadline_date
      job_request.save 
    end
  end
  
  
=begin
  CREATE TASK 
=end

  def create_task( employee, task_params ) 
    new_task = Task.new( task_params)
    
    if not employee.has_role?(:account_executive) or
       not employee.has_project_role?( self.project, ProjectRole.find_by_name( PROJECT_ROLE[:account_executive] ) )
       puts "THIS GUY DOESN'T HAVE PROJECT ROLE\n"*5
     return new_task
    end
    
    new_task.draft_id = self.id 
    new_task.save
    return new_task 
  end
  
=begin
  Finishing the draft
=end

  def finish_job_request
    self.project.production_team.each do |project_membership|
      job_requests = JobRequest.where(:job_request_source => JOB_REQUEST_SOURCE[:production_scheduling], 
        :source_id => self.id , 
        :user_id => project_membership.user_id 
      ) 
      
      
      job_requests.each do |jr|
        jr.finish_date =self.finish_date
        jr.is_finished = true 
        jr.finisher_id = self.finisher_id 
        jr.save
      end
      
    end
  end
  
  def finish_draft(employee, draft_finish_date ) 
    
    return nil if draft_finish_date.nil?  
    if not employee.has_role?(:account_executive) or
       not employee.has_project_role?( self.project, ProjectRole.find_by_name( PROJECT_ROLE[:account_executive] ) )
       puts "WRONG ROLE\n"*5
     return nil
    end
    
    if  draft_finish_date < self.project.project_start_date
      puts "aiyaaa draft FINISH DATE < project.project_start_date\n"*5  
      return nil
    end
    
    self.is_finished = true 
    self.finish_date  = draft_finish_date
    self.finisher_id = employee.id
    self.save 
    
    self.finish_job_request
    
    # if past_job_requests.count == 0 
    #    self.create_job_request (employee)
    #  else                      
    #    self.update_job_request( start_date, deadline_date)
    #  end
    
    # after finish, update the job_request 
  end
  
  def cancel_finish_draft( employee )
    if not employee.has_role?(:account_executive) or
       not employee.has_project_role?( self.project, ProjectRole.find_by_name( PROJECT_ROLE[:account_executive] ) )
     return nil
    end 
    
    if self.project.is_production_finished == true 
      return nil
    end
    
    self.is_finished = false  
    self.finish_date  = nil 
    self.finisher_id = employee.id
    self.save
  end
  
end
