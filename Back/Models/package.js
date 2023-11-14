import mongoose from 'mongoose';

const { Schema, model } = mongoose;

const packageSchema = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: true,
    },

    products: [
      {
        type: Schema.Types.ObjectId,
        ref: 'Product', // Reference to the Product model     
        },
    ],
  },
  {
    timestamps: true,
  }
);

const Package = model('package', packageSchema);

export default Package;
