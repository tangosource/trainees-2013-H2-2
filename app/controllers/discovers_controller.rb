class DiscoversController < ApplicationController

  def index
    @name_section = 'Discover Projects'
    @subtitle = 'Passion, ideas, and ambition abound. Start exploring!'    
    @hash_filter_project = Hash.new
    @hash_filter_project["Popular This Week"] = Project.order("countvisit DESC").take(3)
    @hash_filter_project["Recently Successfully Funded"] = Project.order("created_at DESC").take(6)
    @hash_filter_project["Recent Updates"] = Project.order("updated_at DESC").take(3)
  end

  def popular
    @name_section = "Population"
    @subtitle = "These projects are generating the most buzz this week, both on Kickstarter and off."
    @hash_filter_project = Hash.new
    @categories.select('id,name').each{
      |id|
      query = id.projects.order("hit_counter DESC").take(3)
      if !query.empty?
        @hash_filter_project["#{id.name}"] = query
      end
    }
  end

  def recently
    @subtitle = "The newest and freshest projects on Kickstarter!"
    @name_section = "Recently Updates"
    @hash_filter_project = Hash.new
    @hash_filter_project[''] = Project.order("updated_at DESC")
  end
  
  def endingsoon
    @subtitle = "Time is running out! Last chance to get in before the deadline is reached."
    @name_section = "Ending Soon"
    @hash_filter_project = Hash.new
    @hash_filter_project[''] = Project.order("period ASC")
  end

  def smallprojects
    @subtitle = "Small is the new big! These projects are raising $1,000 or less in 30 days or less (and have a video!)."
    @name_section = "Small Projects"
    @hash_filter_project = Hash.new
    @hash_filter_project[''] = Project.where("goal < 20000")
  end
  
  def mostfunded
    @subtitle = "The most funded projects in Kickstarter history (since 2009!"
    @name_section = "Most funded"
    @hash_filter_project = Hash.new
    @hash_filter_project[''] = Project.where("goal > 20000").order("goal DESC")
  end
end

