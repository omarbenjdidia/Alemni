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

    image: {
      data: Buffer,
      contentType: String, // Fix: Use String instead of FormData
    },
  },
  {
    timestamps: true,
  }
);

const Package = model('package', packageSchema);

export default Package;
