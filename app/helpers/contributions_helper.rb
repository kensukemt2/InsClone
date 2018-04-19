module ContributionsHelper
  def choosen_new_or_edit
    if action_name == 'new' || action_name == 'confirm1'
      confirm1_contributions_path
    elsif action_name == 'edit'
      contribution_path
    end
  end
end
