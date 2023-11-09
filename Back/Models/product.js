import bodyParser from 'body-parser'
import express from 'express'
import mongoose from 'mongoose'
const app = express()
app.use(bodyParser.urlencoded({ extended: false}))
app.use(bodyParser.json())
const {Schema , model} = mongoose

const productSchema = mongoose.Schema(
    {
        title: {
            type: String,
            required: true,
        },
        description: {
            type:String,
            required : true,
        },
        pricing: {
            type : Number,
            required : true,
        },
        rating : {
            type: Number,
            required: true
        },
        duration:{
            type: String,
            required: true
        },
        number_of_episodes:{
            type: Number,
            required: true
        },
        image: {
            type : String,
            required: true
        },


    }, 
        {
            timestamps : true
        }    
)

export default model("product",productSchema)