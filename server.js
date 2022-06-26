const express = require('express')
const app = express()
const HTTP_PORT = 3000
app.use('/', (req, res) => {
    res.send('Hello world')
})

const signals = ['SIGHUP','SIGINT', 'SIGTERM', 'SIGQUIT']

signals.forEach(signal => process.on(signal, (receivedSignal) => {
    exitHanlder( receivedSignal)
}))

app.listen(HTTP_PORT, (err) => {
    if(err) {
        console.log('Error occured - ', err)
    } else {
        console.log('Server started listening on port ', HTTP_PORT)
    }
})


function exitHanlder (signal) {
    console.log(`Server will shudown for ${signal} in a few seconds ...`);
    setTimeout(()=> {
        console.log(`Server completed shudown, gracefully!`);
        process.exit();
    }, 2000)
}