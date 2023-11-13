import productModel from '../Models/package.js';
import multer from 'multer';

// Configure multer for handling file uploads
const storage = multer.memoryStorage();
const upload = multer({ storage: storage }).fields([
  { name: 'image', maxCount: 1 },
]);

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
    const { title, description } = req.body;

    // Log the product data
    console.log('Package Data:', { title, description });

    // Get file data from Multer
    const image = req.files['image'] ? req.files['image'][0] : null;

    // Log the received files
    console.log('Received Files:', req.files);

    // Log file details
    console.log('Image:', image);

    // Create product in our database
    const Package = await productModel.create({
      title,
      description,
      image: image
        ? {
            data: image.buffer,
            contentType: image.mimetype,
          }
        : null,
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




