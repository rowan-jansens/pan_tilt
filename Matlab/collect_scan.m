

arduino = serialport("COM6", 115200);
configureTerminator(arduino,"LF");



num_data_points = 4000;

%set up data struct to read
arduino.UserData = struct("Data",zeros(num_data_points,3),"Count",1, "Points", num_data_points, "Running", true);

configureCallback(arduino,"terminator", @read_data);



flush(arduino);



function read_data(src, ~)

% Read the ASCII data from the serialport object.
data = readline(src);
data = split(data, ",");
data = str2double(data);

%Convert the string data to numeric type and save it in the UserData
%property of the serialport object.
src.UserData.Data(src.UserData.Count,:) = data';

% Update the Count value of the serialport object.
src.UserData.Count = src.UserData.Count + 1;


disp(data');
end
