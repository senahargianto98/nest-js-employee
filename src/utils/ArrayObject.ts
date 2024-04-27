const removeDuplicatesByKey = (arr, key) => {
  const uniqueKeys = new Set();
  return arr.filter((obj) => {
    if (!uniqueKeys.has(obj[key])) {
      uniqueKeys.add(obj[key]);
      return true;
    }
    return false;
  });
};

const groupByCategory = (arr) => {
  return arr.reduce((result, obj) => {
    const category = obj.category;
    if (!result[category]) {
      result[category] = [];
    }
    result[category].push(obj);
    return result;
  });
};

const summaryByCetegory = (arr, category) => {
  return arr.reduce((summary, item) => {
    if (!summary[category]) {
      summary[category] = 0;
    }
    summary[category] += item[category];
    return summary;
  }, {});
};

export { removeDuplicatesByKey, groupByCategory, summaryByCetegory };
