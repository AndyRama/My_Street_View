import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';
import * as d3 from "d3";

const token = 'pk.eyJ1IjoianVsaWFubGYiLCJhIjoiY2tndzl6aXhqMDAxazMwb3NoeTNtNjN2biJ9.rKcfejZ9GeY9RhR-li-d4w';
const options = { enableHighAccuracy: true, timeout: 5000, maximumAge: 0 };
const origin = window.document.location.origin
const markers = [];
const user = document.querySelector('#user')
const color = ['#279AF1', '#E87310', '#03CEA4'];
const mode = document.querySelector('#map-mode');
// [bleu, orange, vert]

let map;

// Longitude = VERTICALE
// Latitude = HORIZONTALE
// position = [longitude, latitude]

const distance = (lon1, lat1, lon2, lat2) => {
  if ((lat1 == lat2) && (lon1 == lon2)) {
    return 0;
  } else {
    const radlat1 = Math.PI * lat1 / 180;
    const radlat2 = Math.PI * lat2 / 180;
    const theta = lon1 - lon2;
    const radtheta = Math.PI * theta / 180;
    let dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
    if (dist > 1) {
      dist = 1;
    }
    dist = Math.acos(dist);
    dist = dist * 180 / Math.PI;
    dist = dist * 60 * 1.1515;
    return (dist * 1.609344 * 1000)
  }
}

const addPoint = (coord, descr, progress) => {
  const popup = new mapboxgl.Popup({ offset: 25 })
    .setHTML(descr);
  return new mapboxgl.Marker({ color: color[progress] })
    .setLngLat(coord)
    .setPopup(popup)
    .addTo(map);
};

const generateFakeMove = () => {
  markers.forEach((marker) => { marker.remove() });
  d3.json(
    `${origin}/api/v1/checkpoints`).then((checkpoints) => {
    let data = { type: "FeatureCollection", features: [{ type: "Feature", geometry: { type: "LineString", coordinates: checkpoints } }] }
    const coordinates = data.features[0].geometry.coordinates;
    data.features[0].geometry.coordinates = [coordinates[0]];
    map.addSource('trace', { type: 'geojson', data: data });
    map.addLayer({
      'id': 'trace',
      'type': 'line',
      'source': 'trace',
      'paint': {
        'line-color': '#000000',
        'line-opacity': 0.5,
        'line-width': 5
      }
    });
    map.jumpTo({ 'center': coordinates[0], 'zoom': 13 });
    map.setPitch(30);
    let i = 0;
    const timer = window.setInterval(function() {
      if (i < coordinates.length) {
        data.features[0].geometry.coordinates.push(
          coordinates[i]
        );
        map.getSource('trace').setData(data);
        map.panTo(coordinates[i]);
        markers.forEach((marker) => {
          if (150 > distance(marker._lngLat.lng, marker._lngLat.lat, coordinates[i][0], coordinates[i][1])) {
            marker.addTo(map);
          }
        });
        i += 1;
      } else {
        window.clearInterval(timer);
      }
    }, 10);
  });
};

const transformPos = (pos) => {
  return new Promise(resolve => {
    const crd = pos.coords;
    resolve([crd.longitude, crd.latitude]);
  });
};

const saveCheckpoint = (position) => {
  fetch(`${origin}/api/v1/checkpoints`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: `{ "checkpoint": { "longitude": ${position[0]}, "latitude": ${position[1]} } }`
  })
};


const trackUser = (pos) => {
  transformPos(pos).then((position) => {
    if (position !== []) {
      const data = { type: "FeatureCollection", features: [{ type: "Feature", geometry: { type: "LineString", coordinates: [position] } }] }
      map.getSource('trace').setData(data);
      map.panTo(position);
      saveCheckpoint(position);
    }
  });
};


const generateMove = (center, nbr) => {
  map.on('load', function() {
    const data = { type: "FeatureCollection", features: [{ type: "Feature", geometry: { type: "LineString", coordinates: [center] } }] }
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
    map.jumpTo({ 'center': center, 'zoom': 13 });
    map.setPitch(30);
    let i = 0;
    const timer = window.setInterval(function() {
      if (i < nbr) {
        navigator.geolocation.getCurrentPosition(trackUser, error, options);
        i += 1;
      } else {
        console.log('Stop tracking');
        window.clearInterval(timer);
      }
    }, 60000);
  });
};

const drawProject = () => {
  const projects = document.querySelectorAll('#all-projects > .card');
  projects.forEach((project) => {
    const lon = parseFloat(project.dataset.lon);
    const lat = parseFloat(project.dataset.lat);
    const progress = parseFloat(project.dataset.progress);
    const position = [lon, lat];
    const descr = project.innerHTML;
    markers.push(addPoint(position, descr, (progress - 1)));
  });
};

const initMode = (center) => {
  const nbr = document.querySelector('#track-nbr');
  const label = document.querySelector('#map-mode-label');
  const lancer = document.querySelector('#lancer');
  mode.onclick = function(event) {
    if (event.currentTarget.checked) {
      nbr.classList.remove('d-none');
      label.innerText = "Traçage";
    } else {
      nbr.classList.add('d-none');
      label.innerText = "Simulation";
    }
  }
  lancer.onclick = function(event) {
    if (mode.checked) {
      console.log('Tracing');
      generateMove(center, nbr.value); // Tracking
    } else {
      console.log('Simulation');
      generateFakeMove(); // Simulate
    }
  }
};

const initMap = (center) => {
  mapboxgl.accessToken = token;
  map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: center, // starting position
    zoom: 12
  });
  drawProject();
  map.on('load', function() {
    if (mode.parentNode.parentNode.classList.contains('d-none')) {
      console.log('Simulation');
      generateFakeMove(); // Simulate
    } else {
      initMode(center);
    }
  });
};

const init = (pos) => {
  transformPos(pos).then((position) => {
    if (position !== []) {
      initMap(position)
    }
  });
}

const error = (err) => {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

const initMapWithUser = () => {
  if (user && user.dataset.user) {
    navigator.geolocation.getCurrentPosition(init, error, options);
  }
};

export { initMapWithUser };
