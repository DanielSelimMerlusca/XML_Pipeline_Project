<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Output settings for HTML -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Template matching the root element -->
  <xsl:template match="/CarePlatform">
    <html>
      <head>
        <title>Services List</title>
        <link rel="stylesheet" type="text/css" href="style2.css"/>
      </head>
      <body>
        <h1>Services List</h1>

        <!-- Create a table for services -->
        <table border="1">
          <tr>
            <th>Service ID</th>
            <th>Type</th>
            <th>Description</th>
            <th>Provider</th>
            <th>Days</th>
            <th>Time</th>
            <th>Location</th>
            <th>Staff</th>
          </tr>

          <!-- Loop through each Service -->
          <xsl:for-each select="Services/Service">
            <tr>
              <td><xsl:value-of select="ID"/></td>
              <td><xsl:value-of select="Type"/></td>
              <td><xsl:value-of select="Description"/></td>

              <!-- Provider name lookup using ProviderID -->
              <td>
                <xsl:value-of select="/CarePlatform/ServiceProviders/Provider[ProviderID=current()/ProviderID]/Name"/>
              </td>

              <!-- List service days -->
              <td>
                <xsl:for-each select="Schedule/Days/Day">
                  <xsl:value-of select="."/>
                  <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
              </td>

              <!-- Display Time -->
              <td><xsl:value-of select="Schedule/Time"/></td>

              <!-- Display location (street and room) -->
              <td>
                <xsl:value-of select="Location/Address/Street"/> 
                (<xsl:value-of select="Location/Room"/>)
              </td>

              <!-- List staff names and roles -->
              <td>
                <xsl:for-each select="Staff/Instructor">
                  <xsl:value-of select="Name"/> - 
                  <xsl:value-of select="Role"/>
                  <br/>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
