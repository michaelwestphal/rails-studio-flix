module UsersHelper
  def profile_image(user, size=80)
    gravatar_url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.name} avatar")
  end
end
