const data = JSON.parse(process.argv.slice(2)[0]);
console.log({"name": data.dish.name, "isCheckedOut": data.isCheckedOut});
