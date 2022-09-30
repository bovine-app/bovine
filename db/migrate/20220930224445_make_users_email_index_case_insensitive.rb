# frozen_string_literal: true

class MakeUsersEmailIndexCaseInsensitive < ActiveRecord::Migration[7.0]
  def up
    remove_index :users, :email
    add_index :users, 'LOWER(email)', unique: true
  end

  def down
    remove_index :users, 'LOWER(email)'
    add_index :users, :email
  end
end
