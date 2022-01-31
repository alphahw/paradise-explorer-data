import fs from 'fs';
import cleanCsv from './cleanCsv.mjs';

const inputPath = process.argv[2];

if (!inputPath.length) {
  console.error('Input path not specified, please check your command')
  process.exit(1);
}

console.log(`Running CSV clean for '${inputPath}'`);

fs.readdir(inputPath, {withFileTypes: true}, (err, files) => {
  if (err) {
    console.error(err)
    process.exit(1);
  }

  files.filter(
    item => !item.isDirectory()
  ).forEach(file => {
    cleanCsv(inputPath, file.name)
  });
})
