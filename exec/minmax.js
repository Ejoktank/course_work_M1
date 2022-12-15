const fs = require("fs");

const Data = {
  no_trench: {
    files: [
      "../hs/no-trench/coarse-mesh/01_su_euler_1.txt",
      "../hs/no-trench/coarse-mesh/01_su_euler_2.txt",
      "../hs/no-trench/coarse-mesh/01_su_euler_3.txt",
    ],
    columns: [49, 50, 51, 52, 53, 54, 55, 56],
  },
  open_trench: {
    files: [
      "../hs/open-trench/coarse-mesh/01_su_euler_1.txt",
      "../hs/open-trench/coarse-mesh/01_su_euler_2.txt",
      "../hs/open-trench/coarse-mesh/01_su_euler_3.txt",
    ],
    columns: [53, 54, 55, 56, 57, 58, 59, 60],
  },
};

function mapData(object) {
  object.files.map((path) => {
    fs.readFile(path, "utf-8", (err, data) => {
      if (err) {
        console.log(err);
        return;
      }
      object.columns.map((column) => {
        parseColumn(data, column);
      });
    });
  });
}

mapData(Data.no_trench);
mapData(Data.open_trench);

function parseColumn(data, colNumber) {
  let counter = 0;
  let max = 0;
  let min = 0;
  let minMaxSquare = 0;
  const parsedData = [];

  function findMinMaxSquare(parsedData, colNumber) {
    parsedData.map((el, idx) => {
      if (idx % colNumber === 0) {
        if (el > max) {
          max = el;
        }
        if (el < min) {
          min = el;
        }
      }
    });
    minMaxSquare = (max - min) ** 2;
    console.log("max: ", max);
    console.log("min: ", min);
    console.log("(max - min) ** 2: ", minMaxSquare);
  }

  data.split(" ").map((el) => {
    if (el !== "") {
      counter++;
      parsedData.push(el);
    }
  });
  console.log("items: ", counter);

  if (counter % 229 === 0) {
    console.log("no-trench");
    findMinMaxSquare(parsedData, colNumber);
  }
  if (counter % 257 === 0) {
    console.log("open-trench");
    findMinMaxSquare(parsedData, colNumber);
  }

  return parsedData;
}
