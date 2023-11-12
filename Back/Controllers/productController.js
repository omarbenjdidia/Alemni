import productModel from '../Models/product.js';
import mongoose from 'mongoose';
import multer from 'multer';

// Configure multer for handling file uploads
const storage = multer.memoryStorage();
const upload = multer({ storage: storage }).fields([
  { name: 'image', maxCount: 1 },
  { name: 'pdf', maxCount: 1 },
]);

export async function Getproduct(req, res) {
  console.log('Getproduct function is called');
  try {
    // Fetch all products from the database
    const products = await productModel.find();

    return res.status(200).send({
      products,
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}

export async function Addproduct(req, res) {
  console.log('Addproduct function is called');
  try {
    // Get Product Input after Multer has processed the form data
    const { title, description, pricing, duration } = req.body;

    // Log the product data
    console.log('Product Data:', { title, description, pricing, duration });

    // Get file data from Multer
    const image = req.files['image'] ? req.files['image'][0] : null;
    const pdf = req.files['pdf'] ? req.files['pdf'][0] : null;

    // Log the received files
    console.log('Received Files:', req.files);

    // Log file details
    console.log('Image:', image);
    console.log('PDF:', pdf);

    // Create product in our database
    const Product = await productModel.create({
      title,
      description,
      pricing,
      duration,
      image: image
        ? {
            data: image.buffer,
            contentType: image.mimetype,
          }
        : null,
      pdf: pdf
        ? {
            data: pdf.buffer,
            contentType: pdf.mimetype,
          }
        : null,
    });

    return res.status(200).send({
      message: 'Product created!',
    });
  } catch (err) {
    console.log('Addproduct Error:', err); // Log other errors
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}






export async function Deleteproduct(req, res) {
  console.log('Deleteproduct function is called');
  try {
    const { productId } = req.params; // Extract productId from request parameters

    // Checking the existence of the product
    const existingProduct = await productModel.findByIdAndDelete(productId);

    if (!existingProduct) {
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

export async function Modifyproduct(req, res) {
  console.log('Modifyproduct function is called');
  try {
    const { productId } = req.params; // Extract productId from request parameters
    const updatedData = req.body; // Updated data from the request body

    // Check if productId is a valid ObjectId
    if (!mongoose.Types.ObjectId.isValid(productId)) {
      return res.status(400).send({
        message: 'Invalid productId format',
      });
    }

    // Get file data from Multer
    const image = req.files['image'] ? req.files['image'][0] : null;
    const pdf = req.files['pdf'] ? req.files['pdf'][0] : null;

    // Log the received files
    console.log('Received Files:', req.files);

    // Log file details
    console.log('Image:', image);
    console.log('PDF:', pdf);

    // Update the product in the database
    const updatedProduct = await productModel.findByIdAndUpdate(
      productId,
      {
        ...updatedData,
        image: image
          ? {
              data: image.buffer,
              contentType: image.mimetype,
            }
          : null,
        pdf: pdf
          ? {
              data: pdf.buffer,
              contentType: pdf.mimetype,
            }
          : null,
      },
      { new: true }
    );

    if (!updatedProduct) {
      return res.status(404).send({
        message: 'Product not found!',
      });
    }

    return res.status(200).send({
      message: 'Product modified!',
    });
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}


