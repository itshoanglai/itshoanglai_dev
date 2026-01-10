class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.references :user, foreign_key: true, index: { unique: true }, null: true

      t.string  :fullname, null: false
      t.string  :hashid, null: false
      t.date :dob
      t.string  :phone
      t.integer :gender
      t.string  :work_email
      t.string  :private_email
      t.string  :nickname
      t.bigint  :points, default: 0, null: false
      t.jsonb   :app_settings, default: {}

      t.timestamps
    end

    add_index :patients, :hashid, unique: true
    add_index :patients, :work_email
  end
end
