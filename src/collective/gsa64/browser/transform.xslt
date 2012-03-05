<?xml version="1.0"?>

<!-- **********************************************************************
 XSL to format the search output for Google Search Appliance
 XHTML/XHTML-MP Version (15 September 2006)
     ********************************************************************** -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- **********************************************************************
 Choose output media: handheld (default is blank). Use handheld only for
 dedicated handheld media - css/markup will be minimized. Always adjust the
 xsl:output selection (below) when changing this.
     ********************************************************************** -->
<xsl:variable name="media"></xsl:variable>

<!-- **********************************************************************
 Switch to XHTML Mobile if setting variable media to handheld.
 This can be configured automatically once XSLT 2.0 is supported.
     ********************************************************************** -->
<xsl:output method="xml" omit-xml-declaration="yes" indent="no" media-type="text/html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
<!--
<xsl:output method="xml" omit-xml-declaration="no" indent="no" doctype-system="http://www.wapforum.org/DTD/xhtml-mobile10.dtd" doctype-public="-//WAPFORUM//DTD XHTML Mobile 1.0//EN"/>
-->

<!-- **********************************************************************
 Logo setup (can be customized)
     - whether to show logo: 0 for FALSE, 1 (or non-zero) for TRUE
     - use CSS values for height and width properties
     ********************************************************************** -->
<xsl:variable name="show_logo">1</xsl:variable>
<xsl:variable name="logo_url">images/Title_Left.gif</xsl:variable>
<xsl:variable name="logo_width">200px</xsl:variable>
<xsl:variable name="logo_height">78px</xsl:variable>
<xsl:variable name="logo_url_sm">http://www.google.com/xhtml/images/google.gif</xsl:variable>
<xsl:variable name="logo_width_sm">85px</xsl:variable>
<xsl:variable name="logo_height_sm">35px</xsl:variable>
<xsl:variable name="logo_title">Go to Google Home</xsl:variable>
<xsl:variable name="logo_alt">Google</xsl:variable>

<!-- **********************************************************************
 Global Style variables (can be customized): '' for using browser's default
     - use CSS values for background, color, font-family, and
       text-size properties
     ********************************************************************** -->
<xsl:variable name="global_font">Arial,sans-serif</xsl:variable>
<xsl:variable name="global_font_size">1em</xsl:variable>
<xsl:variable name="global_bg_color">#fff</xsl:variable>
<xsl:variable name="global_text_color">#000</xsl:variable>
<xsl:variable name="global_link_color">#00c</xsl:variable>
<xsl:variable name="global_vlink_color">#551a8b</xsl:variable>
<xsl:variable name="global_alink_color">#f00</xsl:variable>
<xsl:variable name="global_co_color">#2f2f2f</xsl:variable>

