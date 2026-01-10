class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string  :email, null: false
      t.string  :encrypted_password, null: false
      t.string  :hashid, null: false
      t.integer :failed_attempts, default: 0, null: false
      t.boolean :deactivated, default: false, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :hashid, unique: true
  end
end
