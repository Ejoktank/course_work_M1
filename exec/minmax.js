const fs = require("fs");

const Data = {
  no_trench: {
    files: [
      ["../hs/no-trench/coarse-mesh/01_su_euler_1.txt", "x"],
      ["../hs/no-trench/coarse-mesh/01_su_euler_2.txt", "y"],
      ["../hs/no-trench/coarse-mesh/01_su_euler_3.txt", "z"],
    ],
    columns: [50, 51, 52, 53, 54, 55, 56, 57],
  },
  open_trench: {
    files: [
      ["../hs/open-trench/coarse-mesh/01_su_euler_1.txt", "x"],
      ["../hs/open-trench/coarse-mesh/01_su_euler_2.txt", "y"],
      ["../hs/open-trench/coarse-mesh/01_su_euler_3.txt", "z"],
    ],
    columns: [54, 55, 56, 57, 58, 59, 60, 61],
  },
};

Promise.all([
  mapData(Data.no_trench),
  mapData(Data.open_trench),
]).then(([points1, points2]) => {
  console.log("no_trench", points1);
  console.log("open_trench", points2);

  const res = [];
  for (let i = 0; i < points1.length; ++i) {
    const p1 = points1[i];
    const p2 = points2[i];

    const a = Math.sqrt(p1.x + p1.y + p1.z);
    const b = Math.sqrt(p2.x + p2.y + p2.z);

    res.push(b / a);
  }

  const resString = res.toString().split(",").join("\n");

  fs.writeFile("Afr.txt", resString, function (err) {
    if (err) return console.log(err);
  });

  console.log(res);
});

function mapData(object) {
  return new Promise((res) => {
    const points = object.columns.map(() => {
      return {};
    });
    const processed = {
      x: false,
      y: false,
      z: false,
    };

    return object.files.map(([path, coord]) => {
      fs.readFile(path, "utf-8", (err, data) => {
        if (err) {
          return console.error(err);
        }
        const parsedData = data.split(" ").filter((e) => e);
        const minMaxes = parseColumns(parsedData, object.columns);

        let i = 0;
        for (const e of minMaxes) {
          points[i][coord] = e;
          ++i;
        }

        processed[coord] = true;

        if (Object.values(processed).reduce((a, e) => e && a, true)) {
          res(points);
        }
      });
    });
  });
}

function parseColumns(data, columns) {
  function findMinMaxSquare(parsedData, colNumber) {
    const [max, min] = parsedData.reduce(
      ([max, min], el, idx) => {
        if (idx % colNumber === 0) {
          if (el > max) {
            max = el;
          }
          if (el < min) {
            min = el;
          }
        }
        return [max, min];
      },
      [Number.MIN_VALUE, Number.MAX_VALUE]
    );

    const minMaxSquare = (max - min) ** 2;
    return minMaxSquare;
  }

  const minMaxes = columns.map((e) => findMinMaxSquare(data, e));

  return minMaxes;
}
