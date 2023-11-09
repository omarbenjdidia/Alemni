import productModel from '../Models/product.js';

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
    // Get Product Input
    const {
      title,
      description,
      pricing,
      rating,
      duration,
      number_of_episodes,
      image,
    } = req.body;

    // Checking the existence of the product
    const existingProduct = await productModel.findOne({ title });

    if (existingProduct) {
      return res.status(403).send({
        message: 'Product already exists!',
      });
    } else {
      // Create product in our database
      const Product = await productModel.create({
        title,
        description,
        pricing,
        rating,
        duration,
        number_of_episodes,
        image,
      });
      return res.status(200).send({
        message: 'Product created!',
      });
    }
  } catch (err) {
    console.log(err);
    res.status(500).send({
      message: 'Internal Server Error',
    });
  }
}

export async function Deleteproduct(req, res) {
  console.log('Deleteproduct function is called');
  try {
    const { title } = req.params; // Extract title from request parameters

    // Checking the existence of the product
    const existingProduct = await productModel.findOneAndDelete({ title });

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
    const { title } = req.params; // Extract title from request parameters
    const updatedData = req.body; // Updated data from the request body

    // Update the product in the database
    const updatedProduct = await productModel.findOneAndUpdate({ title }, updatedData, { new: true });

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

