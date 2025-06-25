# Photo Organizer
A simple photo organizer that moves photos around

# Usage

Modify the ``ProjectRootPath`` property inside ``Settings.xml`` file to point to the root directory of your photo collection.

To move photos from their original location to the "360 Edits/Originals" folder:
```powershell
.\Move-PhotosToEdit.ps1
```

To move photos from the "360 Edits/Edits" folder back into their original location:
```powershell
.\Move-EditedPhotos.ps1
```