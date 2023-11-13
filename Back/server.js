import express from 'express';
import mongoose from 'mongoose';
import morgan from 'morgan';
import cors from 'cors';
import multer from 'multer'; // Import Multer
import UserRoute from './Routes/User.route.js';
import productRoute from './Routes/product.route.js';
import packageRoute from './Routes/package.route.js';
import swaggerJSDoc from 'swagger-jsdoc';
import swaggerUi from 'swagger-ui-express';
import './auth/auth.js';

const app = express();

const database = "aalmni";
const port = process.env.PORT || 3000;
const hostname = '192.168.1.16';

import * as dotenv from 'dotenv';
dotenv.config();

app.use(express.json());

mongoose.set('debug', true);
mongoose.Promise = global.Promise;
mongoose
    .connect(`mongodb://127.0.0.1:27017/${database}`)
    .then(() => {
        console.log(`connected to  ${database}`);
    })
    .catch(err => {
        console.log(err);
    });

app.use(cors(
    {
        origin: "*"
    }
));

const options = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'AALMNI',
            version: '1.0.0'
        },
        servers: [
            {
                url: 'http://localhost:3000/'
            }
        ]
    },
    apis: ['./Routes/User.route.js', './Routes/product.route.js','./Routes/package.route.js' ],
}

const swaggerSpec = swaggerJSDoc(options);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// Configure Multer
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });



app.use("/user", UserRoute);
app.use("/product", productRoute);
app.use("/package", packageRoute);


// Pour les images
app.use(express.urlencoded({ extended: true }));

app.listen(port, hostname, () => {
    console.log(`Server running at https://${hostname}:${port}/`);
});
