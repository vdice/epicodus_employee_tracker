class CreateDivisions < ActiveRecord::Migration
  def change
    create_table(:divisions) do |d|
      d.column(:name, :string)

      d.timestamps(null: true)
    end

    add_column(:employees, :division_id, :integer)
  end
end
