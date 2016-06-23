json.array!(@sightings) do |sighting|
  json.extract! sighting, :id, :date, :time, :latitude, :longitude, :animal_id, :region_id
  json.url sighting_url(sighting, format: :json)
end