<!-- **********************************************************************
 Include CSS vs. embedding (default is 0 - embed)
     - Can enable/disable without unsetting include prefix.
     - Prefix points to location of search.css, advanced.css, handheld.css
       (Example: http://www.google.com/style/)
     ********************************************************************** -->
<xsl:variable name="style_include">0</xsl:variable>
<xsl:variable name="style_include_prefix"></xsl:variable>

<!-- **********************************************************************
 Result page components (can be customized)
     - whether to show a component: 0 for FALSE, non-zero (e.g., 1) for TRUE
     - use CSS values for background, color and text-size properties
     ********************************************************************** -->

<!-- *** choose result page header: '', 'provided', 'mine', or 'both' *** -->
<xsl:variable name="choose_result_page_header">both</xsl:variable>

<!-- *** customize provided result page header *** -->
<xsl:variable name="show_swr_link">1</xsl:variable>
<xsl:variable name="swr_search_anchor_text">Search Within Results</xsl:variable>
<xsl:variable name="show_result_page_adv_link">1</xsl:variable>
<xsl:variable name="adv_search_anchor_text">Advanced Search</xsl:variable>
<xsl:variable name="show_result_page_help_link">1</xsl:variable>
<xsl:variable name="search_help_anchor_text">Search Tips</xsl:variable>
<xsl:variable name="show_alerts_link">0</xsl:variable>
<xsl:variable name="alerts_anchor_text">Alerts</xsl:variable>

<!-- *** search boxes (size in # of characters) *** -->
<xsl:variable name="show_top_search_box">1</xsl:variable>
<xsl:variable name="show_bottom_search_box">1</xsl:variable>
<xsl:variable name="search_box_size">32</xsl:variable>

<!-- *** choose search button type: 'text' or 'image' *** -->
<xsl:variable name="choose_search_button">text</xsl:variable>
<xsl:variable name="search_button_text">
  <xsl:choose>
    <xsl:when test="$media = 'handheld'">Search</xsl:when>
    <xsl:otherwise>Google Search</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="search_button_image_url"></xsl:variable>
<xsl:variable name="search_collections_xslt"></xsl:variable>

<!-- *** search info bars *** -->
<xsl:variable name="show_search_info">1</xsl:variable>

<!-- *** choose separation bar: 'ltblue', 'blue', 'line', 'nothing' *** -->
<xsl:variable name="choose_sep_bar">ltblue</xsl:variable>
<xsl:variable name="sep_bar_std_text">Search</xsl:variable>
<xsl:variable name="sep_bar_adv_text">Advanced Search</xsl:variable>
<xsl:variable name="sep_bar_error_text">Error</xsl:variable>

<!-- *** navigation bars: '', 'google', 'link', or 'simple'*** -->
<xsl:variable name="show_top_navigation">1</xsl:variable>
<xsl:variable name="choose_bottom_navigation">google</xsl:variable>

<!-- *** sort by date/relevance *** -->
<xsl:variable name="show_sort_by">1</xsl:variable>

<!-- *** spelling suggestions *** -->
<xsl:variable name="show_spelling">1</xsl:variable>
<xsl:variable name="spelling_text">Did you mean:</xsl:variable>
<xsl:variable name="spelling_text_color">#c00</xsl:variable>

<!-- *** synonyms suggestions *** -->
<xsl:variable name="show_synonyms">1</xsl:variable>
<xsl:variable name="synonyms_text">You could also try:</xsl:variable>
<xsl:variable name="synonyms_text_color">#c00</xsl:variable>

<!-- *** keymatch suggestions *** -->
<xsl:variable name="show_keymatch">1</xsl:variable>
<xsl:variable name="keymatch_text">KeyMatch</xsl:variable>
<xsl:variable name="keymatch_text_color">#25a</xsl:variable>
<xsl:variable name="keymatch_bg_color">#e8e8ff</xsl:variable>
<xsl:variable name="trim_keymatch_link">
  <xsl:choose>
    <xsl:when test="$media = 'handheld'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- *** Google Desktop integration *** -->
<xsl:variable name="egds_show_search_tabs">
  <xsl:choose>
    <xsl:when test="$media = 'handheld'">0</xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="egds_appliance_tab_label">Appliance</xsl:variable>
<xsl:variable name="egds_show_desktop_results">0</xsl:variable>

<!--*** onebox information *** -->
<xsl:variable name="show_onebox">1</xsl:variable>

<!-- **********************************************************************
 Result elements (can be customized)
     - whether to show an element ('1' for yes, '0' for no)
     - use CSS values for color, font-family and text-size properties
     ********************************************************************** -->

<!-- *** result title and snippet *** -->
<xsl:variable name="show_res_title">1</xsl:variable>
<xsl:variable name="res_title_color">#00c</xsl:variable>
<xsl:variable name="res_title_size">1.35em</xsl:variable>
<xsl:variable name="res_type_size">.85em</xsl:variable>
<xsl:variable name="show_res_snippet">1</xsl:variable>
<xsl:variable name="res_snippet_size">1.05em</xsl:variable>

<!-- *** keyword match (in title or snippet) *** -->
<xsl:variable name="res_keyword_color"></xsl:variable>
<xsl:variable name="res_keyword_size"></xsl:variable>
<xsl:variable name="res_keyword_format">strong</xsl:variable>

<!-- *** link URL *** -->
<xsl:variable name="show_res_url">1</xsl:variable>
<xsl:variable name="res_url_color">#008000</xsl:variable>
<xsl:variable name="res_url_size">1.05em</xsl:variable>
<xsl:variable name="truncate_result_urls">1</xsl:variable>
<xsl:variable name="truncate_result_url_length">100</xsl:variable>

<!-- *** misc elements *** -->
<xsl:variable name="show_meta_tags">0</xsl:variable>
<xsl:variable name="show_res_size">
  <xsl:choose>
    <xsl:when test="$media = 'handheld'">0</xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="show_res_date">
  <xsl:choose>
    <xsl:when test="$media = 'handheld'">0</xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="show_res_cache">1</xsl:variable>

<!-- *** used in result cache link, similar pages link, and description *** -->
<xsl:variable name="faint_color">#77c</xsl:variable>

<!-- *** show secure results radio button *** -->
<xsl:variable name="show_secure_radio">1</xsl:variable>

<!-- **********************************************************************
 Other variables (can be customized)
     ********************************************************************** -->

<!-- *** show favicon *** -->
<xsl:variable name="show_favicon">1</xsl:variable>
<xsl:variable name="favicon">http://www.google.com/favicon.ico</xsl:variable>

<!-- *** use accesskeys *** -->
<xsl:variable name="use_accesskeys">1</xsl:variable>

<!-- *** show skip links *** -->
<xsl:variable name="show_skip_links">1</xsl:variable>

<!-- *** page title *** -->
<xsl:variable name="home_page_title">Search Home</xsl:variable>
<xsl:variable name="result_page_title">Search Results</xsl:variable>
<xsl:variable name="adv_page_title">Advanced Search</xsl:variable>
<xsl:variable name="error_page_title">Error</xsl:variable>
<xsl:variable name="swr_page_title">Search Within Results</xsl:variable>

<!-- *** choose adv_search page header: '', 'provided', 'mine', or 'both' *** -->
<xsl:variable name="choose_adv_search_page_header">both</xsl:variable>

<!-- *** cached page header text *** -->
<xsl:variable name="cached_page_header_text">This is the cached copy of</xsl:variable>

<!-- *** error message text *** -->
<xsl:variable name="server_error_msg_text">A server error has occurred.</xsl:variable>
<xsl:variable name="server_error_des_text">Check server response code in details.</xsl:variable>
<xsl:variable name="xml_error_msg_text">Unknown XML result type.</xsl:variable>
<xsl:variable name="xml_error_des_text">View page source to see the offending XML.</xsl:variable>

<!-- *** advanced search page panel background color *** -->
<xsl:variable name="adv_search_panel_bgcolor">#cbdced</xsl:variable>

<!-- **********************************************************************
 My global page header/footer (can be customized)
     ********************************************************************** -->
<xsl:template name="my_page_header">
  <!-- *** add your xhtml here - suggest styling via #ph (header) or .phf (header/footer) -->
</xsl:template>

<xsl:template name="my_page_footer">
  <!-- *** add your xhtml here - suggest styling via #pf (footer) or .phf (header/footer) -->
</xsl:template>

<!-- **********************************************************************
 Logo template (can be customized)
     ********************************************************************** -->
<xsl:template name="logo">
  <h1>
    <xsl:if test="$media != 'handheld'"><xsl:attribute name="id">lg</xsl:attribute></xsl:if>
    <xsl:choose>
      <xsl:when test="$media = 'handheld'">
        <img src="{$logo_url_sm}" width="{$logo_width_sm}" height="{$logo_height_sm}" title="{$logo_alt}"/>
      </xsl:when>
      <xsl:when test="/GSP/CUSTOM/HOME">
        <span title="{$logo_alt}"><xsl:value-of select="$logo_alt"/></span>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$home_url}" title="{$logo_title}"><xsl:value-of select="$logo_alt"/></a>
      </xsl:otherwise>
    </xsl:choose>
  </h1>
</xsl:template>

<!-- **********************************************************************
 Skip links (can be customized)
     ********************************************************************** -->
<xsl:template name="skip_links">
  <xsl:variable name="form_id">
    <xsl:choose>
      <xsl:when test="$show_top_search_box != '0'">sf</xsl:when>
      <xsl:when test="$show_bottom_search_box != '0'">sb</xsl:when>
      <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="$form_id != '' or count(RES/R)>0">
    <xsl:variable name="skip_sep">
      <xsl:if test="$form_id != '' and count(RES/R)>0"><xsl:text>, </xsl:text></xsl:if>
    </xsl:variable>
    <p id="sk">
      <xsl:text>Skip to: </xsl:text>
      <xsl:if test="$form_id != ''"><a href="#{$form_id}">Query</a></xsl:if>
      <xsl:value-of select="$skip_sep"/>
      <xsl:if test="count(RES/R)>0"><a href="#re">Results</a></xsl:if>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Search result page header (can be customized): logo and search box
     ********************************************************************** -->
<xsl:template name="result_page_header">
  <xsl:if test="$show_logo != '0'">
    <xsl:call-template name="logo"/>
  </xsl:if>
  <xsl:if test="$media != 'handheld'">
    <xsl:if test="$show_skip_links != '0'">
      <xsl:call-template name="skip_links"/>
    </xsl:if>
    <xsl:if test="$show_top_search_box != '0'">
      <xsl:call-template name="search_box">
        <xsl:with-param name="type" select="'std_top'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
  <xsl:if test="/GSP/CT">
    <p id="sw"><xsl:call-template name="stopwords"/></p>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Home search page header (can be customized): logo and search box
     ********************************************************************** -->
<xsl:template name="home_page_header">
  <xsl:param name="type" select="'home'"/>
  <xsl:if test="$show_logo != '0'">
    <xsl:call-template name="logo"/>
  </xsl:if>
  <xsl:if test="$show_top_search_box != '0'">
    <xsl:call-template name="search_box">
      <xsl:with-param name="type" select="$type"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Separation bar variables (used in advanced search header and result page)
     - use CSS values for background and color properties
     ********************************************************************** -->
<xsl:variable name="sep_bar_border_color">
  <xsl:choose>
    <xsl:when test="$choose_sep_bar = 'ltblue'">#36c</xsl:when>
    <xsl:when test="$choose_sep_bar = 'blue'">#36c</xsl:when>
    <xsl:otherwise><xsl:value-of select="$global_bg_color"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="sep_bar_bg_color">
  <xsl:choose>
    <xsl:when test="$choose_sep_bar = 'ltblue'">#e5ecf9</xsl:when>
    <xsl:when test="$choose_sep_bar = 'blue'">#36c</xsl:when>
    <xsl:otherwise><xsl:value-of select="$global_bg_color"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="sep_bar_text_color">
  <xsl:choose>
    <xsl:when test="$choose_sep_bar = 'ltblue'">#000</xsl:when>
    <xsl:when test="$choose_sep_bar = 'blue'">#fff</xsl:when>
    <xsl:otherwise><xsl:value-of select="$global_text_color"/></xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- **********************************************************************
 Advanced search page header HTML (can be customized)
     ********************************************************************** -->
<xsl:template name="advanced_search_header">
  <xsl:if test="$show_logo != '0'"><xsl:call-template name="logo"/></xsl:if>
</xsl:template>

<!-- **********************************************************************
 Cached page header (can be customized)
     ********************************************************************** -->
<xsl:template name="cached_page_header">
  <xsl:param name="cached_page_url"/>
  <xsl:variable name="stripped_url" select="substring-after($cached_page_url,'://')"/>

  <!-- Leave style embedded. Do not factor out. -->
  <div style="border:1px solid black;margin:auto;padding:6px;">
    <div style="border:2px solid black;padding:8px;margin:auto;background:{$global_bg_color};color:{$global_text_color};">
      <div style="color:#000;">
        <xsl:value-of select="$cached_page_header_text"/>
        <xsl:text> </xsl:text>
        <xsl:choose>
          <xsl:when test="starts-with($cached_page_url, $db_url_protocol)">
            <a href="{concat('/db/',$stripped_url)}">
            <xsl:value-of select="$cached_page_url"/></a>.
          </xsl:when>
          <xsl:when test="starts-with($cached_page_url, $nfs_url_protocol)">
            <a href="{concat('/nfs/',$stripped_url)}">
            <xsl:value-of select="$cached_page_url"/></a>.
          </xsl:when>
          <xsl:when test="starts-with($cached_page_url, $smb_url_protocol)">
            <a href="{concat('/smb/',$stripped_url)}">
            <xsl:value-of select="$cached_page_url"/></a>.
          </xsl:when>
          <xsl:otherwise>
            <a href="{$cached_page_url}">
            <xsl:value-of select="$cached_page_url"/></a>.
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
  </div>
  <hr/>
</xsl:template>

<!-- **********************************************************************
 "Front door" search input page (can be customized)
     ********************************************************************** -->
<xsl:template name="front_door">
  <xsl:param name="type" select="'home'"/>
  <head>
    <xsl:call-template name="head_elements"/>
    <title>
      <xsl:choose>
        <xsl:when test="$type = 'swr'"><xsl:value-of select="$swr_page_title"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$home_page_title"/></xsl:otherwise>
      </xsl:choose>
    </title>
    <xsl:call-template name="style">
      <xsl:with-param name="mode" select="$type"/>
    </xsl:call-template>
  </head>
  <body dir="ltr">
    <xsl:call-template name="my_page_header"/>
    <xsl:call-template name="home_page_header">
      <xsl:with-param name="type" select="$type"/>
    </xsl:call-template>
    <xsl:if test="$media != 'handheld'"><hr/></xsl:if>
    <xsl:call-template name="copyright"/>
    <xsl:call-template name="my_page_footer"/>
  </body>
</xsl:template>

<!-- **********************************************************************
 Empty result set (can be customized)
     ********************************************************************** -->
<xsl:template name="no_RES">
  <xsl:param name="query"/>

  <!-- *** Output Google Desktop results (if enabled and any available) *** -->
  <xsl:if test="$egds_show_desktop_results != '0'">
    <xsl:call-template name="desktop_results"/>
  </xsl:if>

  <div id="er">
    <p>
      <xsl:text>Your search - </xsl:text>
      <strong><xsl:value-of select="$query"/></strong>
      <xsl:text> - did not match any documents.</xsl:text>
      <xsl:if test="$media != 'handheld'">
        <xsl:text> </xsl:text>
        <span>
          <xsl:text>No pages were found containing </xsl:text>
          <strong>"<xsl:value-of select="$query"/>"</strong>
          <xsl:text>.</xsl:text>
        </span>
      </xsl:if>
    </p>
    <xsl:if test="$media != 'handheld'">
      <p>Suggestions:</p>
      <ul>
        <li>Make sure all words are spelled correctly.</li>
        <li>Try different keywords.</li>
        <xsl:if test="/GSP/PARAM[(@name='access') and(@value='a')]">
          <li>Make sure your security credentials are correct.</li>
        </xsl:if>
        <li>Try more general keywords.</li>
      </ul>
    </xsl:if>
  </div>

  <xsl:if test="$media = 'handheld' and $show_bottom_search_box != '0'">
    <xsl:call-template name="bottom_search_box"/>
  </xsl:if>
</xsl:template>

<!-- ######################################################################
 We do not recommend changes to the following code.  Google Technical
 Support Personnel currently do not support customization of XSLT under
 these Technical Support Services Guidelines.  Such services may be
 provided on a consulting basis, at Google's then-current consulting
 services rates under a separate agreement, if Google personnel are
 available.  Please ask your Google Account Manager for more details if
 you are interested in purchasing consulting services.
     ###################################################################### -->

<!-- **********************************************************************
 Global Style (do not customize)
 default presentation using CSS (Cascading Style Sheets)
     ********************************************************************** -->
<xsl:template name="style">
  <xsl:param name="mode"/>
  <xsl:choose>
    <xsl:when test="$style_include != '0'">
      <xsl:choose>
        <xsl:when test="$mode = 'advanced'">
          <link href="{$style_include_prefix}advanced.css" rel="stylesheet" type="text/css" media="screen,print"/>
          <link href="{$style_include_prefix}advanced-print.css" rel="stylesheet" type="text/css" media="print"/>
          <xsl:text disable-output-escaping="yes">&lt;!--[if lte IE 7]&gt;</xsl:text>
          <link href="{$style_include_prefix}advanced-print-ie.css" rel="stylesheet" type="text/css" media="print"/>
          <xsl:text disable-output-escaping="yes">&lt;![endif]--&gt;</xsl:text>
        </xsl:when>
        <xsl:when test="$media = 'handheld'">
          <link href="{$style_include_prefix}search-handheld.css" rel="stylesheet" type="text/css"/>
        </xsl:when>
        <xsl:otherwise>
          <link href="{$style_include_prefix}search.css" rel="stylesheet" type="text/css" media="screen,print"/>
          <link href="{$style_include_prefix}search-print.css" rel="stylesheet" type="text/css" media="print"/>
          <link href="{$style_include_prefix}search-handheld.css" rel="stylesheet" type="text/css" media="handheld"/>
          <xsl:text disable-output-escaping="yes">&lt;!--[if lte IE 7]&gt;</xsl:text>
          <link href="{$style_include_prefix}search-ie.css" rel="stylesheet" type="text/css" media="screen,print"/>
          <link href="{$style_include_prefix}search-print-ie.css" rel="stylesheet" type="text/css" media="print"/>
          <xsl:text disable-output-escaping="yes">&lt;![endif]--&gt;</xsl:text>
          <xsl:text disable-output-escaping="yes">&lt;!--[if IE 7]&gt;</xsl:text>
          <link href="{$style_include_prefix}search-ie7.css" rel="stylesheet" type="text/css" media="screen,print"/>
          <xsl:text disable-output-escaping="yes">&lt;![endif]--&gt;</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$mode = 'advanced'">
<style type="text/css" media="screen,print">
<xsl:comment>
/* &lt;![CDATA[ */
html{font-size:76%}
html,body{color:<xsl:value-of select="$global_text_color"/>;background:<xsl:value-of select="$global_bg_color"/>}
img,fieldset{border:0}
form,fieldset,dl,dt,dd,h1,h2,h3{margin:0;padding:0}
body{margin:8px}
body,div{font-family:<xsl:value-of select="$global_font"/>;font-size:<xsl:value-of select="$global_font_size"/>}
h2,h3,.param,.pair .name{clear:left}
.value,.name,.param,.pair,#lg a,#lg span{float:left}
h2{color:<xsl:value-of select="$global_text_color"/>;background:<xsl:value-of select="$sep_bar_bg_color"/>;border-top:1px solid <xsl:value-of select="$sep_bar_border_color"/>;padding:1px 4px;font-size:1.5em}
h3{font-size:1.3em}
fieldset,dl{height:1%;overflow:auto}
fieldset{border:3px solid #cbdced;margin-bottom:1.5em}
dl{line-height:1.75em;font-size:1.1em}
dt label{margin-left:2px;font-weight:bold}
.first{color:<xsl:value-of select="$global_text_color"/>;background:#cbdced}
.value{width:47%}
.name{width:38%}
.param{width:15%}
.pair{width:85%}
.pair .name{width:29%}
.pair .value{width:66%}
#lg a,#lg span{margin-right:11px;text-indent:-9999px;background:url("<xsl:value-of select="$logo_url"/>") no-repeat;height:<xsl:value-of select="$logo_height"/>;width:<xsl:value-of select="$logo_width"/>;overflow:hidden}
#co{clear:both;padding:3em 0 1em 0;text-align:center;font-size:1.1em;color:<xsl:value-of select="$global_co_color"/>;background:<xsl:value-of select="$global_bg_color"/>}
/* ]]&gt; */
</xsl:comment>
</style>

<style type="text/css" media="print">
<xsl:comment>
/* &lt;![CDATA[ */
fieldset{border:0 solid <xsl:value-of select="$global_bg_color"/>}
.first{background:<xsl:value-of select="$global_bg_color"/>}
.value,.name,.param,.pair{float:none;width:auto}
dt label{margin-left:0}
dd{margin-left:20px}
.pair .name,.pair .value{display:inline;width:auto}
.gs,#lg a,#lg span{display:none}
#lg:before{content:url("<xsl:value-of select="$logo_url"/>")}
/* ]]&gt; */
</xsl:comment>
</style>

<xsl:text disable-output-escaping="yes">
&lt;!--[if lte IE 7]&gt;&lt;style type="text/css" media="print"&gt;
#lg{display:list-item;margin:0;padding:0;list-style-image:url("</xsl:text><xsl:value-of select="$logo_url"/><xsl:text disable-output-escaping="yes">");list-style-position:inside;overflow:auto;height:1%}
fieldset,dl{height:auto}
&lt;/style&gt;&lt;![endif]--&gt;
</xsl:text>
        </xsl:when>

        <xsl:otherwise>
          <xsl:if test="$media != 'handheld'">
<style type="text/css" media="screen,print">
<xsl:comment>
/* &lt;![CDATA[ */<!--
*** Common ***
-->
html{font-size:76%}
h1,h2,h3,h4,h5,h6,form,fieldset,#nd,.sa,.sn,#su p,.s,.st,.fm,#sr,#km ul{margin:0;padding:0}
img,fieldset{border:0}
body,div{font-family:<xsl:value-of select="$global_font"/>;font-size:<xsl:value-of select="$global_font_size"/>;color:<xsl:value-of select="$global_text_color"/>}
body,.a,a:link,.f,.f:link,.f a:link,a:visited,.f a:visited,a:active,.f a:active{background:<xsl:value-of select="$global_bg_color"/>}
a:link{color:<xsl:value-of select="$global_link_color"/>}
a:visited,.f a:visited{color:<xsl:value-of select="$global_vlink_color"/>}
a:active,.f a:active{color:<xsl:value-of select="$global_alink_color"/>}
#co{clear:both;padding:3em 0 1em 0;text-align:center;font-size:1.1em;color:<xsl:value-of select="$global_co_color"/>}
.bt{vertical-align:bottom}
.z,#sk,#ns span.sp,#n span.sp,#sf h2,#sb h2,#re h3,.rn,#nd span,.sn span{display:none}
hr{clear:both;width:100%;height:1%;overflow:auto;margin-top:1em}<!--

*** Logo ***
--><xsl:if test="$show_logo != '0'">
#lg a,#lg span{float:left;margin-right:11px;text-indent:-9999px;overflow:hidden;height:<xsl:value-of select="$logo_height"/>;width:<xsl:value-of select="$logo_width"/>;background:url("<xsl:value-of select="$logo_url"/>") no-repeat}</xsl:if><!--

*** Search Within Results ***
--><xsl:if test="$mode = 'swr'">
#sr{font-size:1.3em}
#sr span{display:block}</xsl:if><!--

*** Desktop Nav ***
--><xsl:if test="$egds_show_search_tabs != '0'">
#nd{padding:4px 0 6px 0;font-size:1.1em}
#nd a{display:inline;list-style-type:none;margin-right:.75em}
#nd a:visited,#nd a:link,#nd a:active{color:#00c}</xsl:if><!--

*** Search Box (Header) ***
--><xsl:if test="$show_top_search_box = '1'">
#sf{float:left;font-size:1.1em;padding-bottom:.5em;margin-bottom:11px}
#sf form div{float:left;padding-right:6px}
.sa{font-size:1em}
.sn{float:left;list-style:none}
.sn a{display:block;font-size:.75em;padding:0;margin:0;line-height:1.1}</xsl:if><!--

*** Top Separation Bar ***
--><xsl:if test="$mode = 'advanced' or $mode = 'error' or (Q != '')">
#su{clear:both;height:1%;overflow:auto;width:100%;margin-bottom:4px;padding:1px 0;background:<xsl:value-of select="$sep_bar_bg_color"/>;border-top:1px solid <xsl:value-of select="$sep_bar_border_color"/>}
#su h2{float:left;font-size:1.5em;padding:0 2px}
#su p{float:right;font-size:1.1em;line-height:1.5em;padding:0 2px}</xsl:if><!--

*** Stopwords ***
--><xsl:if test="/GSP/CT">
#sw{color:gray;background:<xsl:value-of select="$global_bg_color"/>}</xsl:if><!--

*** Spelling and Synonyms ***
--><xsl:if test="/GSP/Spelling/Suggestion or /GSP/Synonyms/OneSynonym">
#sy,#ss{font-size:1.3em;margin:1em 0;background:<xsl:value-of select="$global_bg_color"/>}
#sy{color:<xsl:value-of select="$synonyms_text_color"/>}
#ss{color:<xsl:value-of select="$spelling_text_color"/>}</xsl:if><!--

*** OneBox ***
--><xsl:if test="$show_onebox != '0' and /GSP/ENTOBRESULTS">
div.oneboxResults{max-height:150px;overflow:hidden;font-size:1.35em}</xsl:if><!--

*** No Results ***
--><xsl:if test="not(RES or GM or Spelling or Synonyms or CT or /GSP/ENTOBRESULTS) and (Q != '')">
#er{font-size:1.3em}
#er p span{display:block}</xsl:if><!--

*** Result Page Navigation and Sort By (Header) ***
--><xsl:if test="($show_top_navigation != '0' or $show_sort_by != '0') and count(RES/R) > 0">
#ns{height:1%;overflow:auto;width:100%;clear:both}
#ns .np a:after{content:"&gt;"}
#ns .pp a:before{content:"&lt;"}
#nt,#so{font-size:1.1em;padding:0 2px;margin:1px 0;display:inline}</xsl:if><!--

*** Result Page Navigation ***
--><xsl:if test="$show_top_navigation = '1' and (RES/NB/PU or RES/NB/NU)">
#nt{float:left}
#nt a{margin-right:.75em}</xsl:if><!--

*** Sort By ***
--><xsl:if test="$show_sort_by != '0' and count(RES/R) > 0">
#so{float:right}
#so strong{font-weight:normal}
#so a,#so strong{margin-left:.75em}</xsl:if><!--

*** Keymatch ***
--><xsl:if test="$show_keymatch != '0' and count(/GSP/GM) > 0">
#km{margin:1em 0;clear:both;position:relative}
#km h3{float:right;background:transparent;font-size:1.1em;position:absolute;right:4px;top:4px;color:<xsl:value-of select="$keymatch_text_color"/>}
#km ul{list-style:none}
#km li{padding:4px;margin-bottom:.5em}
#km li,#km .l a, #km .a{background:<xsl:value-of select="$keymatch_bg_color"/>}
#km span{display:none}
#km .l{font-size:1.35em;display:inline}
#km .a{display:block;color:#008000;margin:0;padding:0;font-size:1.1em}</xsl:if><!--

*** Results ***
--><xsl:if test="count(RES/R) > 0">
#re{clear:both}
#re dt,#re dd{margin-left:0}
#re dd{margin-bottom:1em}
#re dt.l2,#re dd.l2{margin-left:40px}
#re .st,#re .a,#re .a:link{color:<xsl:value-of select="$res_url_color"/>}
#re .st,#re .fm{font-size:<xsl:value-of select="$res_url_size"/>}
#re .ft{font-size:<xsl:value-of select="$res_type_size"/>}
#re .f,#re .f:link,#re .f a:link{color:<xsl:value-of select="$faint_color"/>}
#re .l{font-size:<xsl:value-of select="$res_title_size"/>;color:<xsl:value-of select="$res_title_color"/>}
#re .s{font-size:<xsl:value-of select="$res_snippet_size"/>}
#re .s2,#re .fm{display:block}
#om{font-size:1.3em}</xsl:if><!--

*** Result Page Navigation (Footer) ***
--><xsl:if test="RES/NB/PU or RES/NB/NU">
#n{padding:1em 0 1.5em 0;font-size:1.15em}
#n h3,#n p,#n span,#n span a{margin:0;padding:0}
#n div.co{display:table;margin:0 auto}
#n h3{font-size:.95em;font-weight:normal;padding-right:.5em;vertical-align:bottom;white-space:nowrap}
#n p{display:table;text-align:center}
#n h3,#n span,#n span a,#n span strong{display:table-cell}
#n span a{color:<xsl:value-of select="$global_text_color"/>}
#n span.np a,#n span.pp a{color:#00c}
#n span.cp strong{color:#a90a08}
.b,.b a{color:#00c;font-weight:bold}
<xsl:choose>
<xsl:when test="$choose_bottom_navigation != 'google'">#n .ln h3,#n .ln span a,#n .ln span strong,#n .ln span.fp strong,#n .ln span.pp a,#n .ln span.np a,#n .ln span.lp strong{width:auto;padding:0 4px}</xsl:when>
<xsl:otherwise>#n .go h3,#n .go span a,#n .go span strong{width:16px}
#n .go span.fp strong{width:18px}
#n .go span.pp a{width:68px}
#n .go span.np a,#n .go span.lp strong{width:100px}
#n .go span a{background:url("nav_page.gif") no-repeat}
#n .go span.cp strong{background:url("nav_current.gif") no-repeat}
#n .go span.fp strong{background:url("nav_first.gif") no-repeat}
#n .go span.lp strong{background:url("nav_last.gif") no-repeat}
#n .go span.pp a{background:url("nav_previous.gif") no-repeat}
#n .go span.np a{background:url("nav_next.gif") no-repeat}
#n .go h3,#n .go span a,#n .go span strong{padding-top:26px}</xsl:otherwise>
</xsl:choose></xsl:if><!--

*** Search Box (Footer) ***
--><xsl:if test="$show_bottom_search_box = '1' and (RES or GM or Spelling or Synonyms or CT or /GSP/ENTOBRESULTS)">
#sb{clear:both;font-size:1.1em;margin:20px 0;padding:25px 6px 35px 6px;text-align:center;background:<xsl:value-of select="$sep_bar_bg_color"/>;border-top:1px solid <xsl:value-of select="$sep_bar_border_color"/>;border-bottom:1px solid <xsl:value-of select="$sep_bar_border_color"/>}
#sb .sn a{background:transparent}
#sb fieldset{text-align:left;margin-left:auto;margin-right:auto;display:inline}
#sb form div{float:left;padding-right:6px}</xsl:if>
/* ]]&gt; */
</xsl:comment>
</style>

<xsl:text>
</xsl:text>

<style type="text/css" media="print">
<xsl:comment>
/* &lt;![CDATA[ */
#sf,#sb,#n,#ns,#sy,p.fm,.st .rc,#om span,#sr span,#lg a,#lg span,#su .st,#nd{display:none}
#re dt+dd{page-break-inside:avoid}
a{text-decoration:none}
a:link,a:visited{color:<xsl:value-of select="$global_link_color"/>}
#lg:before{content:url("<xsl:value-of select="$logo_url"/>")}<!--

*** Keymatch ***
--><xsl:if test="$show_keymatch != '0' and count(/GSP/GM) > 0">
#km h3{background:#e8e8ff}</xsl:if>
/* ]]&gt; */
</xsl:comment>
</style>

<xsl:text disable-output-escaping="yes">
&lt;!--[if lte IE 7]&gt;&lt;style type="text/css" media="screen,print"&gt;
#n h3,#n span a,#n span strong{float:left}
div#n{position:relative;right:50%;float:right}
div.co{position:relative;left:50%;float:left}
#n span.sp{display:none}
&lt;/style&gt;&lt;style type="text/css" media="print"&gt;
#lg{display:list-item;margin:0;padding:0;list-style-image:url("</xsl:text><xsl:value-of select="$logo_url"/><xsl:text disable-output-escaping="yes">");list-style-position:inside;overflow:auto;height:1%}
#su{height:auto;overflow:visible}
&lt;/style&gt;&lt;![endif]--&gt;
&lt;!--[if IE 7]&gt;&lt;style type="text/css" media="screen,print"&gt;
#n .ln h3,#n .go h3{width:100%}
&lt;/style&gt;&lt;![endif]--&gt;
</xsl:text>
          </xsl:if>

<style type="text/css">
          <xsl:if test="$media != 'handheld'">
            <xsl:attribute name="media">handheld</xsl:attribute>
          </xsl:if>
<xsl:comment>
/* &lt;![CDATA[ */
body,.a,#sy,#ss,#sw,a:link,.f,.f:link,.f a:link,a:visited,.f a:visited,a:active,.f a:active{background:<xsl:value-of select="$global_bg_color"/>}
body{color:<xsl:value-of select="$global_text_color"/>}
.a{color:#008000}
#sy{color:<xsl:value-of select="$synonyms_text_color"/>}
#ss{color:<xsl:value-of select="$spelling_text_color"/>}
#sw{color:gray}
a:link{color:<xsl:value-of select="$global_link_color"/>}
.f,.f:link,.f a:link{color:<xsl:value-of select="$faint_color"/>}
a:visited,.f a:visited{color:<xsl:value-of select="$global_vlink_color"/>}
a:active,.f a:active{color:<xsl:value-of select="$global_alink_color"/>}
img,fieldset{border:0}
#lg a,#lg span{float:left;text-indent:-9999px;overflow:hidden;background:url("<xsl:value-of select="$logo_url_sm"/>") no-repeat;height:<xsl:value-of select="$logo_height_sm"/>;width:<xsl:value-of select="$logo_width_sm"/>}
#su h2:after,#km h3:after{content:":"}
#n .pp:after{content:", "}
dd .s:after{content:" - "}
#su,#om,#sr,#sf{clear:both}
.sa,p.fm{margin:0}
dd{margin-left:0;margin-bottom:1em}
h1{margin:0}
#su h2,#km h3,#km ul,#su p,.sn a,#co,fieldset{margin:0;padding:0}
#sf,#sf h2,#sb h2,#re h3,.sn span,#ns span,#sk,.s2,.sn .as,#nd,#su .st,#so strong,#n h3,#n span,.sa span{display:none}
#home #sf,#nt #so,#gs,#gs_f,dt,dd p.fm,#su h2,.sn a,.sa span.ac{display:block}
#n .pp,#n .np,dd p{display:inline}
.sn a{display:list-item}
#su h2,#km h3{font-size:1em}
#ns #so strong,dd strong,#su strong,dt .ft{font-weight:normal}
dt .rn{font-weight:bold}
.sn,#km ul{list-style:none}
.sa label{text-transform:capitalize}
#q, #q_f{width:10em}
/* ]]&gt; */
</xsl:comment>
</style>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 URL variables (do not customize)
     ********************************************************************** -->
<!-- *** if this is a test search (help variable)-->
<xsl:variable name="is_test_search" select="/GSP/PARAM[@name='testSearch']/@value"/>

<!-- *** if this is a search within results search *** -->
<xsl:variable name="swrnum">
  <xsl:choose>
    <xsl:when test="/GSP/PARAM[(@name='swrnum') and (@value!='')]">
      <xsl:value-of select="/GSP/PARAM[@name='swrnum']/@value"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="0"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- *** help_url: search tip URL (html file) *** -->
<xsl:variable name="help_url">/user_help.html</xsl:variable>

<!-- *** alerts_url: Alerts URL (html file) *** -->
<xsl:variable name="alerts_url">/alerts</xsl:variable>

<!-- *** base_url: collection info *** -->
<xsl:variable name="base_url">
  <xsl:for-each
    select="/GSP/PARAM[@name = 'client' or
                       @name = 'site' or
                       @name = 'num' or
                       @name = 'output' or
                       @name = 'proxystylesheet' or
                       @name = 'access' or
                       @name = 'lr' or
                       @name = 'ie']">
    <xsl:value-of select="@name"/>=<xsl:value-of select="@original_value"/>
    <xsl:if test="position() != last()">&amp;</xsl:if>
  </xsl:for-each>
</xsl:variable>

<!-- *** home_url: search? + collection info + &proxycustom=<HOME/> *** -->
<xsl:variable name="home_url">search?<xsl:value-of select="$base_url"
  />&amp;proxycustom=%3CHOME%2F%3E</xsl:variable>

<!-- *** synonym_url: does not include q, as_q, and start elements *** -->
<xsl:variable name="synonym_url"><xsl:for-each
  select="/GSP/PARAM[(@name != 'q') and
                     (@name != 'as_q') and
                     (@name != 'swrnum') and
                     (@name != 'ie') and
                     (@name != 'start') and
                     (@name != 'epoch' or $is_test_search != '') and
                     not(starts-with(@name, 'metabased_'))]">
    <xsl:value-of select="@name"/><xsl:text>=</xsl:text>
    <xsl:value-of select="@original_value"/>
    <xsl:if test="position() != last()">
      <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

<!-- *** search_url *** -->
<xsl:variable name="search_url">
  <xsl:for-each select="/GSP/PARAM[(@name != 'start') and
                                   (@name != 'swrnum') and
                     (@name != 'epoch' or $is_test_search != '') and
                     not(starts-with(@name, 'metabased_'))]">
    <xsl:value-of select="@name"/><xsl:text>=</xsl:text>
    <xsl:value-of select="@original_value"/>
    <xsl:if test="position() != last()">
      <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

<!-- *** filter_url: everything except resetting "filter=" *** -->
<xsl:variable name="filter_url">search?<xsl:for-each
  select="/GSP/PARAM[(@name != 'filter') and
                     (@name != 'epoch' or $is_test_search != '') and
                     not(starts-with(@name, 'metabased_'))]">
    <xsl:value-of select="@name"/><xsl:text>=</xsl:text>
    <xsl:value-of select="@original_value"/>
    <xsl:if test="position() != last()">
      <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
    </xsl:if>
  </xsl:for-each>
  <xsl:text disable-output-escaping='yes'>&amp;filter=</xsl:text>
</xsl:variable>

<!-- *** adv_search_url: search? + $search_url + as_q=$q *** -->
<xsl:variable name="adv_search_url">search?<xsl:value-of
  select="$search_url"/>&amp;proxycustom=%3CADVANCED%2F%3E</xsl:variable>

<!-- *** db_url_protocol: googledb:// *** -->
<xsl:variable name="db_url_protocol">googledb://</xsl:variable>

<!-- *** nfs_url_protocol: nfs:// *** -->
<xsl:variable name="nfs_url_protocol">nfs://</xsl:variable>

<!-- *** smb_url_protocol: smb:// *** -->
<xsl:variable name="smb_url_protocol">smb://</xsl:variable>

<!-- *** swr_search_url: search? + $search_url + as_q=$q *** -->
<xsl:variable name="swr_search_url">search?<xsl:value-of
  select="$search_url"/>&amp;swrnum=<xsl:value-of select="/GSP/RES/M"/></xsl:variable>

<!-- **********************************************************************
 Search Parameters (do not customize)
     ********************************************************************** -->

<!-- *** num_results: actual num_results per page *** -->
<xsl:variable name="num_results">
  <xsl:choose>
    <xsl:when test="/GSP/PARAM[(@name='num') and (@value!='')]">
      <xsl:value-of select="/GSP/PARAM[@name='num']/@value"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="10"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- *** form_params: parameters carried by the search input form *** -->
<xsl:template name="form_params">
  <xsl:for-each
    select="PARAM[@name != 'q' and
                  @name != 'ie' and
                  not(contains(@name, 'as_')) and
                  @name != 'btnG' and
                  @name != 'btnI' and
                  @name != 'site' and
                  @name != 'filter' and
                  @name != 'swrnum' and
                  @name != 'start' and
                  @name != 'access' and
                  @name != 'ip' and
                  (@name != 'epoch' or $is_test_search != '') and
                  not(starts-with(@name ,'metabased_'))]">
    <input type="hidden" name="{@name}" value="{@value}" />
    <xsl:if test="@name = 'oe'">
      <input type="hidden" name="ie" value="{@value}" />
    </xsl:if>
  </xsl:for-each>
  <xsl:if test="$search_collections_xslt = '' and PARAM[@name='site']">
    <input type="hidden" name="site" value="{PARAM[@name='site']/@value}"/>
  </xsl:if>
