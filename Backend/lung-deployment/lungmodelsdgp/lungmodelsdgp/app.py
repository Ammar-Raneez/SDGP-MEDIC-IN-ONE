import os
import logging
import tensorflow as tf
from .lungDiagModule import LungDiagModule

lungDiagModule = LungDiagModule()

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
SKIN_MODEL_PATH = os.path.join(scriptdir, 'lung_model.hdf5')


# upload image to firebase storage
def get_firebase_image(image_name, image_stream, firebase_storage, firebase):
    # storing the image from local path to the firebase cloud storage
    firebase_storage.child("skin-image-uploads/" + image_name).put(image_stream)
    
    # get the downloadable url and return it
    auth = firebase.auth()
    email = "onconashml@gmail.com"
    password = "onconashml12345"
    user = auth.sign_in_with_email_and_password(email, password)
    url = firebase_storage.child(image_name).get_url(user["idToken"])
    return url

def construct_skin_output(prediction):
    INDEX_TO_TYPE = {
        0: 'Melanocytic nevi',
        1: 'Melanoma',
        2: 'Benign keratosis-like lesions ',
        3: 'Basal cell carcinoma',
        4: 'Actinic keratoses',
        5: 'Vascular lesions',
        6: 'Dermatofibroma'
    }
        
    result_string = ""
    for i in range(len(prediction.flat)):
        result_string += str(round(prediction.flat[i], 2)) + f"% {INDEX_TO_TYPE[i]} \n"
    return result_string

def model_predict(image_array, model):
    if model == "skin":
        skin_model = tf.keras.models.load_model(SKIN_MODEL_PATH)
        predictions = skinDiagModule.model_predict_skin(image_array, skin_model)
        return construct_skin_output(predictions)
    elif model == "breast":
        return "breast"
    return "lung"

def upload(image_array, which_model):        
    prediction = model_predict(image_array, which_model)
    return prediction