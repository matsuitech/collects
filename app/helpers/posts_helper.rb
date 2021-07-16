module PostsHelper
    def render_with_hashtags(hash_tag)
        hash_tag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/hashtags/#{word.delete("#")}/posts"}.html_safe
    end
    
end