</xsl:template>

<!-- *** space_normalized_query: q = /GSP/Q *** -->
<xsl:variable name="qval">
  <xsl:value-of select="/GSP/Q"/>
</xsl:variable>

<xsl:variable name="qval_uri">
  <xsl:call-template name="uriencode">
    <xsl:with-param name="text" select="$qval"/>
  </xsl:call-template>
</xsl:variable>

<xsl:variable name="space_normalized_query">
  <xsl:value-of select="normalize-space($qval)" disable-output-escaping="yes"/>
</xsl:variable>

<!-- *** stripped_search_query: q, as_q, ... for cache highlight *** -->
<xsl:variable name="stripped_search_query"><xsl:for-each
  select="/GSP/PARAM[(@name = 'q') or
                     (@name = 'as_q') or
                     (@name = 'as_oq') or
                     (@name = 'as_epq')]"><xsl:value-of select="@original_value"
  /><xsl:if test="position() != last()"
  ><xsl:text disable-output-escaping="yes">+</xsl:text
  ></xsl:if></xsl:for-each>
</xsl:variable>

<xsl:variable name="access">
  <xsl:choose>
    <xsl:when test="/GSP/PARAM[(@name='access') and ((@value='s') or (@value='a'))]">
      <xsl:value-of select="/GSP/PARAM[@name='access']/@original_value"/>
    </xsl:when>
    <xsl:otherwise>p</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<!-- **********************************************************************
 Figure out what kind of page this is (do not customize)
     ********************************************************************** -->
