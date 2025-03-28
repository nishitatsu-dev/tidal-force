export const SEC_PER_HOUR = 3600;
export const MIN_PER_HOUR = 60;
export const MSEC_PER_DAY = 86400000;
export const HOUR_PER_DAY = 24;
// 1970/1/1 0時0分（世界時）のユリウス日
export const UNIX_EPOCH_JULIAN_DATE = 2440587.5;
// 2017/1/1以降は69.184 ± 0.9秒
export const DELTA_T = { 20170101: 69.184 }; // s

export const G = 6.67428e-11; // m^3 kg^-1 s^-2
export const MASS_MOON = 7.345752822e22; // kg
export const MASS_SUN = 1.9884e30; // kg
export const EARTH_RADIUS = 6378136.6; // m
export const AU = 149597870700; // m

export const LOCATION = {
  "NEMURO" : { "longitude": 145.583, "latitude": 43.333 },
  "AKITA" : { "longitude": 140.117, "latitude": 39.717 },
  "TOKYO" : { "longitude": 139.733, "latitude": 35.65 },
  "OGASAWARA" : { "longitude": 142.183, "latitude": 27.083 },
  "TAKAMATSU" : { "longitude": 134.05, "latitude": 34.35 },
  "KAGOSHIMA" : { "longitude": 130.55, "latitude": 31.5 },
  "NAHA" : { "longitude": 127.667, "latitude": 26.216 }
}
