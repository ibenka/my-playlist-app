class FavoriteMailer < ActionMailer::Base
  default from: "pinili.justin@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@my-playlist-app.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@my-playlist-app.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@my-playlist-app.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