<xsl:template match="GSP">
  <html xml:lang="en">
  <xsl:choose>
    <xsl:when test="Q">
      <xsl:choose>
        <xsl:when test="$swrnum != 0">
          <xsl:attribute name="id">swr</xsl:attribute>
          <xsl:call-template name="front_door">
            <xsl:with-param name="type" select="'swr'"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="id">results</xsl:attribute>
          <xsl:call-template name="search_results"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:when test="CACHE">
      <xsl:attribute name="id">cache</xsl:attribute>
      <xsl:call-template name="cached_page"/>
    </xsl:when>
    <xsl:when test="CUSTOM/HOME">
      <xsl:attribute name="id">home</xsl:attribute>
      <xsl:call-template name="front_door"/>
    </xsl:when>
    <xsl:when test="CUSTOM/ADVANCED">
      <xsl:attribute name="id">advanced</xsl:attribute>
      <xsl:call-template name="advanced_search"/>
    </xsl:when>
    <xsl:when test="ERROR">
      <xsl:attribute name="id">error</xsl:attribute>
      <xsl:call-template name="error_page">
        <xsl:with-param name="errorMessage" select="$server_error_msg_text"/>
        <xsl:with-param name="errorDescription" select="$server_error_des_text"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:attribute name="id">error</xsl:attribute>
      <xsl:call-template name="error_page">
        <xsl:with-param name="errorMessage" select="$xml_error_msg_text"/>
        <xsl:with-param name="errorDescription" select="$xml_error_des_text"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
  </html>
</xsl:template>

<!-- **********************************************************************
 Cached page (do not customize)
     ********************************************************************** -->
<xsl:template name="cached_page">
  <xsl:variable name="cached_page_url" select="CACHE/CACHE_URL"/>
  <xsl:variable name="cached_page_html" select="CACHE/CACHE_HTML"/>

  <!-- *** decide whether to load html page or pdf file *** -->
  <xsl:if test="'.pdf' != substring($cached_page_url,
                1 + string-length($cached_page_url) - string-length('.pdf')) and
                not(starts-with($cached_page_url, $db_url_protocol)) and
                not(starts-with($cached_page_url, $smb_url_protocol)) and
                not(starts-with($cached_page_url, $nfs_url_protocol))">
    <base href="{$cached_page_url}"/>
  </xsl:if>

  <!-- *** display cache page header *** -->
  <xsl:call-template name="cached_page_header">
    <xsl:with-param name="cached_page_url" select="$cached_page_url"/>
  </xsl:call-template>

  <!-- *** display cached contents *** -->
  <xsl:value-of select="$cached_page_html" disable-output-escaping="yes"/>
</xsl:template>

<xsl:template name="escape_quot">
  <xsl:param name="string"/>
  <xsl:call-template name="replace_string">
    <xsl:with-param name="find" select="'&quot;'"/>
    <xsl:with-param name="replace" select="'&amp;quot;'"/>
    <xsl:with-param name="string" select="$string"/>
  </xsl:call-template>
</xsl:template>

<!-- **********************************************************************
 Advanced search page (do not customize)
     ********************************************************************** -->
<xsl:template name="advanced_search">

  <xsl:variable name="html_escaped_as_q">
    <xsl:call-template name="escape_quot">
      <xsl:with-param name="string" select="/GSP/PARAM[@name='q']/@value"/>
    </xsl:call-template>
    <xsl:if test="/GSP/PARAM[@name='as_q']/@value != ''">
      <xsl:value-of select="' '"/>
      <xsl:call-template name="escape_quot">
        <xsl:with-param name="string" select="/GSP/PARAM[@name='as_q']/@value"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>

  <xsl:variable name="html_escaped_as_epq">
    <xsl:call-template name="escape_quot">
      <xsl:with-param name="string" select="/GSP/PARAM[@name='as_epq']/@value"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="html_escaped_as_oq">
    <xsl:call-template name="escape_quot">
      <xsl:with-param name="string" select="/GSP/PARAM[@name='as_oq']/@value"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="html_escaped_as_eq">
    <xsl:call-template name="escape_quot">
      <xsl:with-param name="string" select="/GSP/PARAM[@name='as_eq']/@value"/>
    </xsl:call-template>
  </xsl:variable>

  <head>
  <xsl:call-template name="head_elements"/>
  <title><xsl:value-of select="$adv_page_title"/></title>
  <xsl:call-template name="style">
    <xsl:with-param name="mode" select="'advanced'"/>
  </xsl:call-template>

  <script type="text/javascript">
<xsl:text disable-output-escaping="yes">
//&lt;![CDATA[
function setFocus(){if(document.getElementById){document.getElementById('as_q').focus();}}
//]]&gt;
</xsl:text>
  </script>

  </head>

  <body onload="setFocus()" dir="ltr">

  <!-- *** Customer's own advanced search page header *** -->
  <xsl:if test="$choose_adv_search_page_header = 'mine' or
                $choose_adv_search_page_header = 'both'">
    <xsl:call-template name="my_page_header"/>
  </xsl:if>

  <!--====Advanced Search Header======-->
  <xsl:if test="$choose_adv_search_page_header = 'provided' or
                $choose_adv_search_page_header = 'both'">
    <xsl:call-template name="advanced_search_header"/>
  </xsl:if>

  <xsl:call-template name="top_sep_bar">
    <xsl:with-param name="text" select="$sep_bar_adv_text"/>
    <xsl:with-param name="show_info" select="0"/>
    <xsl:with-param name="time" select="0"/>
  </xsl:call-template>

  <!--====Carry over Search Parameters======-->
  <form method="get" action="search" id="as"><fieldset>
    <xsl:if test="PARAM[@name='client']">
      <input type="hidden" name="client" value="{PARAM[@name='client']/@value}" />
    </xsl:if>

    <!--==== site is carried over in the drop down if the menu is used =====-->
    <xsl:if test="$search_collections_xslt = '' and PARAM[@name='site']">
      <input type="hidden" name="site" value="{PARAM[@name='site']/@value}"/>
    </xsl:if>
    <xsl:call-template name="hidden_field">
      <xsl:with-param name="name" select="'output,proxystylesheet,ie,oe,hl,getfields,requiredfields,partialfields,'"/>
    </xsl:call-template>

    <!--====Advanced Search Options======-->
    <dl class="first">
      <dt class="param">
        <label for="as_q">Find Results</label>
      </dt>
      <dd>
        <div class="pair">
          <span class="name">
            <label for="as_q">with <strong>all</strong> of the words</label>
          </span>
          <xsl:text> </xsl:text>
          <span class="value">
            <input id="as_q" type="text" name="as_q" size="25">
              <xsl:attribute name="value">
                <xsl:value-of select="$html_escaped_as_q"/>
              </xsl:attribute>
            </input>
            <xsl:text> </xsl:text>
            <select name="num">
              <xsl:call-template name="select_option">
                <xsl:with-param name="name" select="'num'"/>
                <xsl:with-param name="value" select="'10,20,30,50,100,'"/>
                <xsl:with-param name="desc" select="'10 results,20 results,30 results,50 results,100 results,'"/>
              </xsl:call-template>
            </select>
            <xsl:text> </xsl:text>
            <xsl:call-template name="collection_menu"/>
            <xsl:text> </xsl:text>
            <input type="submit" name="btnG" class="gs" value="{$search_button_text}" />
          </span>
          <br />
          <span class="name">
            <label for="as_epq">with the <strong>exact phrase</strong></label>
          </span>
          <xsl:text> </xsl:text>
          <span class="value">
            <input id="as_epq" type="text" name="as_epq" size="25">
              <xsl:attribute name="value">
                <xsl:value-of select="$html_escaped_as_epq"/>
              </xsl:attribute>
            </input>
          </span>
          <br />
          <span class="name">
            <label for="as_oq">with <strong>at least one</strong> of the words</label>
          </span>
          <xsl:text> </xsl:text>
          <span class="value">
            <input id="as_oq" type="text" name="as_oq" size="25">
              <xsl:attribute name="value">
                <xsl:value-of select="$html_escaped_as_oq"/>
              </xsl:attribute>
            </input>
          </span>
          <br />
          <span class="name">
            <label for="as_eq"><strong>without</strong> the words</label>
          </span>
          <xsl:text> </xsl:text>
          <span class="value">
            <input id="as_eq" type="text" name="as_eq" size="25">
              <xsl:attribute name="value">
                <xsl:value-of select="$html_escaped_as_eq"/>
              </xsl:attribute>
            </input>
          </span>
        </div>
      </dd>
    </dl>
    <dl>
      <dt class="param"><label for="lr">Language</label></dt>
      <dd>
        <span class="name">
          <label for="lr">Return pages written in</label>
        </span>
        <xsl:text> </xsl:text>
        <span class="value">
          <select name="lr" id="lr">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'lr'"/>
              <xsl:with-param name="value" select="',lang_ar,lang_zh-CN,lang_zh-TW,lang_cs,lang_da,lang_nl,lang_en,lang_et,lang_fi,lang_fr,lang_de,lang_el,lang_iw,lang_hu,lang_is,lang_it,lang_ja,lang_ko,lang_lv,lang_lt,lang_no,lang_pl,lang_pt,lang_ro,lang_ru,lang_es,lang_sv,'"/>
              <xsl:with-param name="desc" select="'any language,Arabic,Chinese (Simplified),Chinese (Traditional),Czech,Danish,Dutch,English,Estonian,Finnish,French,German,Greek,Hebrew,Hungarian,Icelandic,Italian,Japanese,Korean,Latvian,Lithuanian,Norwegian,Polish,Portuguese,Romanian,Russian,Spanish,Swedish,'"/>
            </xsl:call-template>
          </select>
        </span>
      </dd>
      <dt class="param"><label for="as_filetype">File Format</label></dt>
      <dd>
        <span class="name">
          <select name="as_ft" id="as_ft">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'as_ft'"/>
              <xsl:with-param name="value" select="'i,e,'"/>
              <xsl:with-param name="desc" select="concat('Only,Don',$apos,'t,')"/>
            </xsl:call-template>
          </select>
          <xsl:text> </xsl:text>
          <label for="as_filetype">return results of the file format</label>
        </span>
        <xsl:text> </xsl:text>
        <span class="value">
          <select name="as_filetype" id="as_filetype">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'as_filetype'"/>
              <xsl:with-param name="value" select="',pdf,ps,doc,xls,ppt,rtf,'"/>
              <xsl:with-param name="desc" select="'any format,Adobe Acrobat PDF (.pdf),Adobe Postscript (.ps),Microsoft Word (.doc),Microsoft Excel (.xls),Microsoft Powerpoint (.ppt),Rich Text Format (.rtf),'"/>
            </xsl:call-template>
          </select>
        </span>
      </dd>
      <dt class="param"><label for="as_occt">Occurrences</label></dt>
      <dd>
        <span class="name"><label for="as_occt">Return results where my terms occur</label></span>
        <xsl:text> </xsl:text>
        <span class="value">
          <select name="as_occt" id="as_occt">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'as_occt'"/>
              <xsl:with-param name="value" select="'any,title,url,'"/>
              <xsl:with-param name="desc" select="'anywhere in the page,in the title of the page,in the URL of the page,'"/>
            </xsl:call-template>
          </select>
        </span>
      </dd>
      <dt class="param"><label for="as_sitesearch">Domain</label></dt>
      <dd>
        <span class="name">
          <select name="as_dt" id="as_dt">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'as_dt'"/>
              <xsl:with-param name="value" select="'i,e,'"/>
              <xsl:with-param name="desc" select="concat('Only,Don',$apos,'t,')"/>
            </xsl:call-template>
          </select>
          <xsl:text> </xsl:text>
          <label for="as_sitesearch">return results from the site or domain</label>
        </span>
        <xsl:text> </xsl:text>
        <span class="value">
          <input type="text" size="25" name="as_sitesearch" id="as_sitesearch">
            <xsl:attribute name="value">
              <xsl:if test="PARAM[@name='as_sitesearch']">
                <xsl:value-of select="PARAM[@name='as_sitesearch']/@value"/>
              </xsl:if>
            </xsl:attribute>
          </input><br /><em>e.g. google.com, .org</em>
        </span>
      </dd>

      <!-- Sort by Date feature -->
      <dt class="param"><label for="sort">Sort</label></dt>
      <dd>
        <div class="pair">
          <select name="sort" id="sort">
            <xsl:call-template name="select_option">
              <xsl:with-param name="name" select="'sort'"/>
              <xsl:with-param name="value" select="',date:D:S:d1,'"/>
              <xsl:with-param name="desc" select="'Sort by relevance,Sort by date,'"/>
            </xsl:call-template>
          </select>
        </div>
      </dd>

      <!-- Secure Search feature -->
      <xsl:if test="$show_secure_radio != '0'">
        <dt class="param"><label for="as_access_p">Security</label></dt>
        <dd>
          <div class="pair">
            <input type="radio" name="access" id="as_access_p" value="p">
              <xsl:if test="$access='p'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
            <label for="as_access_p">Search public content only</label>
            <xsl:text> </xsl:text>
            <input type="radio" name="access" id="as_access_a" value="a">
              <xsl:if test="$access='a'">
                <xsl:attribute name="checked">checked</xsl:attribute>
              </xsl:if>
            </input>
            <label for="as_access_a">Search public and secure content (login required)</label>
          </div>
        </dd>
      </xsl:if>
    </dl>
  </fieldset></form>

  <!--====Page-Specific Search======-->
  <h3>Page-Specific Search</h3>
  <form method="get" action="search" id="h"><fieldset>
    <dl>
      <dt class="param"><label for="as_lq">Links</label></dt>
      <dd>
        <span class="name"><label for="as_lq">Find pages that link to the page</label></span>
        <xsl:text> </xsl:text>
        <span class="value">
          <input type="text" size="30" name="as_lq" id="as_lq">
            <xsl:attribute name="value">
              <xsl:if test="PARAM[@name='as_lq']">
                <xsl:value-of select="PARAM[@name='as_lq']/@value"/>
              </xsl:if>
            </xsl:attribute>
          </input>
          <xsl:text> </xsl:text>
          <input type="submit" name="btnG" class="gs" value="{$search_button_text}" />
        </span>
      </dd>
    </dl>
  </fieldset></form>

  <xsl:call-template name="copyright"/>

  <!-- *** Customer's own advanced search page footer *** -->
  <xsl:call-template name="my_page_footer"/>

  </body>
