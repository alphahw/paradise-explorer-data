import fs from 'fs';
import readline from 'readline';

const BREAKING_PATTERN = /\\"$/;

const cleanCsv = (filePath, fileName) => {
  const brokenLines = [];
  let lineCount = 0;

  const fd = fs.openSync(`./csv-out/${fileName}`, 'a');

  const rd = readline.createInterface({
    input: fs.createReadStream(filePath + fileName),
    output: false,
    // output: process.stdout,
    terminal: false
  });

  let fileDataType = fileName.split('.');
  fileDataType = fileDataType[fileDataType.length - 2];
  fileDataType = fileDataType.charAt(0).toUpperCase() + fileDataType.slice(1);

  rd.on('line', (line) => {
    lineCount += 1;
    let isBrokenLine = false;

    let processedLine = line.split(',').map((val, i) => {
      if (val.match(BREAKING_PATTERN)) {
        isBrokenLine = true;
      }
      if (lineCount < 2) {
        return (val
          .replaceAll('"', '')
          .replace("START_ID", ":START_ID")
          .replace("TYPE", ":TYPE")
          .replace("END_ID", ":END_ID")
          .replace("node_id", "node_id:ID")
        );
      } else {
        return val.replace(BREAKING_PATTERN, '"')
      }
    }).join(",");

    if (fileDataType != 'Edges') {
      if (lineCount < 2) {
        processedLine = processedLine + ',:LABEL'
      } else {
        processedLine = processedLine + `,"${fileDataType}"`
      }
    }

    if (isBrokenLine) {
      brokenLines.push(line)
    }
    
    let lineOutput = lineCount < 2 ? processedLine : `\n${processedLine}`
    fs.appendFileSync(fd, lineOutput, 'utf-8');
  });

  rd.on('close', () => {
    if (fd !== undefined) {
      fs.closeSync(fd);
    }

    console.log(`Processed ${lineCount} lines from '${filePath + fileName}'`)

    if (brokenLines.length) {
      console.log(`Found & fixed errors for lines:\n${brokenLines.join('\n')}`)
    }
  });
}

export default cleanCsv;
