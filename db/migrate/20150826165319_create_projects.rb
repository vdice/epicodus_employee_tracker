class CreateProjects < ActiveRecord::Migration
  def change
    create_table(:projects) do |p|
    p.column(:name, :string)
    p.timestamps(null: false)
    end
    add_column(:employees, :project_id, :int)
  end
end