</xsl:template>


<!-- **********************************************************************
 Search results (do not customize)
     ********************************************************************** -->
<xsl:template name="search_results">

  <!-- *** HTML header and style *** -->
  <head>
  <xsl:call-template name="head_elements"/>
    <title>
      <xsl:value-of select="$result_page_title"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="$space_normalized_query"/>
    </title>
    <xsl:call-template name="style">
      <xsl:with-param name="mode" select="'results'"/>
    </xsl:call-template>
  </head>

  <body dir="ltr">

  <!-- *** Customer's own result page header *** -->
  <xsl:if test="$choose_result_page_header = 'mine' or
                $choose_result_page_header = 'both'">
    <xsl:call-template name="my_page_header"/>
  </xsl:if>

  <!-- *** Result page header *** -->
  <xsl:if test="$choose_result_page_header = 'provided' or
                $choose_result_page_header = 'both'">
    <xsl:call-template name="result_page_header" />
  </xsl:if>

  <!-- *** Top separation bar *** -->
  <xsl:if test="Q != ''">
    <xsl:call-template name="top_sep_bar">
      <xsl:with-param name="text" select="$sep_bar_std_text"/>
        <xsl:with-param name="show_info" select="$show_search_info"/>
      <xsl:with-param name="time" select="TM"/>
    </xsl:call-template>
  </xsl:if>

  <!-- *** Handle results (if any) *** -->
  <xsl:choose>
    <xsl:when test="RES or GM or Spelling or Synonyms or CT or /GSP/ENTOBRESULTS">
      <xsl:call-template name="results">
        <xsl:with-param name="query" select="Q"/>
        <xsl:with-param name="time" select="TM"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="Q=''">
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="no_RES">
        <xsl:with-param name="query" select="Q"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>

  <!-- *** Google footer *** -->
  <xsl:call-template name="copyright"/>

  <!-- *** Customer's own result page footer *** -->
  <xsl:call-template name="my_page_footer"/>

  <!-- *** HTML footer *** -->
  </body>

</xsl:template>

<!-- **********************************************************************
  Collection menu beside the search box
     ********************************************************************** -->
<xsl:template name="collection_menu">
  <xsl:if test="$search_collections_xslt != ''">
    <select name="site">
      <xsl:call-template name="select_option">
        <xsl:with-param name="name" select="'site'"/>
        <xsl:with-param name="value" select="'default_collection,googleenterprise,'"/>
        <xsl:with-param name="desc" select="'Default Collection,Google Enterprise,'"/>
      </xsl:call-template>
    </select>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
  Search box input form (Types: std_top, std_bottom, home, swr)
     ********************************************************************** -->
<xsl:template name="search_box">
  <xsl:param name="type"/>

  <xsl:variable name="swr_directions">
    <xsl:choose>
      <xsl:when test="$media = 'handheld'">Search within these results.</xsl:when>
      <xsl:otherwise>Use the search box below to search within these results.</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="id_suffix"><xsl:if test="$type='std_bottom'">_f</xsl:if></xsl:variable>

  <xsl:if test="($egds_show_search_tabs != '0') and (($type = 'home') or ($type = 'std_top'))">
    <xsl:call-template name="desktop_tab"/>
  </xsl:if>
  <xsl:if test="($type = 'swr')">
    <p id="sr">
      <xsl:text>There were about </xsl:text>
      <strong><xsl:value-of select="RES/M"/></strong>
      <xsl:text> results for </xsl:text>
      <strong><xsl:value-of select="$space_normalized_query"/></strong>
      <xsl:text>. </xsl:text>
      <span><xsl:value-of select="$swr_directions" /></span>
    </p>
  </xsl:if>

  <div>

  <xsl:attribute name="id">
    <xsl:choose>
      <xsl:when test="$type='std_bottom'">sb</xsl:when>
      <xsl:otherwise>sf</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>

  <form method="get" action="search"><h2><label for="q{$id_suffix}">Query</label></h2><fieldset>
    <div>
    <input type="text" id="q{$id_suffix}" size="{$search_box_size}" maxlength="256" value="" alt="Query" title="Enter search query">
      <xsl:choose>
        <xsl:when test="($type = 'swr')">
          <xsl:attribute name="name">as_q</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="name">q</xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="$space_normalized_query"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>
    <xsl:if test="($type = 'swr')"><input type="hidden" name="q" value="{$qval}"/></xsl:if>

    <xsl:text> </xsl:text>
    <xsl:call-template name="collection_menu"/>
    <xsl:text> </xsl:text>

    <input name="btnG" id="gs{$id_suffix}" value="{$search_button_text}">
      <xsl:choose>
        <xsl:when test="$choose_search_button = 'image'">
          <xsl:attribute name="type">image</xsl:attribute>
          <xsl:attribute name="class">bt</xsl:attribute>
          <xsl:attribute name="src">
            <xsl:value-of select="$search_button_image_url"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type">submit</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </input>
    <xsl:call-template name="form_params"/>
    <xsl:if test="$show_secure_radio != '0'">
      <p class="sa">
        <span>Search: </span>
        <span class="ac"><input type="radio" name="access" id="access_p{$id_suffix}" value="p">
          <xsl:if test="$access='p'">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>
        </input>
        <label for="access_p">public content</label></span>
        <xsl:text> </xsl:text>
        <span class="ac"><input type="radio" name="access" id="access_a{$id_suffix}" value="a">
          <xsl:if test="$access='a'">
            <xsl:attribute name="checked">checked</xsl:attribute>
          </xsl:if>
        </input>
        <label for="access_a">public and secure content</label></span>
      </p>
    </xsl:if>
    </div>

    <xsl:if test="((/GSP/RES/M>0) and ($show_swr_link!='0') and ($type='std_bottom')) or ($show_result_page_adv_link != '0') or ($show_alerts_link != '0') or ($show_result_page_help_link != '0')">
      <p class="sn">
        <xsl:if test="$media = 'handheld' and not(/GSP/CUSTOM/HOME)">
          <a href="{$home_url}">Appliance</a><span>, </span>
        </xsl:if>
        <xsl:if test="(/GSP/RES/M>0) and ($show_swr_link!='0') and ($type='std_bottom')">
          <a href="{$swr_search_url}">
            <xsl:value-of select="$swr_search_anchor_text"/>
          </a><span>, </span>
        </xsl:if>
        <xsl:if test="$show_result_page_adv_link != '0'">
          <a class="as" href="{$adv_search_url}">
            <xsl:value-of select="$adv_search_anchor_text"/>
          </a><span class="as">, </span>
        </xsl:if>
        <xsl:if test="$show_alerts_link != '0'">
          <a href="{$alerts_url}">
            <xsl:value-of select="$alerts_anchor_text"/>
          </a><span>, </span>
        </xsl:if>
        <xsl:if test="$show_result_page_help_link != '0'">
          <a href="{$help_url}">
            <xsl:value-of select="$search_help_anchor_text"/>
          </a>
        </xsl:if>
        <span>.</span>
      </p>
    </xsl:if>
  </fieldset></form>

  </div>
</xsl:template>

<!-- **********************************************************************
  Bottom search box (do not customized)
     ********************************************************************** -->
<xsl:template name="bottom_search_box">
  <xsl:call-template name="search_box">
    <xsl:with-param name="type" select="'std_bottom'"/>
  </xsl:call-template>
</xsl:template>

<!-- **********************************************************************
 Sort-by criteria: sort by date/relevance
     ********************************************************************** -->
<xsl:template name="sort_by">
  <xsl:variable name="sort_by_url"><xsl:for-each
    select="/GSP/PARAM[(@name != 'sort') and
                       (@name != 'start') and
                       (@name != 'epoch' or $is_test_search != '') and
                       not(starts-with(@name, 'metabased_'))]">
      <xsl:value-of select="@name"/><xsl:text>=</xsl:text>
      <xsl:value-of select="@original_value"/>
      <xsl:if test="position() != last()">
        <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="sort_by_relevance_url">
    <xsl:value-of select="$sort_by_url"
      />&amp;sort=date%3AD%3AL%3Ad1</xsl:variable>

  <xsl:variable name="sort_by_date_url">
    <xsl:value-of select="$sort_by_url"
      />&amp;sort=date%3AD%3AS%3Ad1</xsl:variable>

  <xsl:text> </xsl:text>
  <p id="so">
    <xsl:choose>
      <xsl:when test="/GSP/PARAM[@name = 'sort' and (starts-with(@value,'date:D:S') or starts-with(@value,'date:A:S'))]">
        <strong>Sort by date</strong><span class="sp">,</span><xsl:text> </xsl:text>
        <a href="search?{$sort_by_relevance_url}">Sort by relevance</a>
      </xsl:when>
      <xsl:otherwise>
        <a href="search?{$sort_by_date_url}">Sort by date</a><span class="sp">,</span><xsl:text> </xsl:text>
        <strong>Sort by relevance</strong>
      </xsl:otherwise>
    </xsl:choose>
    <span class="sp">.</span>
  </p>

</xsl:template>

<!-- **********************************************************************
 Output all results
     ********************************************************************** -->
