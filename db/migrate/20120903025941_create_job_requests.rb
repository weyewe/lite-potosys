class CreateJobRequests < ActiveRecord::Migration
  def change
    create_table :job_requests do |t|

      t.timestamps
    end
  end
end
