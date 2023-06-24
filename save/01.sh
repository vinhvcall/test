No application encryption key has been specified.

php artisan key:generate


docker exec -i upanh_vhandicap_com sh -c 'pwd ; php artisan key:generate'



IMAGES_NAME="upanh_vhandicap_com"
IMAGES_TAG=`date +%F-%H%M`
      docker commit  $IMAGES_NAME  $IMAGES_NAME:$IMAGES_TAG


RUN git clone  https://gitadmin:pQxLnpEkpVbxJFjWsuMU@gitcode.golfervn.com/truongnx94/live_draw.git
