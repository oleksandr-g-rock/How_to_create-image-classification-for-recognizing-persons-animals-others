#!/bin/bash


##########USERS VAR ###############
path_main_folder="/content/animals_and_person" #NEED CHANGE TO YOU FOLDER
percent_files="20" #NEED CHANGE TO YOUR %
##########USERS VAR ###############


#################################SORT DATA TO FOLDERS######################################################
echo "create folders val"
mkdir $path_main_folder/val
folder_val="$path_main_folder/val"

ls $path_main_folder | grep -v val| while read -r NAME; do

echo " START ###### ${NAME} #####"
count_files_in_folder=$(ls "$path_main_folder"/"${NAME}" | wc -l)
echo " count files in folder ${NAME}  $count_files_in_folder"

echo "count percentage $percent_files folder "${NAME}" need move to another folder"
count_files_need_move=$(echo $(( $count_files_in_folder*$percent_files/100 )))
echo $count_files_need_move

echo "create folder ${NAME}"
mkdir $folder_val/"${NAME}"
chmod -R 777 $path_main_folder

echo "count files which need move to another direcory"
echo $count_files_need_move
cd "$path_main_folder"/"${NAME}" && ls | head -"$count_files_need_move" | xargs -I{} sudo mv {} $folder_val/"${NAME}"/

echo "count files in val direcory for ${NAME} "
ls $folder_val/"${NAME}"/ | wc -l

echo "count files in train direcory for ${NAME} "
ls "$path_main_folder"/"${NAME}"/ | wc -l

echo " FINISH ###### ${NAME} #####
"
done
#################################SORT DATA TO FOLDERS######################################################


#################################MOVE LEFT DATA TO TRAIN FOLDER######################################################
echo "create folder train and move all left except folder val to this folder -  it's just rename"
mkdir $path_main_folder/train
ls $path_main_folder | grep -v val | grep -v train | while read -r NAME; do
mv "$path_main_folder"/"${NAME}" $path_main_folder/train/
done

echo "
check again count files per classes in folder train"
ls $path_main_folder/train/ | while read -r NAME; do
echo "folder $path_main_folder/train/"${NAME}" "
ls $path_main_folder/train/"${NAME}"/ | wc -l 
done

echo "
check again count files per classes in folder val"
ls $path_main_folder/train/ | while read -r NAME; do
echo "folder $path_main_folder/val/"${NAME}" "
ls $path_main_folder/val/"${NAME}"/ | wc -l 
done
#################################MOVE LEFT DATA TO TRAIN FOLDER######################################################
