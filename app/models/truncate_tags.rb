module TruncateTags
  include Radiant::Taggable

  desc %{
    Truncate contents. Attributes:

      * @chars@ - number of chars within the tag (include ellipses). Default is 50.
      * @keep_words_intact@ - can be 'true' or 'false'. If true, it will leave whole words, but not cut them ('hello...' instead of 'hello fr...'). Default is true.
      * @ellipses@ - default is '...'
      * @strip_html@ - can be 'true' of 'false'. Strips all HTML tags. Default is 'true'
      * @strip_newlines@ - can be 'true' or 'false'. Strips all \\r and \\n.

    *Usage:*

    <pre><code><r:truncate [chars='50'] [keep_words_intact='true'] [ellipses='...'] [strip_html='true'] [strip_newlines='true']>
      <r:snippet name="snip" />
    </r:truncate></code></pre>
  }
  tag 'truncate' do |tag|

  end
  
end