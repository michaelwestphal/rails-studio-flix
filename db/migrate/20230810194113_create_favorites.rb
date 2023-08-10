class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      # Similar to the old form:
      # t.bigint movie_id

      t.timestamps
    end
  end
end
