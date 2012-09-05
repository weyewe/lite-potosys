class HomeController < ApplicationController
  # skip_before_filter :authenticate_user!#, :only => [:homepage , :blog, :portfolio]
  def dashboard
    redirect_to deduce_after_sign_in_url
  end
  
  def homepage
    redirect_to deduce_after_sign_in_url
    return 
    
    # all(:conditions=> ["created_at >= ? ", Time.now.beginning_of_day])
    # @articles = Article.frontpage_article
    @latest_articles = Article.frontpage_article
    
    @articles  = Kaminari.paginate_array(Article.frontpage_article).page(params[:page]).per(3)
    
    
    render :layout => 'layouts/front_page'
  end
   
end
