class AddUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :provider
      t.string :uid, unique: true
      t.string :name
      t.string :encrypted_password
      t.timestamps
    end
  end
end
