class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :body, limit: 280, null: false

      t.timestamps
    end
  end
end
