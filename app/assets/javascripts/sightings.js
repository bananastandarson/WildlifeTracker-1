$("document").ready(function() {

  $("#add_new_sighting_button").on(
  "click",
  function() {
    // Data to be submitted
    new_sighting = {
      "sighting": {
        "name": $("#sighting_name").val(),
        "latin_name": $("#sighting_latin_name").val(),
        "kingdom": $("#sighting_kingdom").val()
      }
    };

    $.ajax({
      dataType: 'json',
      url: '/sightings',
      method: 'POST',
      data: new_sighting,
      success: function(data) {
        add_to_sighting_list(data);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Add new sighting failed: " + errorThrown);
      }
    });
  });// end add wine

  // Function to be called after data has been successfully submitted
  function add_to_sighting_list(data) {
    // alert(JSON.stringify(data));
    // alert("sighting added");
    $("#sighting_list").append(
      '<tr><td>' + $("#sighting_name").val() + '</td><td>' +
      $("#sighting_latin_name").val() + '</td><td>' +
      $("#sighting_kingdom").val() + '</td><td>' + '<a href="/sightings/' + data.id + '">Show</a>' + '</td><td>' + '<a href="/sightings/' + data.id + '/edit">Edit</a>' + '</td><td>' + '<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/sightings/' + data.id + '">Destroy</a>' + '</td></tr>');
  }

}); // end document ready
