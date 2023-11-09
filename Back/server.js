import express from 'express'
import mongoose from 'mongoose'
import morgan from 'morgan'
import cors from 'cors'
import UserRoute from './Routes/User.route.js'
import productRoute from './Routes/product.route.js'
import swaggerJSDoc from 'swagger-jsdoc'
import swaggerUi from 'swagger-ui-express'
import './auth/auth.js'
const app = express()

const database = "aalmni" 
const port = process.env.port || 3000
const hostname = '127.0.0.1'


import * as dotenv from 'dotenv' ;
dotenv.config()


app.use(express.json())


mongoose.set('debug', true)
mongoose.Promise = global.Promise
mongoose
    .connect(`mongodb://localhost:27017/${database}`)
    .then(() => {
        console.log(`connected to  ${database}`)
    })
    .catch(err => {
        console.log(err)
    })


app.use(cors(
    {
        origin: "*"
    }
))

const options={
    definition:{
        openapi:'3.0.0',
        info : {
            title:'AALMNI',
            version:'1.0.0'
        },
        servers:[
            {
               url: 'http://localhost:3000/'
            }
        ]
    },
    apis: ['./Routes/User.route.js', './Routes/product.route.js'],
    }
    
    const swaggerSpec=swaggerJSDoc(options)
    app.use('/api-docs',swaggerUi.serve,swaggerUi.setup(swaggerSpec))




app.use("/user", UserRoute)
app.use("/product", productRoute)


//Pour les images
app.use(express.urlencoded({ extended: true }))

app.listen(port, hostname, () => {
    console.log(`Server running at https://${hostname}:${port}/`);
});


