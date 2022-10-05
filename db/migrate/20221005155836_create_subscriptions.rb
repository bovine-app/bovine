# frozen_string_literal: true

class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :feed, null: false, foreign_key: true, type: :uuid
      t.jsonb :settings

      t.timestamps
    end

    add_index :subscriptions, %i[user_id feed_id], unique: true
  end
end
