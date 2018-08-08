var packageInfo = require("./package.json");
var fs = require('fs')
var write = fs.createWriteStream
var pack = require('tar-pack').pack
var archivePath = 'E:/archive/GZB_ACS/GZB_ACS_V' + packageInfo.version
var updateShellName = 'update.sh'

if(!fs.existsSync(archivePath)){
  fs.mkdirSync(archivePath)
}
pack(process.cwd(), {fromBase:true})
  .pipe(write( archivePath + '/GZB_ACS.tar.gz'))
  .on('error', function (err) {
    console.error(err.stack)
  })
  .on('close', function () {
    fs.writeFileSync(archivePath+'/'+updateShellName, fs.readFileSync('./bin/'+updateShellName));
    fs.writeFileSync(archivePath+'/readme.md', fs.readFileSync('./config/readme.md'));
    console.log('done')
  })