<xsl:template name="results">
  <xsl:param name="query"/>
  <xsl:param name="time"/>

  <!-- *** Add top navigation/sort-by bar *** -->
  <xsl:if test="($show_top_navigation != '0' or $show_sort_by != '0') and count(RES/R)>0">
    <div id="ns">
      <xsl:if test="$show_top_navigation != '0'">
        <xsl:call-template name="google_navigation">
          <xsl:with-param name="prev" select="RES/NB/PU"/>
          <xsl:with-param name="next" select="RES/NB/NU"/>
          <xsl:with-param name="view_begin" select="RES/@SN"/>
          <xsl:with-param name="view_end" select="RES/@EN"/>
          <xsl:with-param name="guess" select="RES/M"/>
          <xsl:with-param name="navigation_style" select="'top'"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$show_sort_by != '0'">
        <xsl:call-template name="sort_by"/>
      </xsl:if>
    </div>
  </xsl:if>

  <!-- *** Handle OneBox results, if any ***-->
  <xsl:if test="$show_onebox != '0'">
    <xsl:if test="/GSP/ENTOBRESULTS">
      <xsl:call-template name="onebox"/>
    </xsl:if>
  </xsl:if>

  <!-- *** Handle spelling suggestions, if any *** -->
  <xsl:if test="$show_spelling != '0'">
    <xsl:call-template name="spelling"/>
  </xsl:if>

  <!-- *** Handle synonyms, if any *** -->
  <xsl:if test="$show_synonyms != '0'">
    <xsl:call-template name="synonyms"/>
  </xsl:if>

  <!-- *** Output Google Desktop results (if enabled and any available) *** -->
  <xsl:if test="$egds_show_desktop_results != '0'">
    <xsl:call-template name="desktop_results"/>
  </xsl:if>

  <!-- *** Output results details *** -->

  <!-- for keymatch results -->
  <xsl:if test="$show_keymatch != '0' and count(/GSP/GM)>0">
    <div id="km">
      <h3><xsl:value-of select="$keymatch_text"/></h3>
      <ul>
        <xsl:apply-templates select="/GSP/GM"/>
      </ul>
    </div>
  </xsl:if>

  <!-- for real results -->
  <xsl:if test="count(RES/R)>0">
    <div id="re">
      <h3>Results</h3>
      <dl>
        <xsl:apply-templates select="RES/R">
          <xsl:with-param name="query" select="$query"/>
        </xsl:apply-templates>
      </dl>

      <!-- *** Filter note (if needed) *** -->
      <xsl:if test="(RES/FI) and (not(RES/NB/NU))">
        <p id="om"><em>In order to show you the most relevant results, we have omitted some entries very similar to the <xsl:value-of select="RES/@EN"/> already displayed. <span>If you like, you can <a href="{$filter_url}0">repeat the search with the omitted results included</a>.</span></em></p>
      </xsl:if>
    </div>

    <!-- *** Add bottom navigation *** -->
    <xsl:variable name="nav_style">
      <xsl:choose>
        <xsl:when test="($access='s') or ($access='a')">simple</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$choose_bottom_navigation"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="google_navigation">
      <xsl:with-param name="prev" select="RES/NB/PU"/>
      <xsl:with-param name="next" select="RES/NB/NU"/>
      <xsl:with-param name="view_begin" select="RES/@SN"/>
      <xsl:with-param name="view_end" select="RES/@EN"/>
      <xsl:with-param name="guess" select="RES/M"/>
      <xsl:with-param name="navigation_style" select="$nav_style"/>
    </xsl:call-template>
  </xsl:if>

  <xsl:if test="$media = 'handheld' and count(/GSP/RES/R)>0"><hr/></xsl:if>

  <!-- *** Bottom search box *** -->
  <xsl:if test="$show_bottom_search_box != '0'">
    <xsl:call-template name="bottom_search_box"/>
  </xsl:if>

</xsl:template>

<!-- **********************************************************************
 Stopwords suggestions in result page (do not customize)
     ********************************************************************** -->
<xsl:template name="stopwords">
  <xsl:variable name="stopwords_suggestions1">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="'/help/basics.html#stopwords'"/>
      <xsl:with-param name="replace" select="'user_help.html#stop'"/>
      <xsl:with-param name="string" select="/GSP/CT"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="stopwords_suggestions2">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="'/help/basics.html'"/>
      <xsl:with-param name="replace" select="'user_help.html'"/>
      <xsl:with-param name="string" select="$stopwords_suggestions1"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="stopwords_suggestions3">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="'A HREF'"/>
      <xsl:with-param name="replace" select="'a href'"/>
      <xsl:with-param name="string" select="$stopwords_suggestions2"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="stopwords_suggestions">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="'&lt;/A&gt;]&lt;br&gt;'"/>
      <xsl:with-param name="replace" select="'&lt;/a&gt;]&lt;br /&gt;'"/>
      <xsl:with-param name="string" select="$stopwords_suggestions3"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="/GSP/CT">
    <xsl:value-of disable-output-escaping="yes"
      select="$stopwords_suggestions"/>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Spelling suggestions in result page (do not customize)
     ********************************************************************** -->
<xsl:template name="spelling">
  <xsl:if test="/GSP/Spelling/Suggestion">
    <p id="ss">
      <xsl:value-of select="$spelling_text"/><xsl:text> </xsl:text>
      <a href="search?q={/GSP/Spelling/Suggestion[1]/@qe}&amp;spell=1&amp;{$base_url}">
     <xsl:variable name="suggestion">
       <xsl:call-template name="reformat_semantic">
         <xsl:with-param name="markup" select="/GSP/Spelling/Suggestion[1]"/>
       </xsl:call-template>
     </xsl:variable>
      <xsl:value-of disable-output-escaping="yes" select="$suggestion"/>
      </a>
    </p>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Synonym suggestions in result page (do not customize)
     ********************************************************************** -->
<xsl:template name="synonyms">
  <xsl:if test="/GSP/Synonyms/OneSynonym">
  <p id="sy">
    <xsl:value-of select="$synonyms_text"/><xsl:text> </xsl:text>
    <xsl:for-each select="/GSP/Synonyms/OneSynonym">
      <a href="search?q={@q}&amp;{$synonym_url}">
        <xsl:value-of disable-output-escaping="yes" select="."/>
      </a>
      <xsl:text> </xsl:text>
    </xsl:for-each>
  </p>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Truncation functions (do not customize)
     ********************************************************************** -->
<xsl:template name="truncate_url">
  <xsl:param name="t_url"/>
  <xsl:choose>
    <xsl:when test="string-length($t_url) &lt; $truncate_result_url_length">
      <xsl:value-of select="$t_url"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="first" select="substring-before($t_url, '/')"/>
      <xsl:variable name="last">
        <xsl:call-template name="truncate_find_last_token">
          <xsl:with-param name="t_url" select="$t_url"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="path_limit" select="$truncate_result_url_length - (string-length($first) + string-length($last) + 1)"/>
      <xsl:choose>
        <xsl:when test="$path_limit &lt;= 0">
          <xsl:value-of select="concat(substring($t_url, 1, $truncate_result_url_length), '...')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="chopped_path">
            <xsl:call-template name="truncate_chop_path">
              <xsl:with-param name="path" select="substring($t_url, string-length($first) + 2, string-length($t_url) - (string-length($first) + string-length($last) + 1))"/>
              <xsl:with-param name="path_limit" select="$path_limit"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:value-of select="concat($first, '/.../', $chopped_path, $last)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="truncate_find_last_token">
  <xsl:param name="t_url"/>
  <xsl:choose>
    <xsl:when test="contains($t_url, '/')">
      <xsl:call-template name="truncate_find_last_token">
        <xsl:with-param name="t_url" select="substring-after($t_url, '/')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$t_url"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="truncate_chop_path">
  <xsl:param name="path"/>
  <xsl:param name="path_limit"/>
  <xsl:choose>
    <xsl:when test="string-length($path) &lt;= $path_limit">
      <xsl:value-of select="$path"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="truncate_chop_path">
        <xsl:with-param name="path" select="substring-after($path, '/')"/>
        <xsl:with-param name="path_limit" select="$path_limit"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
  A single result (do not customize)
     ********************************************************************** -->
<xsl:template match="R">
  <xsl:param name="query"/>
  <xsl:variable name="display_url_tmp" select="substring-after(UD, '://')"/>
  <xsl:variable name="display_url">
    <xsl:choose>
      <xsl:when test="$display_url_tmp">
        <xsl:value-of select="$display_url_tmp"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after(U, '://')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="escaped_url" select="substring-after(UE, '://')"/>
  <xsl:variable name="protocol" select="substring-before(U, '://')"/>
  <xsl:variable name="full_url" select="UE"/>
  <xsl:variable name="crowded_url" select="HN/@U"/>
  <xsl:variable name="crowded_display_url" select="HN"/>
  <xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <xsl:variable name="temp_url" select="substring-after(U, '://')"/>
  <xsl:variable name="url_indexed" select="not(starts-with($temp_url, 'noindex!/'))"/>
  <xsl:variable name="stripped_url">
    <xsl:choose>
      <xsl:when test="$truncate_result_urls != '0'">
        <xsl:call-template name="truncate_url">
          <xsl:with-param name="t_url" select="$display_url"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$display_url"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="result_num" select="(@N)-(/GSP/RES/@SN)+1"/>

  <!-- *** Indent as required (only supports 2 levels) *** -->
  <xsl:variable name="level"><xsl:if test="@L='2'">l2</xsl:if></xsl:variable>

  <!-- *** Result Header *** -->
  <dt>
    <xsl:if test="$level != ''">
      <xsl:attribute name="class"><xsl:value-of select="$level"/></xsl:attribute>
    </xsl:if>
    <span class="rn"><xsl:value-of select="$result_num"/>.</span>
    <xsl:text> </xsl:text>

    <!-- *** Result Title (including PDF tag and hyperlink) *** -->
    <xsl:if test="$show_res_title != '0'">
      <xsl:variable name="res_type">
        <xsl:choose>
          <xsl:when test="@MIME='text/html' or @MIME='' or not(@MIME)"></xsl:when>
          <xsl:when test="@MIME='text/plain'">[TEXT]</xsl:when>
          <xsl:when test="@MIME='application/rtf'">[RTF]</xsl:when>
          <xsl:when test="@MIME='application/pdf'">[PDF]</xsl:when>
          <xsl:when test="@MIME='application/postscript'">[PS]</xsl:when>
          <xsl:when test="@MIME='application/vnd.ms-powerpoint'">[MS POWERPOINT]</xsl:when>
          <xsl:when test="@MIME='application/vnd.ms-excel'">[MS EXCEL]</xsl:when>
          <xsl:when test="@MIME='application/msword'">[MS WORD]</xsl:when>
          <xsl:otherwise>
            <xsl:variable name="extension">
              <xsl:call-template name="last_substring_after">
                <xsl:with-param name="string" select="substring-after(
                                                      substring-after(U,'://'),
                                                      '/')"/>
                <xsl:with-param name="separator" select="'.'"/>
                <xsl:with-param name="fallback" select="'UNKNOWN'"/>
              </xsl:call-template>
            </xsl:variable>
            [<xsl:value-of select="translate($extension,$lower,$upper)"/>]
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:if test="$res_type != ''">
        <strong class="ft"><xsl:value-of select="$res_type"/></strong>
        <xsl:text> </xsl:text>
      </xsl:if>

      <xsl:variable name="url_cdata">
        <xsl:choose>
          <xsl:when test="T">
            <xsl:call-template name="reformat_keyword">
              <xsl:with-param name="orig_string" select="T"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="$stripped_url"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$url_indexed">
          <a class="l">
            <xsl:attribute name="href">
              <xsl:choose>
                <!-- *** URI for smb/NFS must be escaped - it appears in the URI query *** -->
                <xsl:when test="$protocol='smb' or $protocol='nfs'">
                  <xsl:value-of disable-output-escaping='yes'
                                select="concat($protocol,'/', substring-after(U,'://'))"/>
                </xsl:when>
                <xsl:when test="starts-with(U, $db_url_protocol)">
                  <xsl:value-of disable-output-escaping='yes'
                                select="concat('db/', substring-after(U,'://'))"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of disable-output-escaping='yes' select="U"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <!-- *** Accesskeys run from 1-9, then 0 for result 10. No more than that. *** -->
            <xsl:if test="$use_accesskeys != '0' and $result_num &lt;= 10">
              <xsl:attribute name="accesskey">
                <xsl:value-of select="$result_num mod $num_results"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="$url_cdata" disable-output-escaping="yes"/>
          </a>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$url_cdata" disable-output-escaping="yes"/></xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </dt>

  <dd>
    <xsl:if test="$level != ''">
      <xsl:attribute name="class"><xsl:value-of select="$level"/></xsl:attribute>
    </xsl:if>

    <!-- *** Snippet Box *** -->
    <xsl:if test="$show_res_snippet != '0'">
      <xsl:call-template name="reformat_keyword">
        <xsl:with-param name="orig_string" select="S"/>
        <xsl:with-param name="type" select="'snippet'"/>
      </xsl:call-template>
    </xsl:if>

    <!-- *** Meta tags *** -->
    <xsl:if test="$show_meta_tags != '0' and count(MT)>0">
      <ul class="mt">
        <xsl:apply-templates select="MT"/>
      </ul>
    </xsl:if>

    <p class="st">

      <!-- *** URL *** -->
      <span class="a">
        <xsl:choose>
          <xsl:when test="not($url_indexed)">
            <xsl:if test="($show_res_size!='0') or ($show_res_date!='0') or ($show_res_cache!='0')">
              <xsl:text>Not Indexed:</xsl:text>
              <xsl:value-of select="$stripped_url"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="$show_res_url != '0'">
              <xsl:value-of select="$stripped_url"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </span>

      <!-- *** Miscellaneous (- size - date - cache) *** -->
      <xsl:if test="$url_indexed">
        <xsl:apply-templates select="HAS/C">
          <xsl:with-param name="stripped_url" select="$stripped_url"/>
          <xsl:with-param name="escaped_url" select="$escaped_url"/>
          <xsl:with-param name="query" select="$query"/>
          <xsl:with-param name="mime" select="@MIME"/>
          <xsl:with-param name="date" select="FS[@NAME='date']/@VALUE"/>
        </xsl:apply-templates>
      </xsl:if>

    </p>

    <!-- *** Link to more links from this site *** -->
    <!-- *** Link to aggregated results from database source *** -->
    <xsl:if test="HN">
      <p class="fm">[ <a class="f" href="search?as_sitesearch={$crowded_url}&amp;{$search_url}">More results from <xsl:value-of select="$crowded_display_url"/></a> ] <xsl:if test="starts-with($crowded_url, $db_url_protocol)">[ <a class="f" href="dbaggr?sitesearch={$crowded_url}&amp;{$search_url}">View all data</a> ]</xsl:if></p>
    </xsl:if>

    <!-- *** Result Footer *** -->
  </dd>
