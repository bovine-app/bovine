# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds, id: :uuid do |t|
      t.string :title
      t.string :url
      t.datetime :last_checked_at

      t.timestamps
    end

    add_index :feeds, :url, unique: true
  end
end
