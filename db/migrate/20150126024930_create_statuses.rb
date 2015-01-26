class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.references :site, index: true
      t.column :status, :integer, default: 0
      t.timestamps null: false
    end
    add_foreign_key :statuses, :sites
  end
end
