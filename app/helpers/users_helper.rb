module UsersHelper
  def profile_image(user)
    gravatar_url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(gravatar_url, alt: "#{user.name} avatar")
  end
end
