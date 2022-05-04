class AddUserToSubmission < ActiveRecord::Migration[7.0]
  def change
    # add_column :user_id, :integer
    add_reference :submissions, :user, foreign_key: true
  end
end