</xsl:template>

<!-- **********************************************************************
  Meta tag values within a result (do not customize)
     ********************************************************************** -->
<xsl:template match="MT">
  <li><span class="f"><xsl:value-of select="@N"/>: </span><xsl:value-of select="@V"/></li>
</xsl:template>

<!-- **********************************************************************
  A single keymatch result (do not customize)
     ********************************************************************** -->
<xsl:template match="GM">
  <li>
    <span class="l"><a href="{GL}"><xsl:value-of select="GD"/></a></span>
    <span> - </span>
    <span class="a">
      <xsl:choose>
        <xsl:when test="$trim_keymatch_link = '0'">
          <xsl:value-of select="GL"/>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:call-template name="replace_string">
            <xsl:with-param name="find" select="'http://'"/>
            <xsl:with-param name="replace" select="''"/>
            <xsl:with-param name="string" select="GL"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </li>
</xsl:template>

<!-- **********************************************************************
  Variables for reformatting keyword-match display (do not customize)
     ********************************************************************** -->
<xsl:variable name="keyword_orig_start" select="'&lt;b&gt;'"/>
<xsl:variable name="keyword_orig_end" select="'&lt;/b&gt;'"/>

<xsl:variable name="keyword_reformat_start">
  <xsl:if test="$res_keyword_format">
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="$res_keyword_format"/>
    <xsl:text>&gt;</xsl:text>
  </xsl:if>
  <xsl:if test="($res_keyword_size) or ($res_keyword_color)">
    <xsl:text>&lt;span style="</xsl:text>
    <xsl:if test="$res_keyword_size">
      <xsl:text>text-size:</xsl:text>
      <xsl:value-of select="$res_keyword_size"/>
      <xsl:text>;</xsl:text>
    </xsl:if>
    <xsl:if test="$res_keyword_color">
      <xsl:text>color:</xsl:text>
      <xsl:value-of select="$res_keyword_color"/>
      <xsl:text>;</xsl:text>
    </xsl:if>
    <xsl:text>"&gt;</xsl:text>
  </xsl:if>
</xsl:variable>

<xsl:variable name="keyword_reformat_end">
  <xsl:if test="($res_keyword_size) or ($res_keyword_color)">
    <xsl:text>&lt;/span&gt;</xsl:text>
  </xsl:if>
  <xsl:if test="$res_keyword_format">
    <xsl:text>&lt;/</xsl:text>
    <xsl:value-of select="$res_keyword_format"/>
    <xsl:text>&gt;</xsl:text>
  </xsl:if>
</xsl:variable>

<!-- **********************************************************************
  Reformat the keyword match display in a title/snippet string
     (do not customize)
     ********************************************************************** -->
<xsl:template name="reformat_keyword">
  <xsl:param name="orig_string"/>
  <xsl:param name="type"/>

  <xsl:variable name="reformatted_1">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="$keyword_orig_start"/>
      <xsl:with-param name="replace" select="$keyword_reformat_start"/>
      <xsl:with-param name="string" select="$orig_string"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="reformatted_2">
    <xsl:call-template name="replace_string">
      <xsl:with-param name="find" select="$keyword_orig_end"/>
      <xsl:with-param name="replace" select="$keyword_reformat_end"/>
      <xsl:with-param name="string" select="$reformatted_1"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- Swap out presentation-related elements with semantic equivalents -->
  <xsl:variable name="reformatted_3">
    <xsl:call-template name="reformat_semantic">
      <xsl:with-param name="markup" select="$reformatted_2"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- Swap out presentation-related br in second half of snippets with a span -->
  <xsl:choose>
    <xsl:when test="$type = 'snippet'">
      <p class="s">
        <xsl:variable name="br_html">&lt;br&gt;</xsl:variable>
        <xsl:choose>
          <!-- Presuming one (and only one) br exists ... -->
          <xsl:when test="contains($reformatted_3, $br_html)">
            <xsl:value-of disable-output-escaping='yes' select="substring-before($reformatted_3, $br_html)"/>
            <span class="s2">
              <xsl:value-of disable-output-escaping='yes' select="substring-after($reformatted_3, $br_html)"/>
            </span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of disable-output-escaping='yes' select="$reformatted_3"/>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of disable-output-escaping='yes' select="$reformatted_3"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
  Helper templates for converting standard-issue HTML elements
     to more semantic variants (do not customize)
     ********************************************************************** -->
<xsl:template name="reformat_semantic">
  <xsl:param name="markup"/>

  <!-- List of elements we'll be replacing (keep space at the end) -->
  <xsl:param name="from" select="'b i '"/>
  <xsl:param name="to" select="'strong em '"/>

  <!-- Get the next pair of search/replace candidates -->
  <xsl:variable name="find" select="substring-before($from, ' ')"/>
  <xsl:variable name="replace" select="substring-before($to, ' ')"/>

  <xsl:choose>
    <xsl:when test="$find">
      <xsl:variable name="markup-new-2">
        <xsl:call-template name="replace_string">
          <xsl:with-param name="find" select="concat('&lt;',$find,'&gt;')"/>
          <xsl:with-param name="replace" select="concat('&lt;',$replace,'&gt;')"/>
          <xsl:with-param name="string" select="$markup"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="markup-new">
        <xsl:call-template name="replace_string">
          <xsl:with-param name="find" select="concat('&lt;/',$find,'&gt;')"/>
          <xsl:with-param name="replace" select="concat('&lt;/',$replace,'&gt;')"/>
          <xsl:with-param name="string" select="$markup-new-2"/>
        </xsl:call-template>
      </xsl:variable>
      <!-- Recursion: It's fun for the whole family! -->
      <xsl:call-template name="reformat_semantic">
        <xsl:with-param name="markup" select="$markup-new"/>
        <xsl:with-param name="from" select="substring-after($from, ' ')"/>
        <xsl:with-param name="to" select="substring-after($to, ' ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$markup"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
  Helper templates for generating a result item (do not customize)
     ********************************************************************** -->

<!-- *** Miscellaneous: - size - date - cache *** -->
<xsl:template match="C">
  <xsl:param name="stripped_url"/>
  <xsl:param name="escaped_url"/>
  <xsl:param name="query"/>
  <xsl:param name="mime"/>
  <xsl:param name="date"/>

  <xsl:variable name="docid"><xsl:value-of select="@CID"/></xsl:variable>

  <xsl:if test="$show_res_size != '0'">
    <xsl:if test="not(@SZ='')">
      <xsl:text> - </xsl:text>
      <xsl:value-of select="@SZ"/>
    </xsl:if>
  </xsl:if>

  <xsl:if test="$show_res_date != '0'">
    <xsl:if test="($date != '') and
                  (translate($date, '-', '') &gt; 19500000) and
                  (translate($date, '-', '') &lt; 21000000)">
      <xsl:text> - </xsl:text>
      <xsl:value-of select="$date"/>
    </xsl:if>
  </xsl:if>

  <xsl:if test="$show_res_cache != '0'">
    <span class="rc">
      <xsl:text> - </xsl:text>
      <xsl:variable name="cache_encoding">
        <xsl:choose>
          <xsl:when test="'' != @ENC"><xsl:value-of select="@ENC"/></xsl:when>
          <xsl:otherwise>UTF-8</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <a class="f" href="search?q=cache:{$docid}:{$escaped_url}+{
                         $stripped_search_query}&amp;{$base_url}&amp;oe={
                         $cache_encoding}">
        <xsl:choose>
          <xsl:when test="not($mime)">Cached</xsl:when>
          <xsl:when test="$mime='text/html'">Cached</xsl:when>
          <xsl:when test="$mime='text/plain'">Cached</xsl:when>
          <xsl:otherwise>Text Version</xsl:otherwise>
        </xsl:choose>
      </a>
    </span>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Google navigation directional endpoints: first/prev/next/last (do not customize)
     ********************************************************************** -->
<xsl:template name="nav_dir">
  <xsl:param name="style"/>
  <xsl:param name="type"/>
  <xsl:param name="nav"/>
  <xsl:param name="view_begin"/>

  <xsl:variable name="fontclass">
    <xsl:if test="$style != 'top'"><xsl:text> </xsl:text>b</xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$type = 'prev'">
      <xsl:choose>
        <xsl:when test="$nav">
          <span class="pp{$fontclass}"><a href="search?{$search_url}&amp;start={$view_begin - $num_results - 1}" title="Go to previous page">Previous</a></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$style != 'top'">
            <span class="fp" title="First Page"><strong><xsl:call-template name="nbsp"/></strong></span>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$nav">
          <span class="np{$fontclass}"><a href="search?{$search_url}&amp;start={$view_begin + $num_results - 1}" title="Go to next page">Next</a></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$style != 'top'">
            <span class="lp" title="Last Page"><strong><xsl:call-template name="nbsp"/></strong></span>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 Google navigation bar in result page (do not customize)
     ********************************************************************** -->
<xsl:template name="google_navigation">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="view_begin"/>
  <xsl:param name="view_end"/>
  <xsl:param name="guess"/>
  <xsl:param name="navigation_style"/>

  <!-- *** Should we even show navigation? *** -->
  <xsl:if test="$prev or $next">

  <xsl:if test="$navigation_style = 'top'">
    <p id="nt">
      <!-- *** Get previous navigation, if available *** -->
      <xsl:call-template name="nav_dir">
        <xsl:with-param name="style" select="$navigation_style"/>
        <xsl:with-param name="type" select="'prev'"/>
        <xsl:with-param name="nav" select="$prev"/>
        <xsl:with-param name="view_begin" select="$view_begin"/>
      </xsl:call-template>

      <xsl:if test="$prev and $next">
        <span class="sp">,</span><xsl:text> </xsl:text>
      </xsl:if>

      <!-- *** Get next navigation, if available *** -->
      <xsl:call-template name="nav_dir">
        <xsl:with-param name="style" select="$navigation_style"/>
        <xsl:with-param name="type" select="'next'"/>
        <xsl:with-param name="nav" select="$next"/>
        <xsl:with-param name="view_begin" select="$view_begin"/>
      </xsl:call-template>

      <span class="sp">.</span>
    </p>
  </xsl:if>

  <xsl:if test="$navigation_style != 'top'">
    <div id="n"><div>
      <xsl:attribute name="class">
        <xsl:text>co</xsl:text>
        <xsl:if test="$navigation_style = 'google'"> go</xsl:if>
        <xsl:if test="$navigation_style != 'google'"> ln</xsl:if>
      </xsl:attribute>

      <h3>Result Page</h3>
      <p>
        <!-- *** Show previous navigation, if available *** -->
        <xsl:call-template name="nav_dir">
          <xsl:with-param name="style" select="$navigation_style"/>
          <xsl:with-param name="type" select="'prev'"/>
          <xsl:with-param name="nav" select="$prev"/>
          <xsl:with-param name="view_begin" select="$view_begin"/>
        </xsl:call-template>
        <xsl:if test="$prev">
          <span class="sp">,</span><xsl:text> </xsl:text>
        </xsl:if>

        <xsl:if test="($navigation_style = 'google') or ($navigation_style = 'link')">
          <!-- *** Google result set navigation *** -->
          <xsl:variable name="mod_end">
            <xsl:choose>
              <xsl:when test="$next"><xsl:value-of select="$guess"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="$view_end"/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <xsl:call-template name="result_nav">
            <xsl:with-param name="start" select="0"/>
            <xsl:with-param name="end" select="$mod_end"/>
            <xsl:with-param name="current_view" select="($view_begin)-1"/>
            <xsl:with-param name="navigation_style" select="$navigation_style"/>
          </xsl:call-template>
        </xsl:if>

        <!-- *** Show next navigation, if available *** -->
        <xsl:call-template name="nav_dir">
          <xsl:with-param name="style" select="$navigation_style"/>
          <xsl:with-param name="type" select="'next'"/>
          <xsl:with-param name="nav" select="$next"/>
          <xsl:with-param name="view_begin" select="$view_begin"/>
        </xsl:call-template><span class="sp">.</span>
      </p>
    </div></div>
  </xsl:if>

  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Helper templates for generating Google result navigation (do not customize)
   only shows 10 sets up or down from current view
     ********************************************************************** -->
