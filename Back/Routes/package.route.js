import express from "express";
import * as packageController from '../Controllers/packageController.js';

const router = express.Router();

// Apply Multer middleware for the Addproduct route
router.post('/addpackage', packageController.Addpackage);
router.get("/getpackage", packageController.Getpackage);
router.delete("/deletepackage/:packageId", packageController.Deletepackage);

export default router;
