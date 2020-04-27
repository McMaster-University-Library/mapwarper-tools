%% WW2_France_50k_GSGS4040
%%% Inputs (to change):
main_dir = 'D:\Local\mapwarper-tools'; % Location of the mapwarper-tools repo
series = 'WW2_France_50k_GSGS4040'; % Specify the name of the series (used for labeling files)
upload_list_url = 'https://docs.google.com/spreadsheets/d/1lv4QRQehMqNYLdj-htTJ9NXM_LPJi0DgDyHxeaAFH8I/edit#gid=31791550'; % Copy URL to specific sheet with mapwarper import strings
starting_item = 8; % usually 1 (to start at the first item and work the entire way through; might be higher if other items have already been ingested (through testing, perhaps).

% Run it
[results] = mapwarper_uploader(main_dir,series,upload_list_url, starting_item);
