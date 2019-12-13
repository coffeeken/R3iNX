name := ReiNX
ver_major  := 2
ver_minor  := 4
dir_source := src
dir_data := data
dir_build := build
dir_out := out
dir_sysmod := NX_Sysmodules

all: bootloader sysmod

sysmod:
	@$(MAKE) ver_maj=$(ver_major) ver_min=$(ver_minor) -C $(dir_sysmod)
	@mkdir -p "$(dir_out)/ReiNX/sysmodules"
	@mkdir -p "$(dir_out)/ReiNX/sysmodules.dis"
	@cp $(dir_sysmod)/loader/loader.kip $(dir_out)/ReiNX/sysmodules/
	@cp $(dir_sysmod)/sm/sm.kip $(dir_out)/ReiNX/sysmodules/
	@cp $(dir_sysmod)/pm/pm.kip $(dir_out)/ReiNX/sysmodules/
	@cp $(dir_sysmod)/spl/spl.kip $(dir_out)/ReiNX/sysmodules/
	@cp $(dir_sysmod)/boot/boot.kip $(dir_out)/ReiNX/sysmodules/
	@cp $(dir_sysmod)/rnx_mitm/rnx_mitm.kip $(dir_out)/ReiNX/sysmodules/
	@mkdir -p "$(dir_out)/ReiNX/contents/0100000000000034"
	@mkdir -p "$(dir_out)/ReiNX/contents/0100000000000008"
	@mkdir -p "$(dir_out)/ReiNX/contents/0100000000000036"
	@mkdir -p "$(dir_out)/ReiNX/contents/0100000000000037/flags"
	@mkdir -p "$(dir_out)/ReiNX/contents/0100000000000032/flags"
	@mkdir -p "$(dir_out)/ReiNX/contents/010000000000000D"
	@cp $(dir_sysmod)/fatal/fatal.nsp $(dir_out)/ReiNX/contents/0100000000000034/exefs.nsp
	@cp $(dir_sysmod)/dmnt/dmnt.nsp $(dir_out)/ReiNX/contents/010000000000000D/exefs.nsp
	@cp $(dir_sysmod)/creport/creport.nsp $(dir_out)/ReiNX/contents/0100000000000036/exefs.nsp
	@cp $(dir_sysmod)/boot2/boot2.nsp $(dir_out)/ReiNX/contents/0100000000000008/exefs.nsp
	@cp $(dir_sysmod)/eclct.stub/eclct.stub.nsp $(dir_out)/ReiNX/contents/0100000000000032/exefs.nsp
	@cp $(dir_sysmod)/ro/ro.nsp $(dir_out)/ReiNX/contents/0100000000000037/exefs.nsp
	@cp $(dir_sysmod)/Common/exosphere/exosphere.bin $(dir_out)/ReiNX/secmon.bin
	@cp $(dir_sysmod)/Common/exosphere/lp0fw.bin $(dir_out)/ReiNX/warmboot.bin
	@touch $(dir_out)/ReiNX/contents/0100000000000032/flags/boot2.flag
    @touch $(dir_out)/ReiNX/contents/0100000000000037/flags/boot2.flag

bootloader:
	@$(MAKE) -C $(dir_source)
	@$(MAKE) -C $(dir_source)/libsys_lp0
	@mkdir -p "$(dir_out)/ReiNX/patches"
	@cp -R $(dir_data)/*.bmp $(dir_out)/ReiNX/
	@cp -R $(dir_data)/*.rxp $(dir_out)/ReiNX/patches
	@cp -R $(dir_source)/output/hekate.bin $(dir_out)/ReiNX.bin