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

let iterator = 0;
let minMaxSquareSrting = "";

mapData(Data.no_trench);
mapData(Data.open_trench);

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

function parseColumn(data, colNumber) {
  let max = 0;
  let min = 0;
  let minMaxSquare = 0;
  const parsedData = [];

  data.split(" ").map((el) => {
    if (el !== "") {
      parsedData.push(el);
    }
  });

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

    console.log(`minMaxSquare_${iterator}: `, minMaxSquare);
    iterator++;

    minMaxSquareSrting += `${minMaxSquare.toString()}\n`;
    fs.writeFile('minmaxSquares.txt', minMaxSquareSrting, function (err) {
      if (err) return console.log(err);
    });
    
    return minMaxSquare;
  }

  return findMinMaxSquare(parsedData, colNumber);
}
