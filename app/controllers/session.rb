get '/sessions/new' do
  erb :"session/new"
end

post '/sessions' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id

    if request.xhr?
      current_user.username
    else
      redirect '/'
    end
  else
    if request.xhr?
      status 422
      body "Invalid username or password."
    else
      status 422
      @message = "Invalid username or password."
      erb :"session/new"
    end
  end

end

delete '/sessions' do
  session.delete(:user_id)
  redirect '/'
end

get '/not_authorized' do
  erb :not_authorized
end
