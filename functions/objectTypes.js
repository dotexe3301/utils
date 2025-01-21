function objectTypes(payload) {
  let store = {};

  for (const key in payload) {
    const currType = typeof payload[key];
    if (currType === "object") {
      const recursiveObjectTypes = objectTypes(payload[key]);
      store[key] = recursiveObjectTypes;
    } else {
      store[key] = currType;
    }
  }

  return store;
}

// Some mockup data to test
// const complexObject = {
//   data: [
//     {
//       type: [12, 12],
//       value: {
//         key2: {
//           deepKey: "deepValue",
//           deepArray: [10, 20, true],
//         },
//       },
//     },
//   ],
//   advancedData: {
//     specialCharacters: '!@#$%^&*()_+{}|:"<>?',
//     uniqueID: Symbol("unique"),
//     largeNumber: BigInt("9007199254740991"),
//   },
//   actions: [
//     {
//       id: 2,
//       name: "Action 2",
//       execute: () => console.log("Action 2 executed"),
//     },
//   ],
//   nullValue: null,
//   undefinedValue: undefined,
//   nestedComplexity: {
//     multiLevel: {
//       level1: {
//         level2: {
//           level3: {
//             array: [1, 2, { deepObject: { key: "value" } }],
//           },
//         },
//       },
//     },
//   },
// };

// using below to get whole output as terminal did not show nested types
// console.dir(objectTypes(complexObject), { depth: null, colors: true });

module.exports = objectTypes;
