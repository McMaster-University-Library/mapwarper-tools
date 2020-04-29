# mapwarper-tools

## Resoureces used or referenced in this guide
- [Digital Archive - Bulk Metadata Templates Google Sheet](https://docs.google.com/spreadsheets/d/1xmSuWdqUQ0a9RNCi2DErNO1bBcK6J06ps0moyYkg4Qk/edit#gid=1991707764)
- [MapWarper Importer Prep Google Sheet](https://docs.google.com/spreadsheets/d/1lv4QRQehMqNYLdj-htTJ9NXM_LPJi0DgDyHxeaAFH8I/edit#gid=191875180)
- [Digital Archive - Item Inventory Generator](https://docs.google.com/spreadsheets/d/14NTOutHExIA70Kxr62Wm6CeC8pLv1VXz87YWgZFDOJQ/edit#gid=0)
- [Aerial Photo Index Master Spreadsheet](https://docs.google.com/spreadsheets/d/180qQStP5EkeY_3a4eM5lXcDYv3QY4zFq4l5bx3BZ8m0/edit#gid=0)

## Preparing a new set for Mapwarper ingestion
- Open the [Import Template tab](https://docs.google.com/spreadsheets/d/1lv4QRQehMqNYLdj-htTJ9NXM_LPJi0DgDyHxeaAFH8I/edit#gid=191875180) of the *MapWarper Importer Prep* Google Sheet. 
- Right click > Duplicate this sheet to a new tab. Name the sheet according to the series to be ingested (e.g. use the identifier prefix that's used in the digital archive).
- For all green-highlighted columns, populate the sheet with the relevant information (either from the [Digital Archive - Bulk Metadata Templates Google Sheet](https://docs.google.com/spreadsheets/d/1xmSuWdqUQ0a9RNCi2DErNO1bBcK6J06ps0moyYkg4Qk/edit#gid=1991707764), the [Aerial Photo Index Master Spreadsheet](https://docs.google.com/spreadsheets/d/180qQStP5EkeY_3a4eM5lXcDYv3QY4zFq4l5bx3BZ8m0/edit#gid=0), etc.). 
  - The second row provides guidance for the field--specifically, the field name in the [Digital Archive - Bulk Metadata Templates Google Sheet](https://docs.google.com/spreadsheets/d/1xmSuWdqUQ0a9RNCi2DErNO1bBcK6J06ps0moyYkg4Qk/edit#gid=1991707764). If populating from another source, use your discretion to deternine the most appropriate field
  - The **"map_type"** column is conditionally formatted to be one of the three allowed values
  - For the **tag_list** column, enter at least one tag for the type ('topo map', 'aerial photo'), and then enter a tag for the series (e.g. use the same tag as used for the new spreadsheet tab that you've created). Separate entries with a comma.
- There are four yellow-highlighted columns -- do not edit these columns, as they are automatically generated. All you need to do is drag down the formulas for each column to match the number of rows of data. Each of these columns is populated as such:
  - The **macrepo number** column is generated using a lookup table that lives in the *Lookup (DO NOT EDIT)* tab of the sheet. Do not edit this sheet, as it is populated automatically from the [Digital Archive - Item Inventory Generator Google Sheet](https://docs.google.com/spreadsheets/d/14NTOutHExIA70Kxr62Wm6CeC8pLv1VXz87YWgZFDOJQ/edit#gid=0).
  - The **source_uri** column is the URL to the item in the Digital Archive. It is generated from the macrepo number. 
    - e.g. ```https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89224```
  - The **upload_url** column is the URL to the TIFF file for the item in the Digital Archive. It is generated from the macrepo number. 
    - e.g. ```https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89224/datastream/OBJ/macrepo%3A89224.tiff```
  - The **import string** column is built by concatenating all of the values from the other columns. A macrepo number is required for this cell to read something other than #N/A. Otherwise, it is tolerant to other empty fields.

## Ingesting a new set into Mapwarper
- Create a new entry for the series in the **run_mapwarper_uploader.m** script. Add information for: 
  - **main_dir**: location of the cloned mapwarper-tools repo
  - **series**: The name for the series (e.g. use the same label as was used for the Google Sheet tab).
  - **upload_list_url**: The full url of the appropriate tab in the MapWarper Importer Prep Google Sheet
  - **starting_item**: Make this equal to 1 unless you know that you need something else. This entry is optional.
- The **run_mapwarper_uploader.m** script runs the **mapwarper_uploader.m** function, which:
  - downloads a copy of the Google Sheet tab in tsv (tab-separated) format. 
  - reads the tsv file
  - one by one, uses the import string with cURL (through a DOS command) to upload the files to MapWarper.

## Reference:

### How to update DA inventory to ensure that uris resolve correctly (and macrepo lookup works)
- retrieve DA inventory using [this example](https://github.com/jasonbrodeur/Fedora-SPARQL/blob/master/fedora-sparql-cookbook.md#example-4b-list-all-images-within-the-map-collection-of-the-digital-archive---no-title-no-parent)
- Paste results into the [Inventory GSheet](https://docs.google.com/spreadsheets/d/14NTOutHExIA70Kxr62Wm6CeC8pLv1VXz87YWgZFDOJQ/edit#gid=0)
- after pasting, sort by column D and remove any rows with content in them (not ours)
- The rest should auto-generate. Might need to copy and paste all formulas once more
- Check the **Lookup Table (Derived)** tab to ensure that everything looks ok.
- The results will automatically populate the [**Lookup (Do Not Edit)**](https://docs.google.com/spreadsheets/d/1lv4QRQehMqNYLdj-htTJ9NXM_LPJi0DgDyHxeaAFH8I/edit#gid=1196750630) sheet in the **MapWarper Importer Prep** spreadsheet.

### API documentation
[API documentation](https://github.com/timwaters/mapwarper/blob/master/README_API.md#maps)

### Notes on mapwarper API json format:
```http://mapwarper.lib.mcmaster.ca/api/v1/maps/17.json```
returns the following output: 

```
{"data":{"id":"17","type":"maps","attributes":{"title":"Fukuoka","description":"US AMS series L902. Prepared from aerial photography dated October, 1945. Relief shown by contour lines and spot heights. Inset in top left shows 1:50,000 view of Fukuoka, 21 x 25 cm. Held in the Lloyd Reeds Map Collection, call no. G 7960 s12 MC54E","width":23671,"height":20430,"status":"warped","mask_status":"unmasked","created_at":"2020-04-22T20:31:52.543Z","updated_at":"2020-04-24T00:18:14.057Z","bbox":"130.3257795,33.5553111,130.46231,33.6558971","map_type":"is_map","source_uri":"https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89267","unique_id":"WW2_CityPlans_Japan_Fukuoka_1946","date_depicted":"1946"},"relationships":{"layers":{"data":[]},"added_by":{"data":{"id":"3","type":"users"}}},"links":{"self":"http://localhost:3000/api/v1/maps/17","gcps_csv":"http://localhost:3000/maps/17/gcps.csv","mask":"http://localhost:3000/mapimages/17.gml.ol","geotiff":"http://localhost:3000/maps/17/export.tif","png":"http://localhost:3000/maps/17/export.png","aux_xml":"http://localhost:3000/maps/17/export.aux_xml","kml":"http://localhost:3000/maps/17.kml","tiles":"http://localhost:3000/maps/tile/17/{z}/{x}/{y}.png","wms":"http://localhost:3000/maps/wms/17?request=GetCapabilities\u0026service=WMS\u0026version=1.1.1","thumb":"/uploads/17/thumb/macrepo_3A89267_dhjrksxc.png"}}}
```

or formatted more nicely: 

```
{
    "data": {
        "id": "17",
        "type": "maps",
        "attributes": {
            "title": "Fukuoka",
            "description": "US AMS series L902. Prepared from aerial photography dated October, 1945. Relief shown by contour lines and spot heights. Inset in top left shows 1:50,000 view of Fukuoka, 21 x 25 cm. Held in the Lloyd Reeds Map Collection, call no. G 7960 s12 MC54E",
            "width": 23671,
            "height": 20430,
            "status": "warped",
            "mask_status": "unmasked",
            "created_at": "2020-04-22T20:31:52.543Z",
            "updated_at": "2020-04-24T00:18:14.057Z",
            "bbox": "130.3257795,33.5553111,130.46231,33.6558971",
            "map_type": "is_map",
            "source_uri": "https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89267",
            "unique_id": "WW2_CityPlans_Japan_Fukuoka_1946",
            "date_depicted": "1946"
        },
        "relationships": {
            "layers": {
                "data": []
            },
            "added_by": {
                "data": {
                    "id": "3",
                    "type": "users"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/api/v1/maps/17",
            "gcps_csv": "http://localhost:3000/maps/17/gcps.csv",
            "mask": "http://localhost:3000/mapimages/17.gml.ol",
            "geotiff": "http://localhost:3000/maps/17/export.tif",
            "png": "http://localhost:3000/maps/17/export.png",
            "aux_xml": "http://localhost:3000/maps/17/export.aux_xml",
            "kml": "http://localhost:3000/maps/17.kml",
            "tiles": "http://localhost:3000/maps/tile/17/{z}/{x}/{y}.png",
            "wms": "http://localhost:3000/maps/wms/17?request=GetCapabilities\u0026service=WMS\u0026version=1.1.1",
            "thumb": "/uploads/17/thumb/macrepo_3A89267_dhjrksxc.png"
        }
    }
}
```

```http://mapwarper.lib.mcmaster.ca/api/v1/maps/17.geojson```
returns

```
{"id":17,"type":"Feature","properties":{"title":"Fukuoka","description":"US AMS series L902. Prepared from aerial photography dated October, 1945. Relief shown by contour lines and spot heights. Inset in top left shows 1:50,000 view of Fukuoka, 21 x 25 cm. Held in the Lloyd Reeds Map Collection, call no. G 7960 s12 MC54E","width":23671,"height":20430,"status":"warped","created_at":"2020-04-22T20:31:52.543Z","bbox":"130.3257795,33.5553111,130.46231,33.6558971","thumb_url":"/uploads/17/thumb/macrepo_3A89267_dhjrksxc.png"},"geometry":{"type":"Polygon","coordinates":"[[[130.3257795, 33.5553111], [130.46231, 33.5553111], [130.46231, 33.6558971], [130.3257795, 33.6558971], [130.3257795, 33.5553111]]]"}}
```

or formatted nicely: 
```
{
    "id": 17,
    "type": "Feature",
    "properties": {
        "title": "Fukuoka",
        "description": "US AMS series L902. Prepared from aerial photography dated October, 1945. Relief shown by contour lines and spot heights. Inset in top left shows 1:50,000 view of Fukuoka, 21 x 25 cm. Held in the Lloyd Reeds Map Collection, call no. G 7960 s12 MC54E",
        "width": 23671,
        "height": 20430,
        "status": "warped",
        "created_at": "2020-04-22T20:31:52.543Z",
        "bbox": "130.3257795,33.5553111,130.46231,33.6558971",
        "thumb_url": "/uploads/17/thumb/macrepo_3A89267_dhjrksxc.png"
    },
    "geometry": {
        "type": "Polygon",
        "coordinates": "[[[130.3257795, 33.5553111], [130.46231, 33.5553111], [130.46231, 33.6558971], [130.3257795, 33.6558971], [130.3257795, 33.5553111]]]"
    }
}
```

### input template
```
{
    "data": {
        "type": "maps",
        "attributes": {
            "title": "<title>",
            "description": "<description>",
			"source_uri": "<source_uri>",
			"unique_id": "<unique_id>",
            "date_depicted": <date_depicted>,
			"map_type": "<map_type",
            "issue_year": <issue_year>,		
			"tag_list": "<tag_list>",
			"subject_area": "<subject_area>",
			"publisher": "<publisher>",
			"publication_place": "<publication_place>",
			"authors": "<authors>",
			"scale": "<scale>",
			"metadata_projection": "<metadata_projection>",
			"metadata_lat": "<metadata_lat>",
			"metadata_lon": "<metadata_lon>",
			"upload_url": "<upload_url>"
		}
    }
}
```

or in condensed form:
```
{"data": {"type": "maps","attributes": {"title": "<title>","description":"<description>","source_uri":"<source_uri>","unique_id":"<unique_id>","date_depicted":<date_depicted>,"map_type":"<map_type","issue_year":<issue_year>,"tag_list":"<tag_list>","subject_area":"<subject_area>","publisher":"<publisher>","publication_place":"<publication_place>","authors":"<authors>","scale":"<scale>","metadata_projection":"<metadata_projection>","metadata_lat":"<metadata_lat>","metadata_lon":"<metadata_lon>","upload_url": "<upload_url>"}}}
```

## Full working cURL request with username/password missing: 

```
curl -H "Content-Type: application/json" -H 'Accept: application/json'  -X POST -u <username>:<password> -d '{"data": {"type": "maps","attributes": {"title":"Doullens","description":"GSGS (series); 4040. Sheet 84, 4th ed. Nord de Guerre grid. Originally published in 1938. Held in the Lloyd Reeds Map Collection, call no. G 5830 s50 .G7 MC56J","source_uri":"https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89237","unique_id":"WW2_France_50k_GSGS4040_084","date_depicted":"1943","map_type":"is_map","issue_year":"1943","tag_list":"topo map","subject_area":"World War, 1939-1945","publisher":"War Office","publication_place":"[London]","authors":"Great Britain. War Office. General Staff. Geographical Section.","scale":"1:50,000","metadata_projection":"","metadata_lat":"50.17","metadata_lon":"2.208","upload_url":"https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89237/datastream/OBJ/macrepo%3A89237.tiff"}}}' http://mapwarper.lib.mcmaster.ca/api/v1/maps -b cookie
```
















