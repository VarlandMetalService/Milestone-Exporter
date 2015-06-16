# Milestone Exporter

The Milestone Exporter is an application allowing the user to selectively export video footage from
the Milestone system to an archive location.

![Screenshot](https://raw.githubusercontent.com/VarlandMetalService/Milestone-Exporter/master/screenshot.jpg)

As the screenshot shows, there are 4 user-configurable options:

1. Export location
2. Maximum export size
3. Cameras to export
4. Date range for export

Once the user has configured the options, clicking the `Test Export` button will check the selected
footage to make sure it will fit within the given maximum export size. If it will, the `Start
Export` button is enabled. If not, an error is shown and different options must be configured.
During an export, a progress bar is shown to indicate export progress.

This program can be run either on the Milestone Server or on a different PC.
