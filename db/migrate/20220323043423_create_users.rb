class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password
      t.string :profile
      t.string :userType
      t.string :phone
      t.string :address
      t.date :dob
      t.integer :created_user_id
      t.integer :updated_user_id
      t.integer :deleted_user_id
      t.datetime :deleted_at
      t.string :password_digest

      t.timestamps
    end
  end
end
