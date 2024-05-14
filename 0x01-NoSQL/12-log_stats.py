#!/usr/bin/env python3
"""
Provide some stats about Nginx logs stored in MongoDB
Database: logs, Collection: nginx, Display same as example
first line: x logs, x number of documents in this collection
second line: Methods
5 lines with method = ["GET", "POST", "PUT", "PATCH", "DELETE"]
one line with method=GET, path=/status
"""

from pymongo import MongoClient

# MongoDB connection settings
mongo_host = 'localhost'
mongo_port = 27017
mongo_db = 'logs'
mongo_collection = 'nginx'

# Connect to MongoDB
client = MongoClient(mongo_host, mongo_port)
db = client[mongo_db]
collection = db[mongo_collection]

# Total number of documents in the collection
total_logs = collection.count_documents({})

# Print total number of logs
print(f"{total_logs} logs")

# Count documents for each HTTP method
methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
method_counts = {method: collection.count_documents({"method": method}) for method in methods}

# Print method counts
print("Methods:")
for method in methods:
    print(f"    method {method}: {method_counts[method]}")

# Count documents with specific method and path
status_check_count = collection.count_documents({"method": "GET", "path": "/status"})

# Print status check count
print(f"{status_check_count} status check")

# Close MongoDB connection
client.close()
