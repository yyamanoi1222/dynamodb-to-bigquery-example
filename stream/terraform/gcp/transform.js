function main(line) {
  var obj = JSON.parse(line)
  var PK = obj.dynamodb.Keys.PK.S
  var SK = obj.dynamodb.Keys.SK.S
  return JSON.stringify({
    PK: PK,
    SK: SK
  });
}
