This is made for Lando+Docker under Ubuntu.

Install Docker CE, Lando.

1. copy *.pac files to 0src (you can't add a non-existing language file, you have to alter one, so the langcode will stay the same but inside the texts will be in your language)
2. lando start
3. lando process_pac_files
4. lando copy_files_recursive
5. lando change_langcode_to_ko_in_xmls
6. in new 2xml folder there will be a folder for each *.pac with XML content
7. translate the texts in XML files
8. lando convert_xmls_to_cnvrs_back
9. lando convert_back_to_pac
10. new *.pac files will be in 4newpac folder, that can be used in a mod or copy them to the proper game folder
11. if you need to alter further texts in translation, repeat process from step 7