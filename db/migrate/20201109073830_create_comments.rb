class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment,                null: false
      # モデルとの紐付け(referencesはカラム名)
      t.references :user 
      t.references :prototype
      t.timestamps
    end
  end
end
