from lxml import etree

# Define a dictionary to map disability and medical conditions to recommended service types
matching_criteria = {
    "Mobility Impairment": ["Physical Activity"],
    "Vision Impairment": ["Social Activity"],
    "Hearing Loss": ["Social Activity"],
    "Cognitive Impairment": ["Social Activity", "Cognitive Therapy"],
    "Reduced Mobility": ["Physical Activity", "Assistance Service"],
    "Arthritis": ["Physical Activity"],
    "Hypertension": ["Physical Activity"],
    "Parkinson's Disease": ["Physical Activity", "Assistance Service"],
    "Diabetes": ["Dietary Assistance", "Medical Assistance"],
    "Alzheimer's Disease": ["Cognitive Therapy", "Social Activity"]
}

# Use the absolute path to the XML file
xml_file_path = 'C:/Users/harry/OneDrive/Documents/XML PROJECT V2/Careplatform_springf 1.xml'

# Load the XML file using the absolute path
tree = etree.parse(xml_file_path)
root = tree.getroot()

# Start building the HTML output
html_output = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Recommendation Report</title>
    <link rel="stylesheet" type="text/css" href="style2.css">
</head>
<body>
    <h1>Service Recommendation Report</h1>
"""

# Loop through each participant to generate recommendations
for person in root.xpath('//Person'):
    person_id = person.find('ID').text
    person_name = person.find('Name').text
    disability = person.find('DisabilityType').text
    medical_conditions = person.find('MedicalConditions').text

    # Display participant details
    html_output += f"<h2>Participant: {person_name} (ID: {person_id})</h2>"
    html_output += f"<p>Disability: {disability} | Medical Conditions: {medical_conditions}</p>"

    # Determine matching service types based on disability and medical conditions
    recommended_service_types = set()
    
    # Match services based on Disability Type
    if disability in matching_criteria:
        recommended_service_types.update(matching_criteria[disability])

    # Match services based on Medical Conditions
    for condition in medical_conditions.split(", "):
        if condition in matching_criteria:
            recommended_service_types.update(matching_criteria[condition])
    
    # Calculate match scores for each service
    service_recommendations = []
    for service in root.xpath('//Service'):
        service_id = service.find('ID').text
        service_description = service.find('Description').text
        service_type = service.find('Type').text
        
        # Calculate match score
        if service_type in recommended_service_types:
            score = 10  # Perfect match
        else:
            score = 0  # No match

        # Store the service and its score
        if score > 0:  # Only include services with a positive match score
            service_recommendations.append({
                'service_id': service_id,
                'description': service_description,
                'type': service_type,
                'score': score
            })

    # Sort recommendations by match score (highest to lowest)
    service_recommendations.sort(key=lambda x: x['score'], reverse=True)

    # Display the recommended services for the participant
    if service_recommendations:
        html_output += """
        <h3>Recommended Services:</h3>
        <table>
            <tr><th>Service Description</th><th>Type</th><th>Match Score</th></tr>
        """
        for recommendation in service_recommendations:
            html_output += f"""
            <tr>
                <td>{recommendation['description']}</td>
                <td>{recommendation['type']}</td>
                <td>{recommendation['score']}</td>
            </tr>
            """
        html_output += "</table>"
    else:
        html_output += "<p>No recommended services found for this participant.</p>"

# Close the HTML structure
html_output += """
</body>
</html>
"""

# Save the HTML output to a file
output_file_path = 'C:/Users/harry/OneDrive/Documents/XML PROJECT V2/service_recommendation_report.html'
with open(output_file_path, 'w') as file:
    file.write(html_output)

print(f"HTML report generated: {output_file_path}")
