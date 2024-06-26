#!/usr/bin/env python3
"""
Python function that inserts a new document in a collection based on kwargs
"""
import pymongo


def insert_school(mongo_collection, **kwargs):
    """
    inserts a new document into a collection
    """
    data = mongo_collection.insert_one(kwargs)
    return data.inserted_id
