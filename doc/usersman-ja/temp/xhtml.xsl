<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:date="http://exslt.org/dates-and-times"
		exclude-result-prefixes="date"
		version="1.0">


<xsl:import href="/usr/share/sgml/docbook/xsl-stylesheets-1.78.1/xhtml/chunk.xsl" />
<xsl:include href="xhtml-titlepage.xsl"/>

<xsl:param name="use.extensions" select="'1'"/>

<!-- body attributes -->
<!-- clear default body attributes. it may be defined by css -->
<xsl:template name="body.attributes"></xsl:template>

<!-- Page header -->
<xsl:template name="chunk-element-content">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="nav.context"/>
  <xsl:param name="content">
    <xsl:apply-imports/>
  </xsl:param>

  <xsl:call-template name="user.preroot"/>

  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>

    <body>
      <div id="page">
      <xsl:call-template name="body.attributes"/>
      <xsl:call-template name="user.header.navigation"/>

      <xsl:call-template name="header.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.header.content"/>

      <xsl:copy-of select="$content"/>

      <xsl:call-template name="user.footer.content"/>

      <xsl:call-template name="footer.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.footer.navigation"/>
      </div>
    </body>
  </html>
</xsl:template>

<xsl:param name="navig.showtitles" select="0"/>
<xsl:param name="header.rule" select="1"/>

<!-- Page footer -->
<xsl:template name="user.footer.navigation">
  <div class="lastupdated">
    <xsl:text>Last updated: </xsl:text>
    <xsl:call-template name="datetime.format">
      <xsl:with-param name="date" select="date:date-time()"/>
      <xsl:with-param name="format" select="'Y/m/d'"/>
    </xsl:call-template>
  </div>
</xsl:template>

<!-- Text -->
<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n language="ja" english-language-name="Japanese">
    <l:gentext key="Copyright" text="Copyright" lang="en"/>
    <l:gentext key="copyright" text="Copyright" lang="en"/>
  </l:l10n>
</l:i18n>

<!-- StyleSheet -->
<xsl:param name="html.stylesheet" select="'style.css'"/>

<xsl:param name="saxon.character.representation" select="'native'"/>
<xsl:param name="root.filename" select="'index'"/>

<!-- HTML -->
<xsl:param name="use.id.as.filename" select="1"/>
<xsl:param name="generate.id.attributes" select="1"/>

<!-- <xsl:param name="suppress.navigation" select="1"/> -->
<xsl:param name="navig.graphics" select="1"/>
<xsl:param name="navig.graphics.path" select="'images/etc/'"/>
<xsl:param name="navig.graphics.extension" select="'.gif'"/>

<!-- Toc -->
<xsl:param name="generate.section.toc.level" select="3"/>
<xsl:param name="toc.max.depth">3</xsl:param>
<xsl:param name="toc.section.depth" select="3"/>
<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="generate.toc">
book      toc,title
chapter   title
section   title
</xsl:param>

<!-- Miscellaneous -->
<xsl:param name="chunk.separate.lots" select="0"/>

<!-- Abstract -->
<xsl:param name="abstract.notitle.enabled" select="1"/>

<!-- Edition -->
<xsl:template match="edition" mode="titlepage.mode">
  <p class="{name(.)}">
    <xsl:text>RELEASE</xsl:text>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates mode="titlepage.mode"/>
  </p>
</xsl:template>


<!-- Year -->
<xsl:param name="make.year.ranges" select="1"/>
<xsl:param name="make.single.year.ranges" select="1"/>

<!-- Encode -->
<xsl:param name="default.encoding" select="'UTF-8'"/>

<!-- Tables -->
<xsl:param name="table.borders.with.css" select="1"/>
<xsl:param name="tablecolumns.extension" select="'0'"/>
<xsl:param name="table.cell.border.style" select="'solid'"/>
<xsl:param name="table.cell.border.thickness" select="'0.5pt'"/>
<xsl:param name="table.cell.border.color" select="'black'"/>
<xsl:param name="html.cellspacing" select="0"/>
<xsl:param name="html.cellpadding" select="5"/>

<!-- Chunking -->
<xsl:param name="chunker.output.encoding" select="'UTF-8'"/>
<xsl:param name="chunker.output.indent" select="'yes'"/>
<xsl:param name="chunk.first.sections" select="1"/>
<xsl:param name="chunk.section.depth" select="0"/>

<!-- Localization -->
<xsl:param name="l10n.gentext.language" select="'ja'"/>
<xsl:param name="l10n.gentext.default.language" select="'ja'"/>

<!-- TeX -->
<xsl:param name="tex.math.in.alt" select="'latex'"/>

</xsl:stylesheet>
