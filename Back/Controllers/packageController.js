import productModel from '../Models/package.js';
import multer from 'multer';

// Configure multer for handling file uploads
const storage = multer.memoryStorage();

export async function Getpackage(req, res) {
  console.log('Getpackage function is called');
  try {
    // Fetch all products from the database
    const packages = await productModel.find();

    return res.status(200).send({
      packages,
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}

export async function Addpackage(req, res) {
  console.log('Addpackage function is called');
  try {
    // Get Product Input after Multer has processed the form data
    const { title, description, products } = req.body;

    // Log the package data
    console.log('Package Data:', { title, description, products });


    // Log the received files
    console.log('Received Files:', req.files);

    // Log file details

    // Create package in our database
    const packageId = await productModel.create({
      title,
      description,

      products: products, // Assuming products is an array of product IDs
    });

    return res.status(200).send({
      message: 'Package created!',
    });
  } catch (err) {
    console.log('Addpackage Error:', err); // Log other errors
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}



export async function Deletepackage(req, res) {
  console.log('Deletepackage function is called');
  try {
    const { packageId } = req.params; // Extract productId from request parameters

    // Checking the existence of the product
    const existingPackage = await productModel.findByIdAndDelete(packageId);

    if (!existingPackage) {
      return res.status(404).send({
        message: 'Product not found!',
      });
    }

    return res.status(200).send({
      message: 'Product deleted!',
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}
