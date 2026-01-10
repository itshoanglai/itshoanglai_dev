class CreateMedicalStaffs < ActiveRecord::Migration[7.2]
  def change
    create_table :medical_staffs do |t|
      t.references :user, foreign_key: true, index: { unique: true }, null: false

      t.string  :fullname, null: false
      t.string  :hashid, null: false
      t.date :dob
      t.string  :phone
      t.integer :gender
      t.string  :work_email
      t.string  :private_email
      t.string  :nickname
      t.string  :role, null: false
      t.jsonb   :app_settings, default: {}

      t.timestamps
    end

    add_index :medical_staffs, :hashid, unique: true
    add_index :medical_staffs, :work_email
  end
end
