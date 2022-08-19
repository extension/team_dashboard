class AddAddtionalFieldsToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :leader_name, :string
    add_column :teams, :leader_email, :string
    add_column :teams, :number_of_team_members, :integer
  end
end
