import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';
import * as d3 from "d3";

const token = 'pk.eyJ1IjoianVsaWFubGYiLCJhIjoiY2tndzl6aXhqMDAxazMwb3NoeTNtNjN2biJ9.rKcfejZ9GeY9RhR-li-d4w';
let positions = [];

const addPoint = (map, coord) => {
  // const popup = new mapboxgl.Popup({ offset: 25 })
  //   .setHTML('<h3>Project Description</h3><a href="' + project_path + project.id + '">more information</a>');
  new mapboxgl.Marker()
    .setLngLat(coord)
    // .setPopup(popup)
    .addTo(map);
};

const trackUser = (map) => {
  map.on('load', function() {
    setInterval()
  });
};


const generateFakeMove = (map) => {
  map.on('load', function() {
    d3.json(
      'https://docs.mapbox.com/mapbox-gl-js/assets/hike.geojson').then((data) => {
      const coordinates = data.features[0].geometry.coordinates;
      console.log(coordinates);
      data.features[0].geometry.coordinates = [coordinates[0]];
      map.addSource('trace', { type: 'geojson', data: data });
      map.addLayer({
        'id': 'trace',
        'type': 'line',
        'source': 'trace',
        'paint': {
          'line-color': '#669df6',
          'line-opacity': 0.75,
          'line-width': 5
        }
      });
      map.jumpTo({ 'center': coordinates[0], 'zoom': 14 });
      map.setPitch(30);
      var i = 0;
      var timer = window.setInterval(function() {
        if (i < coordinates.length) {
          data.features[0].geometry.coordinates.push(
            coordinates[i]
          );
          map.getSource('trace').setData(data);
          map.panTo(coordinates[i]);
          i += 100;
        } else {
          window.clearInterval(timer);
        }
      }, 10);
    });
  });
};


const initMap = (center) => {
  mapboxgl.accessToken = token;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: center, // starting position
    zoom: 12
  });
  addPoint(map, center);
  generateFakeMove(map);
  // trackUser(map);
};

const transformPos = (pos) => {
  return new Promise(resolve => {
    const crd = pos.coords;

    resolve([crd.longitude, crd.latitude]);
  });
};

const success = (pos) => {
  transformPos(pos).then((position) => {
    if (position !== []) {
      initMap(position)
      positions.push(position);
    }
  });
}

const error = (err) => {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

const initMapWithUser = () => {
  const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };
  navigator.geolocation.getCurrentPosition(success, error, options);
};

export { initMapWithUser };
