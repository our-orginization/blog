{% if page.comments %}
  <div class="comments" id="comments">
    <div id="gitmentContainer" style="margin-bottom: -19px;"></div>
    <link rel="stylesheet" href="/css/gitment.css">
    <script src="/js/src/gitment.browser.js" type="text/javascript"></script>
    <script type="text/javascript">
      var gitment = new Gitment({
        owner: 'our-orginization',
        repo: 'our-orginization.github.io',
        oauth: {
          client_id: '8cf598e733def9645a71',
          client_secret: '6d1f2b9bffe5c8fea2f926b7bd59b68c271d9098',
        },
      })
      gitment.render('gitmentContainer')
    </script>

    {% if (theme.duoshuo and theme.duoshuo.shortname) or theme.duoshuo_shortname %}
      <div class="ds-thread" data-thread-key="{{ page.path }}"
           data-title="{{ page.title }}" data-url="{{ page.permalink }}">
      </div>
    {% elseif theme.facebook_sdk.enable and theme.facebook_comments_plugin.enable %}
      <div class="fb-comments"
           data-href="{{ page.permalink }}"
           data-numposts="{{ theme.facebook_comments_plugin.num_of_posts }}"
           data-width="{{ theme.facebook_comments_plugin.width }}"
           data-colorscheme="{{ theme.facebook_comments_plugin.scheme }}">
      </div>
    {% elseif theme.disqus_shortname %}
      <div id="disqus_thread">
        <noscript>
          Please enable JavaScript to view the
          <a href="//disqus.com/?ref_noscript">comments powered by Disqus.</a>
        </noscript>
      </div>
    {% elseif theme.gitment.enable %}
        <div id="gitment-container"></div>
    {% endif %}
  </div>
{% endif %}
