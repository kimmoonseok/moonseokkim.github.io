class AlphaController < ApplicationController
  
  def index
    @bookuni = ["%EB%AC%B8%EC%9E%AC%EC%9D%B8","%EC%97%B0%EC%95%A0","%EC%97%AC%ED%96%89%0A"]
  end
  
    def thumnail
    Thumnail.destroy_all
    require 'open-uri'
    uri = "http://book.naver.com/search/search.nhn?sm=sta_hty.book&sug=&where=nexearch&query= " + "params[:bookname]"
    result = Nokogiri::HTML(open(uri))
    thumnail_head = Array.new
    image_array = Array.new
    result.css('div.content > ul > li > dl > dd > a').each do |x|
    thumnail_head.push(x.text().delete "\t" "\n")
    end
    
    result.css('div.content > ul > li > div.thumb.type_search > div.thumb_type.thumb_type2').each do |x|
      count = 0
      x.css('a > img').each do |y|
        if count>0
          break
        else
          image_array.push(y.attr('src'))
          count += 1
        end
      end
    end
      
    for i in (0..29)
    thumnails = Thumnail.new
    thumnails.head = thumnail_head[i]
    thumnails.imge = image_array[i]
    thumnails.save
    end
    @thumnails = Thumnail.all
    @bookkey = params[:keyword]
      
    end

  def random
    x = ["김문석","장경욱","유재욱","유동관","서원석","김현우","류성한","유재경","정준현","박수진"]
    @y_array = x.sample(1)
    @randomvar = (1..10).to_a.sample(2)
  end
  
end