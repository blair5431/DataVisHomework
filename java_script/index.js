// Get references to the tbody element, input field and button
var $tbody = document.querySelector("tbody");
var $dateInput = document.querySelector("#datetime");
var $searchBtn = document.querySelector("#search");

// Add an event listener to the searchButton, call handleSearchButtonClick when clicked
$searchBtn.addEventListener("click", handleSearchButtonClick);

// Set filteredufo to ufo dataset initially
var filteredufo = dataSet;

// renderTable renders the filteredufo to the tbody
function renderTable() {
  $tbody.innerHTML = "";
  for (var i = 0; i < filteredufo.length; i++) {
    // Get get the current address object and its fields
    var ufo = filteredufo[i];
    var fields = Object.keys(ufo);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var $row = $tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the address object, create a new cell at set its inner text to be the current value at the current address's field
      var field = fields[j];
      var $cell = $row.insertCell(j);
      $cell.innerText = ufo[field];
    }
  }
}

function handleSearchButtonClick() {
//   // Format the user's search by removing leading and trailing whitespace, lowercase the string
  var filterDate = $dateInput.value;
  console.log(filterDate);

//   // Set filtereddate to an array of all info whose "date" matches the filter
  filteredufo = dataSet.filter(function(ufo) {
    var ufoDate = ufo.datetime;
    console.log(ufoDate);
    console.log(filterDate);

//     // If true, add the ufo to the filteredDated, otherwise don't add it to filteredDate
    return ufoDate === filterDate;
  });
  renderTable();
}

// Render the table for the first time on page load
renderTable();