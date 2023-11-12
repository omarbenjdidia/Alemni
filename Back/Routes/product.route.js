import express from "express";
import * as productController from '../Controllers/productController.js';
import multerConfig from '../Middleware/multer-config.js'; // Import your Multer configuration

const router = express.Router();

// Apply Multer middleware for the Addproduct route
router.post('/addproduct', multerConfig, productController.Addproduct);
router.get("/getproduct", productController.Getproduct);
router.delete("/deleteproduct/:productId", productController.Deleteproduct);
router.put("/modifyproduct/:productId", multerConfig, productController.Modifyproduct);

export default router;
