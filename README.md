# mapwarper-tools

[API documentation](https://github.com/timwaters/mapwarper/blob/master/README_API.md#maps)


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


## Full working cURL request with usernam/password missing: 

```
curl -H "Content-Type: application/json" -H 'Accept: application/json'  -X POST -u <username>:<password> -d '{"data": {"type": "maps","attributes": {"title":"Doullens","description":"GSGS (series); 4040. Sheet 84, 4th ed. Nord de Guerre grid. Originally published in 1938. Held in the Lloyd Reeds Map Collection, call no. G 5830 s50 .G7 MC56J","source_uri":"https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89237","unique_id":"WW2_France_50k_GSGS4040_084","date_depicted":"1943","map_type":"is_map","issue_year":"1943","tag_list":"topo map","subject_area":"World War, 1939-1945","publisher":"War Office","publication_place":"[London]","authors":"Great Britain. War Office. General Staff. Geographical Section.","scale":"1:50,000","metadata_projection":"","metadata_lat":"50.17","metadata_lon":"2.208","upload_url":"https://digitalarchive.mcmaster.ca/islandora/object/macrepo%3A89237/datastream/OBJ/macrepo%3A89237.tiff"}}}' http://mapwarper.lib.mcmaster.ca/api/v1/maps -b cookie
```

## Reference:

### How to update DA inventory to ensure that uris resolve correctly (and macrepo lookup works)
- retrieve DA inventory using [this example](https://github.com/jasonbrodeur/Fedora-SPARQL/blob/master/fedora-sparql-cookbook.md#example-4b-list-all-images-within-the-map-collection-of-the-digital-archive---no-title-no-parent)
- Paste results into the [Inventory GSheet](https://docs.google.com/spreadsheets/d/14NTOutHExIA70Kxr62Wm6CeC8pLv1VXz87YWgZFDOJQ/edit#gid=0)
- after pasting, sort by column D and remove any rows with content in them (not ours)
- The rest should auto-generate. Might need to copy and paste all formulas once more
- Check the **Lookup Table (Derived)** tab to ensure that everything looks ok.
- The results will automatically populate the [**Lookup (Do Not Edit)**](https://docs.google.com/spreadsheets/d/1lv4QRQehMqNYLdj-htTJ9NXM_LPJi0DgDyHxeaAFH8I/edit#gid=1196750630) sheet in the **MapWarper Importer Prep** spreadsheet.


https://develop.zendesk.com/hc/en-us/articles/360001068567-Installing-and-using-cURL



















