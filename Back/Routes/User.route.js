import express from "express";
import * as UserController from '../Controllers/userController.js'



const router = express.Router()





router.post('/signUp',UserController.SignUp)



router.post('/login',UserController.LogIn)


router.post("/send-confirmation-email", UserController.sendConfirmationEmail)

router.get("/confirmation/:token", UserController.confirmation)


router.post('/forgotPassword',UserController.forgotPassword)

//router.route('/updateUser').put(UserController.UpdateProfile)


router.post("/confirmationOtp",UserController.confirmationOTP)

router.put("/updatePassword",UserController.updatePassword)

router.post("/userProfil",UserController.userProfil)


export default router