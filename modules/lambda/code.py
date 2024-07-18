import json

def lambda_handler(event, context):
    # Log the received event
    print("Received event: " + json.dumps(event, indent=2))

    # Iterate over each record in the event
    for record in event['Records']:
        # Extract bucket name and object key from the event
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        
        # Print the name of the object
        print(f"Object '{object_key}' was added to bucket '{bucket_name}'.")

    return {
        'statusCode': 200,
        'body': json.dumps(f"Processed {len(event['Records'])} records.")
    }
