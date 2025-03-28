import ObserverState from './observer_state.js';
import Moon from './moon.js';
import Sun from './sun.js';
import Jupiter from './jupiter.js';
import TidalForce from './tidal_force.js';
import { LOCATION } from '../constants/config.js';

export default class Main {
  constructor(start_at, end_at, location) {
    this.start_at = start_at;
    this.end_at = end_at;
    this.location = location;
  }

  get #getObserverState() {
    const location = LOCATION[this.location];
    const observerState = new ObserverState(this.start_at, this.end_at, location);
    return observerState;
  }

  get #getSunInstance() {
    return new Sun(this.observerState);
  }

  get getMoonTidalForces() {
    const moon = new Moon(this.#getObserverState);
    const moonTidalForce = new TidalForce(moon);
    const moonVerticalTidalForces = moonTidalForce.calcVerticalTidalForces();
    const moonLateralTidalForces = moonTidalForce.calcLateralTidalForces();
    // console.log(moonVerticalTidalForces);
    // console.log(moonLateralTidalForces);
    return { "verticals": moonVerticalTidalForces, "laterals": moonLateralTidalForces };
  }

  get getSunTidalForces() {
    const sunTidalForce = new TidalForce(this.#getSunInstance);
    const sunVerticalTidalForces = sunTidalForce.calcVerticalTidalForces();
    const sunLateralTidalForces = sunTidalForce.calcLateralTidalForces();
    // console.log(sunVerticalTidalForces);
    // console.log(sunLateralTidalForces);
    return { "verticals": sunVerticalTidalForces, "laterals": sunLateralTidalForces };
  }

  get getJupiterDistances() {
    const jupiter = new Jupiter(this.observerState, this.#getSunInstance);
    const jupiterDistances = jupiter.getDistances;
    // console.log(jupiterDistances);
    return jupiterDistances;
  }
}
