import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';

// const baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';
// const endUrl = '.json?access_token=';
const token = 'pk.eyJ1IjoianVsaWFubGYiLCJhIjoiY2tndzl6aXhqMDAxazMwb3NoeTNtNjN2biJ9.rKcfejZ9GeY9RhR-li-d4w';
let position = [];
let positions = [];

const initMap = (center) => {
  console.log(center);
  mapboxgl.accessToken = token;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v9',
    center: center, // starting position
    zoom: 12
  });
  new mapboxgl.Marker()
    .setLngLat(center)
    .addTo(map);
};

const transformpos = (pos) => {
  return new Promise(resolve => {
    const crd = pos.coords;

    position = [crd.longitude, crd.latitude];
    resolve(position);
  });
};

const success = (pos) => {
  transformpos(pos).then((position) => {
    if (position !== []) {
      initMap(position)
      positions.push(position);
    }
  });
}

const error = (err) => {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

const getUserCoord = () => {
  const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };
  navigator.geolocation.getCurrentPosition(success, error, options);
};

export { getUserCoord, initMap };
