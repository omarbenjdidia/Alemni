import multer, { diskStorage } from "multer";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import fs from "fs";

const MIME_TYPES = {
    "image/jpg": "jpg",
    "image/jpeg": "jpg",
    "image/png": "png",
    "application/pdf": "pdf",
};

const currentFileUrl = import.meta.url;
const currentFilePath = fileURLToPath(currentFileUrl);
const currentDir = dirname(currentFilePath);

const destinationPath = join(currentDir, "../public/carIcons");

// Create the destination directory if it doesn't exist
try {
    fs.accessSync(destinationPath);
} catch (error) {
    fs.mkdirSync(destinationPath, { recursive: true });
}

const storage = diskStorage({
    destination: (req, file, callback) => {
        callback(null, destinationPath);
    },
    filename: (req, file, callback) => {
        const name = file.originalname.split(" ").join("");
        const extension = MIME_TYPES[file.mimetype] || "unknown";
        callback(null, name + Date.now() + "." + extension);
    },
});

const fileFilter = (req, file, callback) => {
    const allowedMimes = ['image/jpeg', 'image/jpg', 'image/png', 'application/pdf'];

    if (allowedMimes.includes(file.mimetype)) {
        console.log('File accepted. Mimetype:', file.mimetype);
        callback(null, true);
    } else {
        console.error('File rejected. Invalid type. Mimetype:', file.mimetype);
        callback(new Error('Invalid file type. Only JPEG, JPG, PNG, and PDF are allowed.'));
    }
};

export default multer({
    storage: storage,
    fileFilter: fileFilter,
}).fields([
    { name: "image", maxCount: 1 },
    { name: "pdf", maxCount: 1 },
]);