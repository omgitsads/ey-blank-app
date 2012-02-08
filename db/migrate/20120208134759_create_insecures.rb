class CreateInsecures < ActiveRecord::Migration
  def change
    create_table :insecures do |t|
      t.string :name

      t.timestamps
    end
  end
end
