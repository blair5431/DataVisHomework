from flask import Flask, render_template, jsonify, redirect
#from flask_pymongo import PyMongo
import pymongo
import scrape_mars

app = Flask(__name__)

conn = 'mongodb://localhost:27017'
client = pymongo.MongoClient(conn)
db = client.mars
collection = db.mars_stuff

@app.route("/")
def index():
    mars_results = db.collection.find_one()
    return render_template("index.html", mars_results=mars_results) 

@app.route("/scrape")
def scrape():

    # the database mars and the collection called mars_stuff
    mars_results = db.collection
    mars_data = scrape_mars.scrape()

    # Use update when something exists, updates the first thing it finds
    mars_results.update(
        {},
        mars_data,
        upsert=True
    )

    # returns to the app route and gets the one items to be rendered on the home page
    return redirect("http://localhost:5000/", code=302)

if __name__ == "__main__":
    app.run(debug=True)


