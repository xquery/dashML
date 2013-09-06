<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    xmlns:js="http://saxonica.com/ns/globalJS"
    xmlns:prop="http://saxonica.com/ns/html-property"
    xmlns:style="http://saxonica.com/ns/html-style-property"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:wc="http://www.webcomposite.com/xslt"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:meter="http://marklogic.com/manage/meters"
    exclude-result-prefixes="xs prop"
    extension-element-prefixes="ixsl"
    version="2.0">

  <xsl:template match="/"></xsl:template>

  <xsl:template match="button[@id eq 'save-dash']" mode="ixsl:onclick">
  </xsl:template>

  <xsl:template match="button[@id eq 'add-widget']" mode="ixsl:onclick">
      <xsl:result-document href="#state" method="ixsl:replace-content">
        <dash>
        <xsl:copy-of select="//div[@id eq 'state']/*"/>
        <widget>active</widget>
        </dash>
      </xsl:result-document>
  </xsl:template>

  <xsl:template match="button[@id eq 'new-dash']" mode="ixsl:onclick">
      <xsl:result-document href="#state" method="ixsl:replace-content">
        
        <widget>
        <xsl:copy-of select="ixsl:page()//input/@value/data(.)"/>
        </widget>
      </xsl:result-document>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:transform>

