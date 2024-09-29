<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:template match="/">
    <rss version="2.0">
      <channel>
        <title><xsl:value-of select="RSSFeed/channel/title"/></title>
        <link><xsl:value-of select="RSSFeed/channel/link"/></link>
        <description><xsl:value-of select="RSSFeed/channel/description"/></description>
        <language><xsl:value-of select="RSSFeed/channel/language"/></language>

        <!-- Loop through each event (item) in the RSS feed -->
        <xsl:for-each select="RSSFeed/channel/item">
          <item>
            <title><xsl:value-of select="title"/></title>
            <description><xsl:value-of select="description"/></description>
            <link><xsl:value-of select="link"/></link>
            <pubDate><xsl:value-of select="pubDate"/></pubDate>
            <guid><xsl:value-of select="link"/></guid>

            <!-- Optional fields for additional information -->
            <xsl:if test="location">
              <location><xsl:value-of select="location"/></location>
            </xsl:if>
            <xsl:if test="provider">
              <provider><xsl:value-of select="provider"/></provider>
            </xsl:if>
          </item>
          <xsl:text>&#10;&#10;</xsl:text> <!-- Add spacing between each item -->
        </xsl:for-each>
      </channel>
    </rss>
  </xsl:template>
</xsl:stylesheet>
