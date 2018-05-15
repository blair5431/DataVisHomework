// Render sample names when /names
Plotly.d3.json('/names', function (error,data) {
    if (error) return console.warn(error);

    var namesList = document.querySelector("#selDataset");

    // Lopp through array and store in HTML
    for(var i = 0; i < names.length; i ++) {
        
        // Empty string to hold HTML
        var namesListItem = document.createElement("option");

        // Retrieve todo object from todos list
        var name = names[i];

        // Update namesListItem's innter HTML w/ text of name object
        namesListItem.innerHTML = name.text;

        // Add name to the list
        namesList.appendChild(namesListItem);

    }
});
