class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      t.string :text, index: true, unique: true

      t.timestamps
    end
  end
end
