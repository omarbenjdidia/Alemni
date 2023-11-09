import express from "express";
import * as productController from '../Controllers/productController.js';

const router = express.Router();

router.post('/addproduct', productController.Addproduct);
router.get("/getproduct", productController.Getproduct);
router.delete("/deleteproduct/:title", productController.Deleteproduct);
router.put("/modifyproduct/:title", productController.Modifyproduct);

export default router;
