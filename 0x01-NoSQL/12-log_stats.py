#!/usr/bin/env python3
'''try '''
from pymongo import MongoClient


# MongoDB connection settings
mongo_host = 'localhost'
mongo_port = 27017
mongo_db = 'logs'
mongo_collection = 'nginx'

def connect_to_mongodb():
    """Connect to MongoDB and return the client, database, and collection objects."""
    client = MongoClient(mongo_host, mongo_port)
    db = client[mongo_db]
    collection = db[mongo_collection]
    return client, db, collection

def count_documents(collection):
    """Count the total number of documents in a given collection."""
    return collection.estimated_document_count()

def count_method_documents(collection, method):
    """Count the number of documents with a specific HTTP method in the collection."""
    return collection.count_documents({"method": method})

def count_status_check(collection):
    """Count the number of documents with method=GET and path=/status."""
    return collection.count_documents({"method": "GET", "path": "/status"})

def run_statistics_scenario():
    """Run the statistics scenario against the specified MongoDB setup."""
    # Connect to MongoDB
    client, db, collection = connect_to_mongodb()

    try:
        # Total number of documents in the collection
        total_logs = count_documents(collection)
        print(f"{total_logs} logs")

        # Count documents for each HTTP method
        methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
        method_counts = {method: count_method_documents(collection, method) for method in methods}

        # Print the "Methods:" line
        print("Methods:")
        for method in methods:
            print(f"    method {method}: {method_counts[method]}")

        # Count documents with specific method and path
        status_check_count = count_status_check(collection)
        print(f"{status_check_count} status check")

    finally:
        # Close MongoDB connection
        client.close()

if __name__ == "__main__":
    run_statistics_scenario()
