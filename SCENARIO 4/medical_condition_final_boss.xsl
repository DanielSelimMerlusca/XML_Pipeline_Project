<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <!-- Template matching the root element -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Health Risk Report and Medical Condition Summary</title>
        <style>
          table { border-collapse: collapse; width: 100%; }
          table, th, td { border: 1px solid black; padding: 8px; }
          th { background-color: #f2f2f2; }
          .very-high-risk { font-weight: bold; color: red; }
          .high-risk { font-weight: bold; color: orange; }
          .medium-risk { font-weight: bold; color: blue; }
        </style>
      </head>
      <body>
        <h1>Health Risk Report</h1>

        <!-- Total Count of People -->
        <xsl:variable name="totalCount" select="count(//Person)"/>

        <!-- Very High Risk -->
        <h2 class="very-high-risk">Very High Risk</h2>
        <table>
          <tr>
            <th>Person Name</th>
            <th>Age</th>
            <th>Medical Condition</th>
          </tr>
          <xsl:for-each select="//Person[Age &gt;= 70 and (MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension')]">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="Age"/></td>
              <td><xsl:value-of select="MedicalConditions"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- High Risk -->
        <h2 class="high-risk">High Risk</h2>
        <table>
          <tr>
            <th>Person Name</th>
            <th>Age</th>
            <th>Medical Condition</th>
          </tr>
          <!-- People under 70 with serious conditions -->
          <xsl:for-each select="//Person[Age &lt; 70 and (MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension')]">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="Age"/></td>
              <td><xsl:value-of select="MedicalConditions"/></td>
            </tr>
          </xsl:for-each>
          <!-- People over 70 with Osteoporosis or Arthritis -->
          <xsl:for-each select="//Person[Age &gt;= 70 and (MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis')]">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="Age"/></td>
              <td><xsl:value-of select="MedicalConditions"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Medium Risk -->
        <h2 class="medium-risk">Medium Risk</h2>
        <table>
          <tr>
            <th>Person Name</th>
            <th>Age</th>
            <th>Medical Condition</th>
          </tr>
          <!-- People under 70 with Osteoporosis or Arthritis -->
          <xsl:for-each select="//Person[Age &lt; 70 and (MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis')]">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="Age"/></td>
              <td><xsl:value-of select="MedicalConditions"/></td>
            </tr>
          </xsl:for-each>
          <!-- People with other conditions not mentioned previously -->
          <xsl:for-each select="//Person[not(MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension' or MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis')]">
            <tr>
              <td><xsl:value-of select="Name"/></td>
              <td><xsl:value-of select="Age"/></td>
              <td><xsl:value-of select="MedicalConditions"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <hr/>

        <!-- Risk Percentage Calculation -->
        <h2>Risk Category Percentages</h2>
        <p><strong>Total Number of People:</strong> <xsl:value-of select="$totalCount"/></p>

        <p><strong>Very High Risk Percentage:</strong> 
          <xsl:variable name="veryHighCount" select="count(//Person[Age &gt;= 70 and (MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension')])"/>
          <xsl:value-of select="format-number(($veryHighCount div $totalCount) * 100, '0.00')"/>
        %</p>

        <p><strong>High Risk Percentage:</strong> 
          <xsl:variable name="highRiskCount" select="count(//Person[Age &lt; 70 and (MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension') or (Age &gt;= 70 and (MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis'))])"/>
          <xsl:value-of select="format-number(($highRiskCount div $totalCount) * 100, '0.00')"/>
        %</p>

        <p><strong>Medium Risk Percentage:</strong> 
          <xsl:variable name="mediumRiskCount" select="count(//Person[Age &lt; 70 and (MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis') or not(MedicalConditions = 'Heart Disease' or MedicalConditions = 'Diabetes' or MedicalConditions = 'Asthma' or MedicalConditions = 'Hypertension' or MedicalConditions = 'Osteoporosis' or MedicalConditions = 'Arthritis')])"/>
          <xsl:value-of select="format-number(($mediumRiskCount div $totalCount) * 100, '0.00')"/>
        %</p>

        <hr/>

        <!-- Medical Condition Summary Section -->
        <h1>Medical Condition Summary</h1>
        
        <!-- List distinct medical conditions -->
        <xsl:for-each select="//Person[generate-id() = generate-id(key('condition', MedicalConditions)[1])]">
          <div class="condition-group">
            <h2><xsl:value-of select="MedicalConditions"/></h2>
            <p><strong>Number of people with this condition:</strong> 
              <xsl:value-of select="count(key('condition', MedicalConditions))"/>
            </p>

            <!-- Table of services for people with this medical condition -->
            <h3>People with condition</h3>
            <table>
              <tr>
                <th>Person Name</th>
                <th>Age</th>
                <th>Disability</th>
              </tr>

              <!-- Loop through people with this condition -->
              <xsl:for-each select="key('condition', MedicalConditions)">
                <tr>
                  <td><xsl:value-of select="Name"/></td>
                  <td><xsl:value-of select="Age"/></td>
                  <td>
                    <xsl:choose>
                      <!-- If DisabilityType equals 'none', output 'none' -->
                      <xsl:when test="DisabilityType = 'none'">
                        <xsl:text>none</xsl:text>
                      </xsl:when>
                      <!-- Otherwise, output 'yes' -->
                      <xsl:otherwise>
                        <xsl:text>yes</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
            <hr/>
          </div>
        </xsl:for-each>

      </body>
    </html>
  </xsl:template>

  <!-- Key to group people by Medical Condition -->
  <xsl:key name="condition" match="Person" use="MedicalConditions"/>
  
</xsl:stylesheet>

