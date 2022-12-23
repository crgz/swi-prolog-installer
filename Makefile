all: prolog-prerequisites deb

.PHONY: prolog-prerequisites
prolog-prerequisites:
	apt-get install -y build-essential cmake ninja-build pkg-config ncurses-dev libreadline-dev libedit-dev \
		libgoogle-perftools-dev libgmp-dev libssl-dev unixodbc-dev zlib1g-dev libarchive-dev libossp-uuid-dev libxext-dev \
		libice-dev libjpeg-dev libxinerama-dev libxft-dev libxpm-dev libxt-dev libdb-dev libpcre2-dev libyaml-dev default-jdk junit4

.PHONY: deb
deb:  swipl-devel/build/swipl-8.5.2-1.x86_64.deb

swipl-devel/build/swipl-8.5.2-1.x86_64.deb: swipl-devel
	cd swipl-devel ;\
   	mkdir build ;\
   	cd build ;\
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_DOCUMENTATION=OFF -DSWIPL_PACKAGES=OFF \
		-DCMAKE_INSTALL_COMPONENT=Core_system -G Ninja .. ;\
	ninja -j8 ;\
	cpack -G DEB

swipl-devel:
	git clone --recursive https://github.com/SWI-Prolog/swipl-devel.git ;\
	cd swipl-devel/ ;\
	git checkout V8.5.2

.PHONY: clean
clean:
	rm -rfd swipl-devel/build
	sudo apt remove -y swipl

committer:
	@git config --global user.email "conrado.rgz@gmail.com" && git config --global user.name "Conrado Rodriguez"