start_dir = 'D:\Local\mapwarper-tools';
cd(start_dir); 
mw_mapnum = 793; % The mapwarper item number
j = 1;

% Gather secrets:
secrets = struct;
secrets.username = input('Enter mapwarper username (email): ','s');
secrets.password = input('Enter mapwarper password: ','s');
 
% Sign in 
to_auth = ['curl-7.69.1-win64-mingw\bin\curl -X POST http://mapwarper.lib.mcmaster.ca/api/v1/auth/sign_in.json -H "Content-Type: application/json" -d ''{"user":{"email":"' secrets.username '","password":"' secrets.password '"}}'' -v'];
results.to_auth= to_auth;
% Run the command:
[results.auth_status,results.auth_cmdout] = dos(to_auth);
% switch results.auth_status
%     case 0
%         disp(['GCP list for Map ' num2str(mw_mapnum) ' processed. /n API Response: ' results(j).cmdout]);
%     case 1
%         disp(['GCP list for Map ' num2str(mw_mapnum) ' - upload failed']);
% end

%%% Load the QGIS gcp file: 
[H, C] = read_mapwarper_list([start_dir '/gcp-tests/gcp-' num2str(mw_mapnum) '.csv'],',',1);

%%% Convert C from a cell array to a matrix
C2 = cellfun(@str2double,C);

%%% Rearrange order and convert to MapWarper-compliant format
% mapX,mapY,sourceX,sourceY(QGIS) --> x,y,lon,lat (MW); y has opposite sign
% to sourceY
% C_out = [C2(:,3) -1.*C2(:,4) C2(:,1) C2(:,2)];
% gcps.mapid = repmat(mw_mapnum,size(C2,1),1);
% gcps.x = C2(:,3);
% gcps.y = -1.*C2(:,4);
% gcps.lon = C(:,1);
% gcps.lat = C(:,2);

% json_out = jsonencode(gcps)

%%% Let's just try to write the json snippet
% e.g., {"gcps":[{"mapid":123,"x":2,"y":3,"lat":"52.56","lon":"-4.65"},{"mapid":123,"x":12,"y":23,"lat":"32.56","lon":"-2.65"}]}

json_out = '{"gcps":[';
for i = 1:1:size(C2,1)
json_out = [json_out '{"mapid":' num2str(mw_mapnum) ',"x":' num2str(C2(i,3)) ',"y":' num2str(-1.*C2(i,4)) ',"lat":"' C{i,2} '","lon":"' C{i,1} '"},'];
end
json_out = [json_out(1:end-1) ']}']; %Remove final trailing comma

% Build the full API string:
to_execute = ['curl-7.69.1-win64-mingw\bin\curl -H "Content-Type: application/json" -H "Accept: application/json" '...
    '-X POST -u ' secrets.username ':' secrets.password ' -d ''' json_out ''' http://mapwarper.lib.mcmaster.ca/api/v1/gcps/add_many -b cookie'];

to_execute = ['curl-7.69.1-win64-mingw\bin\curl -H "Content-Type: application/json" -H "Accept: application/json" '...
    '-X POST -d ''' json_out ''' http://mapwarper.lib.mcmaster.ca/api/v1/gcps/add_many -b cookie'];

results(j).execute = to_execute;
% Run the command:
[results(j).status,results(j).cmdout] = dos(to_execute);
switch results(j).status
    case 0
        disp(['GCP list for Map ' num2str(mw_mapnum) ' processed. API Response: ' results(j).cmdout]);
    case 1
        disp(['GCP list for Map ' num2str(mw_mapnum) ' - upload failed']);
end
