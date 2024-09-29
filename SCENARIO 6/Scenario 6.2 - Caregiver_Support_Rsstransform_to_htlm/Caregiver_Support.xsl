<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Caregiver Support Events and Resources</title>
        <!-- Link to external CSS file -->
        <link rel="stylesheet" type="text/css" href="style3.css"/>
      </head>
      <body>
        <div class="container">
          <h1>Caregiver Support Events and Resources</h1>

          <!-- Encouraging message for caregivers -->
          <p class="encouraging-message">
            Thank you, caregivers, for the invaluable work you do every day. Your compassion and dedication make a world of difference in the lives of those in need. We honor and support you in every step of your journey.
          </p>

          <!-- Social Media Section -->
          <div class="social-media">
            <h2>Connect with other caregivers</h2>
            <!-- Facebook -->
            <a href="https://www.facebook.com/YourPage" target="_blank">
              <img src="face.png" alt="Facebook" />
            </a>
            <!-- Instagram -->
            <a href="https://www.instagram.com/YourPage" target="_blank">
              <img src="insta.png" alt="Instagram" />
            </a>
            <!-- Community -->
            <a href="https://www.yourwebsite.com/community" target="_blank">
              <img src="com.png" alt="Community" />
            </a>
          </div>

          <!-- Loop through each event in the RSS feed -->
          <xsl:for-each select="CarePlatform/RSSFeed/channel/item">
            <div class="event">
              <!-- Display corresponding image for each event -->
              <xsl:choose>
                <xsl:when test="position() = 1">
                  <img src="image1.jpg" alt="Event Image 1"/>
                </xsl:when>
                <xsl:when test="position() = 2">
                  <img src="image2.jpg" alt="Event Image 2"/>
                </xsl:when>
                <xsl:when test="position() = 3">
                  <img src="image3.jpg" alt="Event Image 3"/>
                </xsl:when>
                <xsl:when test="position() = 4">
                  <img src="image4.jpg" alt="Event Image 4"/>
                </xsl:when>
                <xsl:when test="position() = 5">
                  <img src="image5.jpg" alt="Event Image 5"/>
                </xsl:when>
                <xsl:otherwise>
                  <img src="default_event.jpg" alt="Default Event Image"/>
                </xsl:otherwise>
              </xsl:choose>

              <!-- Event Title -->
              <h2 class="event-title">
                <xsl:value-of select="title"/>
              </h2>

              <!-- Event Description -->
              <p class="event-description">
                <xsl:value-of select="description"/>
              </p>

              <!-- Event Details -->
              <p class="event-details">
                <strong>Date:</strong> <xsl:value-of select="pubDate"/><br/>
                <strong>Location:</strong> <xsl:value-of select="location"/><br/>
                <strong>Provider:</strong> <xsl:value-of select="provider"/><br/>
              </p>

              <!-- Read More Link -->
              <a class="read-more" href="{link}">Read more</a>
            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
