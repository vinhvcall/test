


sudo docker exec -it --user root  cms_vgsbooking_2 sh -c "git pull -v && npm run prod" 
sudo docker exec -it --user root  cms_vgsbooking_2 sh -c "git fetch && git diff --stat HEAD~1 HEAD" 
sudo docker exec -it --user root  cms_vgsbooking_2 sh -c "git pull" 
sudo docker exec -it --user root  cms_vgsbooking_2 sh -c "npm run prod" 
