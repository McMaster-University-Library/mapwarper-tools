function [results] = mapwarper_uploader(main_dir,series,upload_list_url, starting_item, items_to_process, secrets)
%  **main_dir**: location of the cloned mapwarper-tools repo
%  **series**: The name for the series (e.g. use the same label as was used for the Google Sheet tab).
%  **upload_list_url**: The full url of the appropriate tab in the MapWarper Importer Prep Google Sheet
%  **starting_item**: Make this equal to 1 unless you know that you need something else. This entry is optional.
%  **items_to_process**: Allows the user to specify how many records are processed in a given run. This is good for splitting up ingestion of large sets over time. Note that doing so requires updating the value of **starting_item** to be equal to starting_item + items_to_process. This entry is optional, and the default is to process all files. 
if nargin < 6
%%% Load the secrets file (with password information)
% load([main_dir '/secrets.mat']);
%%% Update -- collect from user
secrets = struct;
secrets.username = input('Enter mapwarper username (email): ','s');
secrets.password = input('Enter mapwarper password: ','s');
   
end

if nargin<5
    items_to_process = 100000;
end
if nargin<4
    starting_item = 1;
end

%%% All the rest (stays the same)
cd(main_dir)
strrep(main_dir,'\','/');
if strcmp(main_dir(end),'/')==1
    main_dir = main_dir(1:end-1);
end


%%% Download GSheet; save as tsv
ind_gid = strfind(upload_list_url,'/edit#gid');
gid_no = upload_list_url(ind_gid+6:end);
dl_url = [upload_list_url(1:ind_gid) 'export?format=tsv&' gid_no ];
options = weboptions; options.Timeout = 30; 

websave([series '.tsv'],dl_url, options);

%%% Read the tsv into a Cell array
[H, C] = read_mapwarper_list([series '.tsv'],'\t',2);
items_to_process = min([items_to_process; size(C,1)+1-starting_item],[],1);

%%% These are webwrite options that are not currently working
options_post = weboptions('Timeout',100,'Username',secrets.username, ...
    'Password',secrets.password,'RequestMethod','post',...
    'MediaType','auto','HeaderFields',{'ContentType' 'application/json'}); 
api_path = 'http://mapwarper.lib.mcmaster.ca/api/v1/maps';

results = struct;
%%% Loop through all sheets, upload using curl (included in repository)
for i = starting_item:1:starting_item+items_to_process-1 %first 7 already ingested during tests.
    data = C{i,18};
    data = strrep(data,'"','\"');
    data = strrep(data,'&','and'); % Added 2021-04-05 by JJB
    
    
    
    %%% New section to replace diacritics with unaccented [JJB 2021-06-18]
    stracc =        {'à';'á';'â';'ã';'ä';'å';'À';'Á';'Â';'Ã';'Ä';'Å';'Æ' ;'æ' ;'ç';'Ç';'è';'é';'ê';'ë';'È';'É';'Ê';'Ë';'ì';'í';'î';'ï';'ò';'ó';'ô';'õ';'ö';'Ò';'Ó';'Ô';'Õ';'Ö';'ù';'ú';'û';'ü';'Ù';'Ú';'Û';'Ü';'ý';'ÿ';'Ý'};
    strreplace =        {'a';'a';'a';'a';'a';'a';'A';'A';'A';'A';'A';'A';'Ae';'ae';'c';'C';'e';'e';'e';'e';'E';'E';'E';'E';'i';'i';'i';'i';'o';'o';'o';'o';'o';'O';'O';'O';'O';'O';'u';'u';'u';'u';'U';'U';'U';'U';'y';'y';'Y'};
    for j = 1:1:length(stracc)
        data = strrep(data,stracc{j}, strreplace{j});
    end
    %%%
    
    % Build the string:
    to_execute = ['curl-7.69.1-win64-mingw\bin\curl -H "Content-Type: application/json" -H "Accept: application/json" '...
        '-X POST -u ' secrets.username ':' secrets.password ' -d "' data '" http://mapwarper.lib.mcmaster.ca/api/v1/maps -b cookie'];
    results(i).execute = to_execute;
    % Run the command:
    [results(i).status,results(i).cmdout] = dos(to_execute);
    switch results(i).status
        case 0
            disp([C{i,4} ' processed. API Response: ' results(i).cmdout]);
        case 1
            disp([C{i,4} ' - upload failed']);
    end
    pause(10);
    %%% Perform a POST
    % response = webwrite(api_path,data,options_post);
end
