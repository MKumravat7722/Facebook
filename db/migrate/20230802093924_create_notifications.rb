class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :notifiable_id,polymorphic: true
      t.string :notifiable_type
      t.string :message
      t.boolean :read,default: false

      t.timestamps
    end
  end
end
