class CreateAssignments < ActiveRecord::Migration
  def change
    create_table(:employees_projects) do |a|
    a.column(:employee_id, :int)
    a.column(:project_id, :int)
    end
    remove_column(:employees, :project_id, :int)
  end
end
