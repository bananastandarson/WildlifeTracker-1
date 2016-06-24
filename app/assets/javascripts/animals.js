$("document").ready(function() {

  $("#add_new_animal_button").on(
  "click",
  function() {
    // Data to be submitted
    new_animal = {
      "animal": {
        "name": $("#animal_name").val(),
        "latin_name": $("#animal_latin_name").val(),
        "kingdom": $("#animal_kingdom").val()
      }
    };

    $.ajax({
      dataType: 'json',
      url: '/animals',
      method: 'POST',
      data: new_animal,
      success: function(data) {
        add_to_animal_list(data);
      },
      error: function(jqXHR, textStatus, errorThrown) {
        alert("Add new animal failed: " + errorThrown);
      }
    });
  });// end add wine

  // Function to be called after data has been successfully submitted
  function add_to_animal_list(data) {
    // alert(JSON.stringify(data));
    // alert("Animal added");
    $("#animal_list").append(
      '<tr><td>' + $("#animal_name").val() + '</td><td>' +
      $("#animal_latin_name").val() + '</td><td>' +
      $("#animal_kingdom").val() + '</td><td>' + '<a href="/animals/' + data.id + '">Show</a>' + '</td><td>' + '<a href="/animals/' + data.id + '/edit">Edit</a>' + '</td><td>' + '<a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/animals/' + data.id + '">Destroy</a>' + '</td></tr>');
  }

}); // end document ready
