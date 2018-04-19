import datetime as dt
import numpy as np
import pandas as pd

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify 

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///hawaii.sqlite", echo=False)")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to the measurmentws and stations tables
Measurements = Base.classes.measurements
Stations = Base.classes.stations

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Avalable Routes:<br/>"
        f"/api/v1.0/precipitation - Hawaii Precipitation Past Year<br/>"


        f"/api/v1.0/stations"
        f"- List of stations in Hawaii<br/>"

        f"/api/v1.0/tobs"
        f"- Temperature observations from the previous year<br/>"

        f"api/v1.0/<start>"
        f"start date for selected temperatue information <br/>"

        f"/api/v1.0/<start>/<end>"
        f"- end data for selected temperature infromation<br/>"
    )

@app.route("/api/v1.0/precipitation")
def countries():
    """Return a precipitation"""
    # Query for the dates and temperature observations from the last year.
    date_prcp=session.query(Measurements.date,Measurements.prcp).\
    filter(Measurements.date > '2016-08-23').\
    order_by(Measurements.date).all()

    #Convert the query results to a Dictionary using date as the key and tobs as the value.
    precipitation_data = []
    for result in date_prcp:
        row = {}
        row["Data"] = result[0]
        row["Percipitation"] = float(result[1])
        precipitation_data.append(row)

    return jsonify(precipitation_data)
    

@app.route("/api/v1.0/stations")
def countries():
    """Return a stations"""
    # Return a json list of stations from the dataset.
    active_stations=session.query(Measurements.station, func.count(Measurements.station)).group_by(Measurements.station).order_by(Measurements.station.desc()).all() 


      # Convert list of tuples into normal list
    stations_list = list(np.ravel(active_stations))

    return jsonify(stations_list )

@app.route("/api/v1.0/tobs")
def countries():
    """Return Temperature observations"""
    # Return a json list of stations from the dataset.
    temp_obs=session.query(Measurements.date,Measurements.tobs).\
    filter(Measurements.date > '2016-08-23').
    order_by(Measurements.date).all()

      # Convert list of tuples into normal list
    temp_obs_list = list(np.ravel(temp_obs))

    return jsonify(temp_obs_list)

if __name__ == '__main__':
    app.run()