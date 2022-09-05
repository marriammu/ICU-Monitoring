
from flask import Flask, jsonify, request
from flask_cors import CORS
DataArray=[]
toggle=1
app = Flask(__name__)
CORS(app)
@app.route('/SensorsData', methods=['POST'])
def Data():
    request_data = request.get_json()
    print(request_data)
    global Temp , Hum
    Temp=(request_data['Temperature'])
    Temp = int(float(Temp))
    Hum=(request_data['Humidity'])
    Hum = int(float(Hum))
    SensorData = {"Temperature": Temp , "Humidity" : Hum } 
    if toggle == 1 :  
        DataArray.append(SensorData)
    print("temperature")
    print(Temp)
    print("humidity")
    print(Hum)
    return jsonify(Temp , Hum)

@app.route('/SensorsData', methods=['GET'])
def GetData():
    print(len(DataArray))
    return (jsonify(DataArray))
@app.route('/Toggle', methods=['POST'])
def Toggle():
    global toggle     
    toggle=1-toggle
    print (toggle)
    return ('Toggle Done')
if __name__ == "__main__":
    app.run(host="*********", port=3000, debug=True)