# import necessary libraries
import pandas as pd

from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect

from flask import (
    Flask,
    render_template,
    jsonify)

#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///DataSets/belly_button_biodiversity.sqlite")

# reflect an existing database into a new model
# copies table strucutres from database structure as it already exixts
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

#print all the calsses mapped to the base
Base.classes.keys()

# Assign each class to is own variable
Otu=Base.classes.otu
Samples=Base.classes.samples
Samples_metabdata =Base.classes.samples_metadata

inspector = inspect(engine)

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

@app.route("/")
def index():
    """Render Home Page."""
    return render_template('index.html')

@app.route('/names')
def names():
    columns = inspector.get_columns('samples')
    names = []
    for column in columns:
        print(column["name"], column["type"])
        name = column["name"]
        names.append(name)
    names.pop(0)
    print(names)
    return jsonify(names)
    

@app.route('/otu')
def otu():
    otu_results = session.query(Otu.lowest_taxonomic_unit_found).all()
    otus = []
    
    for result in otu_results:
        otus.append(result)
    print(otus)
    return jsonify(otus)
   
    

# @app.route('/metadata/<sample>')
    # """MetaData for a given sample.
    # merged_data = session.query(Samples_metabdata).filter(Samples.otu_id == Samples_metabdata.SAMPLEID).all()

    # def sample_metadat(sample):
        
        # for data in merged_data:
            # sample_search = sample.replace("BB_", "")

    # Args: Sample in the format: `BB_940`

    # Returns a json dictionary of sample metadata in the format

    # {
    #     AGE: 24,
    #     BBTYPE: "I",
    #     ETHNICITY: "Caucasian",
    #     GENDER: "F",
    #     LOCATION: "Beaufort/NC",
    #     SAMPLEID: 940
    # }
    # """

# @app.route('/wfreq/<sample>')
    # """Weekly Washing Frequency as a number.

    # Args: Sample in the format: `BB_940`

    # Returns an integer value for the weekly washing frequency `WFREQ`
    # """

# @app.route('/samples/<sample>')
    # """OTU IDs and Sample Values for a given sample.

    # Sort your Pandas DataFrame (OTU ID and Sample Value)
    # in Descending Order by Sample Value

    # Return a list of dictionaries containing sorted lists  for `otu_ids`
    # and `sample_values`

    # [
    #     {
    #         otu_ids: [
    #             1166,
    #             2858,
    #             481,
    #             ...
    #         ],
    #         sample_values: [
    #             163,
    #             126,
    #             113,
    #             ...
    #         ]
    #     }
    # ]
    # """
if __name__ == "__main__":
    app.run(debug=True)