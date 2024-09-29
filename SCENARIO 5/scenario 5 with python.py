from lxml import etree


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


xml_file_path = 'C:/Users/harry/OneDrive/Documents/XML PROJECT V2/Careplatform_springf 1.xml'


tree = etree.parse(xml_file_path)
root = tree.getroot()


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


for person in root.xpath('//Person'):
    person_id = person.find('ID').text
    person_name = person.find('Name').text
    disability = person.find('DisabilityType').text
    medical_conditions = person.find('MedicalConditions').text

   
    html_output += f"<h2>Participant: {person_name} (ID: {person_id})</h2>"
    html_output += f"<p>Disability: {disability} | Medical Conditions: {medical_conditions}</p>"

   
    recommended_service_types = set()
    

    if disability in matching_criteria:
        recommended_service_types.update(matching_criteria[disability])

    for condition in medical_conditions.split(", "):
        if condition in matching_criteria:
            recommended_service_types.update(matching_criteria[condition])
    

    service_recommendations = []
    for service in root.xpath('//Service'):
        service_id = service.find('ID').text
        service_description = service.find('Description').text
        service_type = service.find('Type').text
        
       
        if service_type in recommended_service_types:
            score = 10  # Perfect match
        else:
            score = 0  # No match

     
        if score > 0:  
            service_recommendations.append({
                'service_id': service_id,
                'description': service_description,
                'type': service_type,
                'score': score
            })

  
    service_recommendations.sort(key=lambda x: x['score'], reverse=True)

   
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


html_output += """
</body>
</html>
"""


output_file_path = 'C:/Users/harry/OneDrive/Documents/XML PROJECT V2/service_recommendation_report.html'
with open(output_file_path, 'w') as file:
    file.write(html_output)

print(f"HTML report generated: {output_file_path}")