<xsl:template name="result_nav">
  <xsl:param name="start" select="'0'"/>
  <xsl:param name="end"/>
  <xsl:param name="current_view"/>
  <xsl:param name="navigation_style"/>

  <!-- *** Choose how to show this result set *** -->
  <xsl:choose>
    <xsl:when test="($start)&lt;(($current_view)-(10*($num_results)))">
    </xsl:when>
    <xsl:when test="(($current_view)&gt;=($start)) and
                    (($current_view)&lt;(($start)+($num_results)))">
      <span class="cp" title="Current page"><strong><xsl:value-of select="(($start)div($num_results))+1"/></strong></span><span class="sp">,</span>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="page_num">
        <xsl:value-of select="(($start)div($num_results))+1"/>
      </xsl:variable>
      <span><a href="search?{$search_url}&amp;start={$start}" title="Go to page {$page_num}"><xsl:value-of select="$page_num"/></a></span><span class="sp">,</span>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text> </xsl:text>

  <!-- *** Recursively iterate through result sets to display *** -->
  <xsl:if test="((($start)+($num_results))&lt;($end)) and
                ((($start)+($num_results))&lt;(($current_view)+
                (10*($num_results))))">
    <xsl:call-template name="result_nav">
      <xsl:with-param name="start" select="$start+$num_results"/>
      <xsl:with-param name="end" select="$end"/>
      <xsl:with-param name="current_view" select="$current_view"/>
      <xsl:with-param name="navigation_style" select="$navigation_style"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template>

<!-- **********************************************************************
 Top separation bar (do not customize)
     ********************************************************************** -->
<xsl:template name="top_sep_bar">
  <xsl:param name="text"/>
  <xsl:param name="show_info"/>
  <xsl:param name="time"/>

  <div id="su">
    <xsl:if test="$media != 'handheld' or count(/GSP/RES/R)>0">
      <h2><xsl:value-of select="$text"/></h2>
    </xsl:if>
    <xsl:if test="$show_info != '0'">
      <p>
        <xsl:if test="count(/GSP/RES/R)>0">
          <xsl:if test="$media = 'handheld'">'<xsl:value-of select="$space_normalized_query"/>'<br /></xsl:if>
          <xsl:choose>
            <xsl:when test="$access = 's' or $access = 'a'">Results <strong><xsl:value-of select="RES/@SN"/></strong> - <strong><xsl:value-of select="RES/@EN"/></strong><xsl:if test="$media != 'handheld'"> for <strong><xsl:value-of select="$space_normalized_query"/></strong></xsl:if>.</xsl:when>
            <xsl:otherwise>Results <strong><xsl:value-of select="RES/@SN"/></strong> - <strong><xsl:value-of select="RES/@EN"/></strong> of about <strong><xsl:value-of select="RES/M"/></strong><xsl:if test="$media != 'handheld'"> for <strong><xsl:value-of select="$space_normalized_query"/></strong></xsl:if>.</xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="$media != 'handheld'">
          <xsl:text> </xsl:text>
          <span class="st">Search took <strong><xsl:value-of select="round($time * 100.0) div 100.0"/></strong> seconds.</span>
        </xsl:if>
      </p>
    </xsl:if>
  </div>

  <xsl:if test="$choose_sep_bar = 'line'"><hr/></xsl:if>
</xsl:template>

<!-- **********************************************************************
 Utility function for constructing copyright text (do not customize)
     ********************************************************************** -->
<xsl:template name="copyright">
  <p id="co">Powered by Google Search Appliance</p>
</xsl:template>

<!-- **********************************************************************
 Utility functions for generating html entities
     ********************************************************************** -->
<xsl:template name="nbsp">
  <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
</xsl:template>
<xsl:template name="nbsp3">
  <xsl:call-template name="nbsp"/>
  <xsl:call-template name="nbsp"/>
  <xsl:call-template name="nbsp"/>
</xsl:template>
<xsl:template name="nbsp4">
  <xsl:call-template name="nbsp3"/>
  <xsl:call-template name="nbsp"/>
</xsl:template>
<xsl:template name="quot">
  <xsl:text disable-output-escaping="yes">&amp;quot;</xsl:text>
</xsl:template>
<xsl:template name="copy">
  <xsl:text disable-output-escaping="yes">&amp;copy;</xsl:text>
</xsl:template>
<xsl:variable name="apos">'</xsl:variable>

<!-- **********************************************************************
 Hidden field helper template (do not customize)
     ********************************************************************** -->
<xsl:template name="hidden_field">
  <xsl:param name="name"/>
  <xsl:variable name="n" select="substring-before($name, ',')"/>
  <xsl:if test="$name">
    <xsl:if test="PARAM[@name=$n]">
      <input type="hidden" name="{$n}" value="{PARAM[@name=$n]/@value}" />
    </xsl:if>
    <xsl:call-template name="hidden_field">
      <xsl:with-param name="name" select="substring-after($name, ',')"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<!-- **********************************************************************
 Select option helper template (do not customize)
     ********************************************************************** -->
<xsl:template name="select_option">
  <xsl:param name="name"/>
  <xsl:param name="value"/>
  <xsl:param name="desc"/>
  <xsl:variable name="v" select="substring-before($value, ',')"/>
  <xsl:variable name="d" select="substring-before($desc, ',')"/>
  <xsl:choose>
    <xsl:when test="$value">
      <option value="{$v}">
        <xsl:if test="PARAM[(@name=$name) and (@value=$v)]">
          <xsl:attribute name="selected">selected</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="$d"/>
      </option>
      <xsl:call-template name="select_option">
        <xsl:with-param name="name" select="$name"/>
        <xsl:with-param name="value" select="substring-after($value, ',')"/>
        <xsl:with-param name="desc" select="substring-after($desc, ',')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 Content-type helper template (do not customize)
     ********************************************************************** -->
<xsl:template name="content_type">
  <xsl:param name="name"/>
  <xsl:param name="value"/>
  <xsl:param name="charset"/>
  <xsl:param name="default" select="''"/>
  <xsl:variable name="v" select="substring-before($value, ',')"/>
  <xsl:variable name="c" select="substring-before($charset, ',')"/>
  <xsl:choose>
    <xsl:when test="$value">
      <xsl:choose>
        <xsl:when test="PARAM[(@name=$name) and (@value=$v)]">
          <meta http-equiv="content-type" content="application/xhtml+xml; charset={$c}"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="content_type">
            <xsl:with-param name="name" select="$name"/>
            <xsl:with-param name="value" select="substring-after($value, ',')"/>
            <xsl:with-param name="charset" select="substring-after($charset, ',')"/>
            <xsl:with-param name="default" select="$default"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <meta http-equiv="content-type" content="application/xhtml+xml; charset={$default}"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 Utility functions for generating head elements with a meta tag to the output
 specifying the character set as requested
     ********************************************************************** -->
<xsl:template name="head_elements">
  <xsl:if test="$show_favicon != '0'">
    <link rel="shortcut icon" href="{$favicon}" />
  </xsl:if>
  <meta name="robots" content="noindex,nofollow"/>
  <xsl:choose>
    <xsl:when test="PARAM[(@name='oe') and (@value!='')]">
      <xsl:call-template name="content_type">
        <xsl:with-param name="name" select="'oe'"/>
        <xsl:with-param name="value" select="'utf8,'"/>
        <xsl:with-param name="charset" select="'UTF-8,'"/>
        <xsl:with-param name="default" select="PARAM[@name='oe']/@value"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="content_type">
        <xsl:with-param name="name" select="'lr'"/>
        <xsl:with-param name="value" select="'lang_zh-CN,lang_zh-TW,lang_cs,lang_da,lang_nl,lang_en,lang_et,lang_fi,lang_fr,lang_de,lang_el,lang_iw,lang_hu,lang_is,lang_it,lang_ja,lang_ko,lang_lv,lang_lt,lang_no,lang_pl,lang_pt,lang_ro,lang_ru,lang_es,lang_sv,'"/>
        <xsl:with-param name="charset" select="'GB2312,Big5,ISO-8859-2,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-7,ISO-8859-8-I,ISO-8859-2,ISO-8859-1,ISO-8859-1,Shift_JIS,EUC-KR,ISO-8859-1,ISO-8859-1,ISO-8859-1,ISO-8859-2,ISO-8859-1,ISO-8859-2,windows-1251,ISO-8859-1,ISO-8859-1,'"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 Utility functions (do not customize)
     ********************************************************************** -->

<!-- *** Find the substring after the last occurence of a separator *** -->
<xsl:template name="last_substring_after">
  <xsl:param name="string"/>
  <xsl:param name="separator"/>
  <xsl:param name="fallback"/>
  <xsl:variable name="newString" select="substring-after($string, $separator)"/>
  <xsl:choose>
    <xsl:when test="$newString!=''">
      <xsl:call-template name="last_substring_after">
        <xsl:with-param name="string" select="$newString"/>
        <xsl:with-param name="separator" select="$separator"/>
        <xsl:with-param name="fallback" select="$newString"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$fallback"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- *** Find and replace *** -->
<xsl:template name="replace_string">
  <xsl:param name="find"/>
  <xsl:param name="replace"/>
  <xsl:param name="string"/>
  <xsl:choose>
    <xsl:when test="contains($string, $find)">
      <xsl:value-of select="substring-before($string, $find)"/>
      <xsl:value-of select="$replace"/>
      <xsl:call-template name="replace_string">
        <xsl:with-param name="find" select="$find"/>
        <xsl:with-param name="replace" select="$replace"/>
        <xsl:with-param name="string" select="substring-after($string, $find)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- *** URI Encode *** -->
<xsl:template name="uriencode">
  <xsl:param name="text"/>

  <xsl:param name="from" select="'% $ &amp; + , / : ; = ? @ '"/>
  <xsl:param name="to" select="'25 24 26 2B 2C 2F 3A 3B 3D 3F 40 '"/>
  <xsl:variable name="find" select="substring-before($from, ' ')"/>
  <xsl:variable name="replace" select="substring-before($to, ' ')"/>

  <xsl:choose>
    <xsl:when test="$find">
      <xsl:variable name="replaced">
        <xsl:call-template name="replace_string">
          <xsl:with-param name="find" select="$find"/>
          <xsl:with-param name="replace" select="concat('%', $replace)"/>
          <xsl:with-param name="string" select="$text"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="uriencode">
        <xsl:with-param name="text" select="$replaced"/>
        <xsl:with-param name="from" select="substring-after($from, ' ')"/>
        <xsl:with-param name="to" select="substring-after($to, ' ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="translate($text, ' ', '+')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- **********************************************************************
 Display error messages
     ********************************************************************** -->
<xsl:template name="error_page">
  <xsl:param name="errorMessage"/>
  <xsl:param name="errorDescription"/>

  <head><meta name="robots" content="noindex,nofollow"/><title><xsl:value-of select="$error_page_title"/></title>
  <xsl:call-template name="style">
    <xsl:with-param name="mode" select="'error'"/>
  </xsl:call-template>
  </head><body>
  <xsl:call-template name="my_page_header"/>

  <xsl:if test="$show_logo != '0'">
    <xsl:call-template name="logo"/>
  </xsl:if>

  <xsl:call-template name="top_sep_bar">
    <xsl:with-param name="text" select="$sep_bar_error_text"/>
    <xsl:with-param name="show_info" select="0"/>
    <xsl:with-param name="time" select="0"/>
  </xsl:call-template>

  <dl>
    <dt>Message:</dt>
    <dd><xsl:value-of select="$errorMessage"/></dd>
    <dt>Description:</dt>
    <dd><xsl:value-of select="$errorDescription"/></dd>
    <dt>Details:</dt>
    <dd><xsl:copy-of select="/"/></dd>
  </dl>

  <hr/>
  <xsl:call-template name="copyright"/>
  <xsl:call-template name="my_page_footer"/>
  </body>

</xsl:template>

<!-- **********************************************************************
 Google Desktop for Enterprise integration templates
     ********************************************************************** -->
<xsl:template name="desktop_tab">
  <xsl:variable name="qs">
    <xsl:if test="$qval_uri != ''">
      <xsl:value-of select="concat('?q=',$qval_uri)"/>
    </xsl:if>
  </xsl:variable>

  <!-- *** Show the Google tabs *** -->
  <p id="nd">
    <a onclick="return window.qs?qs(this):1" href="http://www.google.com/search{$qs}" title="Search the Web">Web</a><span>,</span><xsl:text> </xsl:text>
    <a onclick="return window.qs?qs(this):1" href="http://images.google.com/images{$qs}" title="Search Images">Images</a><span>,</span><xsl:text> </xsl:text>
    <a onclick="return window.qs?qs(this):1" href="http://groups.google.com/groups{$qs}" title="Search Groups">Groups</a><span>,</span><xsl:text> </xsl:text>
    <a onclick="return window.qs?qs(this):1" href="http://news.google.com/news{$qs}" title="Search News">News</a><span>,</span><xsl:text> </xsl:text>
    <a onclick="return window.qs?qs(this):1" href="http://froogle.google.com/froogle{$qs}" title="Search Froogle">Froogle</a><span>,</span><xsl:text> </xsl:text>
    <a onclick="return window.qs?qs(this):1" href="http://local.google.com/local{$qs}" title="Search Local">Local</a><span>,</span><xsl:text> </xsl:text>

    <!-- *** Show the desktop and web tabs *** -->
    <!-- *** NOTE: Currently unsupported *** -->
    <!--
    <xsl:if test="CUSTOM/HOME">
      <xsl:comment>trh2</xsl:comment>
    </xsl:if>
    <xsl:if test="Q">
      <xsl:comment>trl2</xsl:comment>
    </xsl:if>
    -->

    <!-- *** Show the appliance tab *** -->
    <strong><xsl:value-of select="$egds_appliance_tab_label"/></strong><span>.</span>
  </p>
</xsl:template>

<xsl:template name="desktop_results">
  <!-- *** NOTE: Currently unsupported *** -->
  <!-- <xsl:comment>tro2</xsl:comment> -->
</xsl:template>

<!-- **********************************************************************
  OneBox results (if any)
     ********************************************************************** -->
<xsl:template name="onebox">
  <xsl:for-each select="/GSP/ENTOBRESULTS">
    <xsl:apply-templates/>
  </xsl:for-each>
</xsl:template>

<!-- **********************************************************************
 Swallow unmatched elements
     ********************************************************************** -->
<xsl:template match="@*|node()"/>
</xsl:stylesheet>

<!-- *** END OF STYLESHEET *** -->