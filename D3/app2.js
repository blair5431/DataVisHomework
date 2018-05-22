// Define SVG area dimensions
var svgWidth = 960;
var svgHeight = 500;

// Define the chart's margins as an object
var margin = {
  top: 60,
  right: 60,
  bottom: 60,
  left: 180
};

// Define dimensions of the chart area
var chartWidth = svgWidth - margin.left - margin.right;
var chartHeight = svgHeight - margin.top - margin.bottom;

// Select body, append SVG area to it, and set its dimensions
var svg = d3.select("body")
  .append("svg")
  .attr("width", svgWidth)
  .attr("height", svgHeight);

// Append a group area, then set its margins
var chartGroup = svg.append("g")
  .attr("transform", `translate(${margin.left}, ${margin.top})`);

// Load data from forcepoints.csv
d3.csv("brfss_census.csv", function (error, healthData) {

    // Throw an error if one occurs
    if (error) throw error;
  
    // Print the forceData
    console.log(healthData);
  
    // Forcesing values in csv to be numbers
    healthData.forEach(function (data) {
        data.flushot = +data.flushot;
        data.poverty = +data.poverty;
      });
  
    // Configure a time scale
    // d3.extent returns the an array containing the min and max values for the property specified
    var xLinearScale = d3.scaleLinear()
      .domain(d3.extent(healthData, data => data.flushot))
      .range([0, chartWidth]);
  
    // Configure a linear scale with a range between the chartHeight and 0
    var yLinearScale = d3.scaleLinear()
      .domain([0, d3.max(healthData, data => data.poverty)])
      .range([chartHeight, 0]);
  
    // Create two new functions passing the scales in as arguments
    // These will be used to create the chart's axes
    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);
  
    // Configure a line function which will plot the x and y coordinates using our scales
    // var drawLine = d3.line()
    //   .x(data => xLinearScale(data.flushot))
    //   .y(data => yLinearScale(data.poverty));
  
    // Append an SVG path and plot its points using the line function
    // chartGroup.append("path")
    //   // The drawLine function returns the instructions for creating the line for forceData
    //   .attr("d", drawLine(healthData))
    //   .classed("line", true);
  
    // Append an SVG group element to the chartGroup, create the left axis inside of it
    chartGroup.append("g")
      .classed("axis", true)
      .call(leftAxis);
  
    // Append an SVG group element to the chartGroup, create the bottom axis inside of it
    // Translate the bottom axis to the bottom of the page
    chartGroup.append("g")
      .classed("axis", true)
      .attr("transform", `translate(0, ${chartHeight})`)
      .call(bottomAxis);

      // draw dots
      var circlesGroup = chartGroup.selectAll("circle")
      .data(healthData)
      .enter()
      .append("circle")
      .attr("cx", d => xLinearScale(d.flushot))
      .attr("cy", d => yLinearScale(d.poverty))
      .attr("r", "2")
      .attr("fill", "gold")
      .attr("stroke-width", "5")
      .attr("stroke", "black");

      // // adding lables to cirles
      // svg.selectAll("text")
      // .data(healthData)
      // .enter()
      // .append("text")
      // .text(function(d){
      //   return d.state;
      // })
      // .attr("x", d => xLinearScale(d.flushot))
      // .attr("y", d => yLinearScale(d.poverty))
      // .attr("font_family", "sans-serif")  // Font type
      // .attr("font-size", "11px")  // Font size
      // .attr("fill", "darkgreen");


      // Adding x-axis lable
      chartGroup.append("text")
      // Position the text
      // Center the text:
      // (https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/text-anchor)
      .attr("transform",`translate(${chartWidth / 2}, ${chartHeight +30})`)
      .attr("text-anchor", "middle") //text-anchoer sayt to keep the text here
      .attr("font-size", "16px")
      .attr("fill", "black")
      .text("Flu Shot (%)");

      // Adding y-axis lable
      chartGroup.append("text")
      // Position the text
      // Center the text:
      // (https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/text-anchor)
      .attr("transform",`translate( -50, ${chartHeight/ 2 })`)
      .attr("text-anchor", "middle") //text-anchoer sayt to keep the text here
      .attr("font-size", "16px")
      .attr("fill", "black")
      .text("Poverty (%)");
    
    // Step 1: Initialize Tooltip
    var toolTip = d3.tip()
    .attr("class", "tooltip")
    .offset([80, -60]) //moves the box down and way from the cneter of the point
    .html(function(d){
      return (`<strong>${(d.state)}<strong>`)
    })

    // Step 2: Create the tooltip in chartGroup.
    chartGroup.call(toolTip)

    // Step 3: Create "mouseover" event listener to display tooltip
    circlesGroup.on("mouseover", function(d){
      toolTip.show(d)
    })
  // Step 4: Create "mouseout" event listener to hide tooltip
    .on("mouseout", function(d){
      toolTip.hide(d)
    });
  
    
});