class CreateEmployees < ActiveRecord::Migration
  def change

    create_table(:employees) do |e|
      e.column(:name, :string)

      e.timestamp(null:true)
    end
  end
end
