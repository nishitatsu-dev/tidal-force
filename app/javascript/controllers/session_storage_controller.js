import { Controller } from "@hotwired/stimulus"
import * as tidalForcePlus from "tidal_force_plus";

// Connects to data-controller="session-storage"
export default class extends Controller {
  static targets = ["locationSelect", "firstDateField", "lastDateField"];

  setItem() {
    const location = this.locationSelectTarget.value;
    const firstDate = this.firstDateFieldTarget.value;
    const lastDate = this.lastDateFieldTarget.value;
    const main = new tidalForcePlus.Main(firstDate, lastDate, location);

    this.#setBasicParams(main, firstDate);
    this.#setTidalForcePlus(main);
  }

  #setBasicParams(main, firstDate) {
    const xAxisData = main.getDateTimes["xAxisData"];
    const ISODateTimes = main.getDateTimes["ISODateTimes"];
    const totalDay = main.getDateTimes["totalDay"];

    sessionStorage.setItem("xAxisData", xAxisData);
    sessionStorage.setItem("ISODateTimes", ISODateTimes);
    sessionStorage.setItem("firstDay", firstDate);
    sessionStorage.setItem("totalDay", totalDay);
  }

  #setTidalForcePlus(main) {
    const moonTidalForces = main.getMoonTidalForces;
    const sunTidalForces = main.getSunTidalForces;
    const jupiterDistances = main.getJupiterDistances;

    const moonVerticals = moonTidalForces.verticals.flat();
    const sunVerticals = sunTidalForces.verticals.flat();
    const moonAndSunVerticals = moonVerticals.map((v, i) => v + sunVerticals[i]);

    const moonLateralStrengths = moonTidalForces.laterals.strengths.flat();
    const moonLateralAzimuths = moonTidalForces.laterals.azimuths.flat();
    const sunLateralStrengths = sunTidalForces.laterals.strengths.flat();
    const sunLateralAzimuths = sunTidalForces.laterals.azimuths.flat();

    sessionStorage.setItem("moonVerticals", moonVerticals);
    sessionStorage.setItem("sunVerticals", sunVerticals);
    sessionStorage.setItem("moonAndSunVerticals", moonAndSunVerticals);
    sessionStorage.setItem("jupiterDistances", jupiterDistances.flat());

    sessionStorage.setItem("moonLateralStrengths", moonLateralStrengths);
    sessionStorage.setItem("moonLateralAzimuths", moonLateralAzimuths);
    sessionStorage.setItem("sunLateralStrengths", sunLateralStrengths);
    sessionStorage.setItem("sunLateralAzimuths", sunLateralAzimuths);
  }
}
