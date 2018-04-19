class InsMailer < ApplicationMailer
  def contribution_mail(cont)
    @contribution = cont

    mail to: cont.user.email, subject: "写真を投稿しました"
  end

end
