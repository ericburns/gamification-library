class AddUsernameEmailEncryptedPasswordSaltToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :username, :string

    add_column :admins, :email, :string

    add_column :admins, :encrypted_password, :string

    add_column :admins, :string, :string

    add_column :admins, :salt, :string

  end
end
