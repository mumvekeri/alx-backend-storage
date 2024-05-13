#!/usr/bin/env python3
""" List documents all documents in a collection """
import pymongo


def list_all(mongo_collection) -> list:
    """ Lists all documents in a collection
    """
    documents: list = []

    for document in mongo_collection.find():
        documents.append(document)

    return documents
