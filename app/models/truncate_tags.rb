module TruncateTags
  include Radiant::Taggable

  desc %{
    Truncate contents. Attributes:

    1. @chars@ - number of chars within the tag (include ellipses). Default is 50.
    2. @keep_words_intact@ - can be 'true' or 'false'. If true, it will leave whole words, but not cut them ('hello...' instead of 'hello fr...'). Default is true.
    3. @ellipses@ - default is '...'
    4. @strip_html@ - can be 'true' of 'false'. Strips all HTML tags. Default is 'true'
    5. @strip_newlines@ - can be 'true' or 'false'. Strips all \\r and \\n. Default is 'true'

    *Usage:*

    <pre><code><r:truncate [chars='50'] [keep_words_intact='true'] [ellipses='...'] [strip_html='true'] [strip_newlines='true']>
      <r:snippet name="snip" />
    </r:truncate></code></pre>
  }
  tag 'truncate' do |tag|
    text = tag.expand
    text = text.mb_chars
    
    chars = (tag.attr['chars'] || 50).to_i
    keep_words_intact = tag.attr['keep_words_intact'] ? (tag.attr['keep_words_intact'] == 'true') : true
    ellipses = (tag.attr['ellipses'] || '...').mb_chars
    strip_html = tag.attr['strip_html'] ? (tag.attr['strip_html'] == 'true') : true
    strip_newlines = tag.attr['strip_newlines'] ? (tag.attr['strip_newlines'] == 'true') : true
    
    helper = ActionView::Base.new
    
    text = helper.strip_tags(text) if strip_html
    text = text.gsub(/\s+/, " ") if strip_newlines
    unless text.length <= chars
      truncate_method = keep_words_intact ? 'truncate_words' : 'truncate'
      text = helper.send(truncate_method, text, :length => chars, :omission => ellipses)
    end
    text
  end
  
end

module ActionView::Helpers::TextHelper

  def truncate_words(text, *args)
    options = args.extract_options!
    truncate_string = options[:omission] || '...'
    length = options[:length] || 50
    return text if text.length <= length
    length = (length - truncate_string.mb_chars.length)
    str = text[0, length + 1] 
    return truncate_string unless str
    idx = 0
    last_idx = nil
    while(idx && last_idx != idx) do
      last_idx = idx
      idx = str.index(/\s/, idx.to_i + 1)
    end
    (str[0, last_idx] + truncate_string).to_s
  end
  
end