class MakeReviewsAJoinTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :name, :string
    add_column :reviews, :user_id, :integer
    Review.delete_all

    # NOTES:
    # Since this is destructive of all existing data, a more robust solution could be
    # to find the user with the given name and then programmatically (using Ruby code)
    # set the user_id for existing reviews.
  end
end
