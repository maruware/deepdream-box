function install {
    echo installing $1
    shift
    sudo apt-get -y install "$@" >/dev/null 2>&1
}

function pip_install {
  echo installing $1
  sudo pip install $@ >/dev/null 2>&1
}

sudo apt-get -y update >/dev/null 2>&1
install 'Git' git
install 'basic lib' build-essential libssl-dev libxml2-dev libxslt1-dev libbz2-dev zlib1g-dev libjpeg62-dev libreadline-gplv2-dev

install 'lib for pydata' libblas-dev liblapack-dev gfortran libfreetype6-dev

install 'pip' python-pip

echo 'install pydata'
pip_install numpy
pip_install scipy
pip_install pandas
pip_install scikit-learn
pip_install matplotlib
pip_install ipython[notebook]
pip_install markupsafe
pip_install jsonschema
pip_install certifi
pip_install scikit-learn
pip_install PIL
pip_install protobuf

install 'Cuda' nvidia-cuda-toolkit
install 'The rest of the dependencies' libatlas-base-dev libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler g++-4.6

cd ~
echo "install caffe"
git clone https://github.com/BVLC/caffe.git

cd caffe
cp Makefile.config.example Makefile.config
sed -i -e "s/# CPU_ONLY := 1/CPU_ONLY := 1/g" Makefile.config
sed -i -e "s/# CUSTOM_CXX := g++/CUSTOM_CXX := g++-4.6/g" Makefile.config
sed -i -e "s/CUDA_DIR := \/usr\/local\/cuda/#CUDA_DIR := \/usr\/local\/cuda/g" Makefile.config
sed -i -e "s/#CUDA_DIR := \/usr/CUDA_DIR := \/usr/g" Makefile.config

make all
make test
make runtest

sudo pip install -r python/requirements.txt

# install 'python basic lib?' python-dateutil python-docutils python-feedparser python-gdata python-jinja2 python-ldap python-libxslt1 python-lxml python-mako python-mock python-openid python-psycopg2 python-psutil python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-unittest2 python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi
install 'lib for pycaffe' python-dev python-numpy python-skimage

make pycaffe
make distribute
echo "export PYTHONPATH=~/caffe/python/" >> ~/.bashrc
source ~/.bashrc

wget -P models/bvlc_googlenet http://dl.caffe.berkeleyvision.org/bvlc_googlenet.caffemodel

cd ..
git clone https://github.com/google/deepdream.git

sed -i "s/\"frames\/%04d.jpg/\"\/vagrant\/frames\/%04d.jpg/g" ./deepdream/dream.ipynb
mkdir /vagrant/frames

sudo pip install --upgrade pyzmq

ipython profile create nbserver
# chmod -R o+w .ipython/profile_nbserver
echo "c.NotebookApp.ip = '*'" >> .ipython/profile_nbserver/ipython_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> .ipython/profile_nbserver/ipython_notebook_config.py
echo "c.NotebookApp.port = 3000" >> .ipython/profile_nbserver/ipython_notebook_config.py
