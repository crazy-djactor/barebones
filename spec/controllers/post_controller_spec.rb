require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe "anonymous user login" do
    before :each do
      # This simulates an anonymous user
      login_with nil
    end

    it "should be redirected to sign in" do
      get :index
      expect(response).to redirect_to( new_user_session_path )
      expect(response).to have_http_status(302)
    end
  end

  describe "registered user login" do
    before :each do
      @user1 = create(:user)
      login_with @user1
    end
    it "should let a user see all the posts" do 
      get :index
      expect(response).to render_template( :index )
      expect(response).to have_http_status(200)
    end

    it "loads all of the posts into @posts" do
      post1, post2 = create(:post, user: @user1), create(:post, user: @user1)
      get :index
      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end
  
  describe "GET #show" do
    before :each do
      @user1 = create(:user)
      login_with create( :user )
    end
    it "assigns the requested post to @post" do
      post = create(:post, user: @user1)
      get :show, params: {id: post}
      expect(assigns(:post)).to eq(post)
    end
    
    it "renders the #show view" do
      get :show, params: {id: create(:post, user:@user1)}
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    before :each do
      @user1 = create( :user )
      login_with @user1
    end
    context "with valid attributes" do
      it "creates a new post" do
        create(:post, user: @user1)
        expect(Post.count).to eq(1)
      end
      it "redirects to the new post" do
        post :create, params: {post: attributes_for(:post)}
        expect(response).to redirect_to Post.last
      end
    end
    
    context "with invalid attributes" do
      it 'does not create the post' do
        post :create, params: { post: attributes_for(:post, title: nil)}
        expect(Post.count).to eq(0)
      end

      it 're-renders the "new" view' do
        post :create, params: {post: attributes_for(:post, title: nil)}
        expect(response).to render_template :new
      end
    end 
  end
end
