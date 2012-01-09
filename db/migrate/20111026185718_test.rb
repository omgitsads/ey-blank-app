class Test < ActiveRecord::Migration
  def up
    create_table :test do |t|
      t.string :name
    end
  end

  def down
  end
end
