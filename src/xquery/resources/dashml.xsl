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

    <xsl:template match="meter:*" name="main">   
        <xsl:call-template name="xquery-view"/>
    </xsl:template>

    <xsl:template name="xquery-view">
      <xsl:result-document href="#meters" method="ixsl:replace-content">
          <a href="http://localhost:8002/manage/v2/forests?view=metrics&amp;forest-metrics={name(.)}" target="_new"><xsl:value-of select="name(.)"/></a>
          <xsl:apply-templates select="meter:summary"/>
      </xsl:result-document>    
    </xsl:template>

    <xsl:template match="meter:summary">
      <table border="1">
      <xsl:for-each select="meter:data/meter:entry">
      <tr>
        <td><xsl:value-of select="meter:dt"/></td>
        <td><xsl:value-of select="meter:value"/></td>
      </tr>
     </xsl:for-each>
      </table>

    </xsl:template> 
    
</xsl:transform>	

