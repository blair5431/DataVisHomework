# Dependencies
from bs4 import BeautifulSoup
import requests
import pandas as pd
from selenium import webdriver

def scrape():
    #Empty dictonary to hold all results
    mars_results = {}

    ##### Mars News #####

    # URL of nasa to be scraped
    nasa_url = 'https://mars.nasa.gov/news/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest'

    # Retrieve page with the requests module
    response = requests.get(nasa_url)
    # Create BeautifulSoup object; parse with 'html.parser'
    soup = BeautifulSoup(response.text, 'html.parser')
    #latest news title
    news_title = soup.find('div', class_='content_title').find('a').text.strip()
    #print(news_title)

    #####FEATURED IMAGE####
    featured_image_url = 'https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA16225_hires.jpg'

    ######## Mars Weather ###########
    twitter_url="https://twitter.com/marswxreport?lang=en"
    # Retrieve page with the requests module
    tweet_response = requests.get(twitter_url)
    # Create BeautifulSoup object; parse with 'html.parser'
    tweet_soup = BeautifulSoup(tweet_response.text, 'html.parser')

    mars_weather = tweet_soup.find('div', class_='js-tweet-text-container').find('p').text.strip()
    #print(mars_weather)

    #######Mars Facts######
    url_facts = "https://space-facts.com/mars/"
    tables = pd.read_html(url_facts)
    
    table_df = tables[0]
    #print(table_df)

    #must set coloumn names because column names are in data rows
    table_df.columns = ['Decription', 'Value']
    table_df.head()

    #converting the table to html
    html_table = table_df.to_html()
    #print(html_table)

    hemisphere_image_urls = [
    {"title": "Valles Marineris Hemisphere", "img_url": "https://astrogeology.usgs.gov/cache/images/04085d99ec3713883a9a57f42be9c725_valles_marineris_enhanced.tif_thumb.png"},
    {"title": "Cerberus Hemisphere", "img_url": "https://astrogeology.usgs.gov/cache/images/dfaf3849e74bf973b59eb50dab52b583_cerberus_enhanced.tif_thumb.png"},
    {"title": "Schiaparelli Hemisphere", "img_url": "https://astrogeology.usgs.gov/cache/images/7677c0a006b83871b5a2f66985ab5857_schiaparelli_enhanced.tif_thumb.png"},
    {"title": "Syrtis Major Hemisphere", "img_url": "https://astrogeology.usgs.gov/cache/images/aae41197e40d6d4f3ea557f8cfe51d15_syrtis_major_enhanced.tif_thumb.png"},
    ]
    #print(hemisphere_image_urls)

    ###### CONVERTING EVERYTHING TO PYTHON DICTONARY ####
    
    
    mars_results["title"] = news_title
    mars_results["feat_image"] =  featured_image_url
    mars_results["weather"] = mars_weather
    mars_results["facts"] =  html_table
    mars_results["hemispheres"] =  hemisphere_image_urls

    return mars_results

    



