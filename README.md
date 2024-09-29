XML Care Platform Project
This project models and exploits an XML database for a collaborative platform focused on providing social and medical care services for elderly and disabled individuals. The platform manages participants, service providers, and a variety of services and activities. The main goal is to automate and streamline service recommendations and generate reports that are accessible in different formats like HTML, XML, and JSON.

Project Structure and Scenarios
Files in the Project:

Care_Platform_Final_Version.xml:
The main XML database file that contains all participant, service, and provider data.

Care_Platform_Schema.xsd:
The XML Schema file that defines the structure, constraints, and data types used in the XML database.

Implemented Scenarios:

Scenario 1 to 4:
These scenarios were developed using XSL transformations in Notepad++ with XML plugins. Each scenario outputs a specific view of the XML data (e.g., Service Providers List, Service Frequency List) in HTML format. These transformations allow users to view key aspects of the database directly from XML using predefined XSL stylesheets.

Scenario 5: Service Recommendation System:
This scenario was implemented using a Python script that uses the lxml library to transform the XML database into an HTML report. The script reads the participants' medical conditions and disabilities and recommends services accordingly, generating a ranked list of suggested services.

Installation:
To run Scenario 5, ensure you have Python installed and the lxml library in your virtual environment:
pip install lxml


Scenario 6: RSS Feed Transformation:
This scenario works differently compared to the others. It transforms the original XML database into another XML format and outputs an HTML file that follows the structure of an RSS feed. 

Scenario 7: JSON Transformation with Search Functionality:
This scenario converts the XML database into JSON format and then integrates the result into an HTML file that serves as an interactive search tool. Users can enter a PersonID into a search bar, and the tool will display the corresponding participant’s information.