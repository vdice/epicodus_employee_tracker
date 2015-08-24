class CreateEmployees < ActiveRecord::Migration
  def change
    create_table(:employees) do |e|
      e.column(:name, :string)

      e.timestamps(null: true)
    end
  end
end
