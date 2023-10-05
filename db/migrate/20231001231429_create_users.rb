class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.boolean :active, default: true
      t.boolean :admin, default: false
      t.string :name
      t.string :last_name
      t.datetime :last_sign_in_at
      t.date :birthday
      t.string :email
      t.string :password_salt
      t.string :password_hash
      t.string :phone
      t.boolean :verified_account
      t.integer :verification_code

      t.timestamps
    end
    add_index :users, :email
  end
end
