<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" doctype-public="XSLT-compat" encoding="UTF-8"/>
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="style2.css"/>
        <title>Service Providers List</title>
      </head>
      <body>
        <h1>Service Providers List</h1>
        <table>
          <tr>
            <th>Provider Name</th>
            <th>Type of Service</th>
            <th>Contact Info</th>
            <th>Address</th>
            <th>More Info</th>
          </tr>
          <xsl:for-each select="CarePlatform/ServiceProviders/Provider">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="TypeOfService"/></td>
              <td>
                <a href="tel:{Contact/Phone}" class="phone">
                  <img src="phone.png" alt="Phone" class="icon"/> 
                  <xsl:value-of select="Contact/Phone"/>
                </a><br/>
                <a href="mailto:{Contact/Email}" class="email">
                  <img src="envelope.png" alt="Email" class="icon"/> 
                  <xsl:value-of select="Contact/Email"/>
                </a>
              </td>
              <td>
                <xsl:value-of select="Address/Street"/><br/>
                <xsl:value-of select="Address/City"/>, 
                <xsl:value-of select="Address/State"/>, 
                <xsl:value-of select="Address/ZipCode"/>, 
                <xsl:value-of select="Address/Country"/>
              </td>
              <td>
                <button onclick="window.open('https://www.example.com/moreinfo/{ProviderID}')">More Information</button>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
