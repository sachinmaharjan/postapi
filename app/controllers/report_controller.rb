class ReportController < ApplicationController
  def activities_by_city
    @activities = User.joins('LEFT JOIN posts on users.id = posts.user_id').
                       joins('LEFT JOIN comments on posts.id = comments.post_id').
                       select('users.city, posts.*, comments.*').group('users.city, posts.id, comments.id')
    render json: JSON.pretty_generate(@activities.as_json), status: :ok
  end
end
