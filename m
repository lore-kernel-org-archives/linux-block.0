Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E3C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802972339D
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 23:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=manuel-bentele.de header.i=@manuel-bentele.de header.b="Cq1UfjGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfHWXBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:01:47 -0400
Received: from host1.nc.manuel-bentele.de ([92.60.37.180]:55824 "EHLO
        host1.nc.manuel-bentele.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbfHWXBr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 19:01:47 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: development@manuel-bentele.de)
        by host1.nc.manuel-bentele.de (Postcow) with ESMTPSA id 9127E61074;
        Sat, 24 Aug 2019 00:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manuel-bentele.de;
        s=dkim; t=1566600979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=riHdRnNo+HsesHIQ23avKTZJLiqbwQpIeEPOHREcZ0Y=;
        b=Cq1UfjGRNaPdThyl557vlEKv6Cah3hl/CU+5AzdSsbiWcJQ59AJk033toCqfvXE/GaC4Ve
        eTWtyKEaDIL5BvUwkqb4XvQC4DHeNo2I/+0MK1sbkusSYYt7RBEJMilHdGAc4J/jUncLPZ
        VUjFMv1yZpCCANwJeVAQpqtQNNz+9T0NzAdjszaavMo5atxdsc/s3YWNQJ7MFxrBzndpwa
        LlSzFO7E/gE1DzGmvB8ShgUP/d/5c+1WwG1vO7HEpKFFjfDRP72k/fMEPti+iFwEoY6hK9
        2a7EEXNLL40h5ARpoRQdXyr17eH0ReWA2xpnQR9cbzpHwRnOmGrtiSGoT0LFGw==
From:   development@manuel-bentele.de
To:     linux-block@vger.kernel.org
Cc:     Manuel Bentele <development@manuel-bentele.de>
Subject: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file format driver
Date:   Sat, 24 Aug 2019 00:56:14 +0200
Message-Id: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manuel-bentele.de; s=dkim; t=1566600979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=riHdRnNo+HsesHIQ23avKTZJLiqbwQpIeEPOHREcZ0Y=;
        b=NMEeUeUcfPH8POHiAgY9M3zflaf2t6oYT51jt2WAu018z0cF3Y7uLeduoWnRZrBC2zHJg5
        xaoHQo3732aAqOwwmgo/IarsDA5t9a0NciG00lGhUfGVgImI5i336IpbNX0oRUp1nerCS1
        fUFZmQ/YwaTYvLsaFOfkjb2Cmk0j5oHftcMlUDD0NeGNwzm1wq7WcYv28eyDxWzh/L+ctD
        2oX3Qa3IlDr5f2mpMXmEnpksglLkJ1GrPY9E2EjfL7M3ASUZ5q1sp1HJPWWLIcivX5+mPz
        QBdRdQNanIHpjKM/OT0t+1REOmA8dUmsD3ftOq/FwRYmDuJ5kRZwOodnC13ruQ==
ARC-Seal: i=1; s=dkim; d=manuel-bentele.de; t=1566600979; a=rsa-sha256;
        cv=none;
        b=JSdCzF9gtl+ecYNE8es5lTWloEceQ/pMyJjZ6IxCoQcA1bfKkl8pJIYvcdxAqt1XcHPApO
        3O0JWI9lxQ7FOPtXcwnbX3v4NA97giQkNYQGB6c0KPuKD1/ylrhoqffIIRm5DroX5Dwzra
        P5nWYb+OVu3UuYagPYdurcOWmJePCo6d1K9lhR6B+aEowyarSpXqr9O4Cr9tQNRybwxZZp
        p4rnYnppCsbd4or8xlcbgLGSFBIqlWmDMyG6SWfThZzBegcpPpkI10ufjpe4V7CcpIRR+8
        FTnEaOUQU/WNUqvjL9TU+kGlbSYToZJuRKPeBMHPsod5aREzIw+vJIEn6BhRxg==
ARC-Authentication-Results: i=1;
        host1.nc.manuel-bentele.de;
        auth=pass smtp.auth=development@manuel-bentele.de smtp.mailfrom=development@manuel-bentele.de
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Manuel Bentele <development@manuel-bentele.de>

Hi

Regarding to the following discussion [1] on the mailing list I show you 
the result of my work as announced at the end of the discussion [2].

The discussion was about the project topic of how to implement the 
reading/writing of QCOW2 in the kernel. The project focuses on an read-only 
in-kernel QCOW2 implementation to increase the read/write performance 
and tries to avoid nbd. Furthermore, the project is part of a project 
series to develop a in-kernel network boot infrastructure that has no need 
for any user space interaction (e.g. nbd) anymore.

During the discussion, it turned out that the implementation as device 
mapper target is not applicable. The device mapper stacks different 
functionality such as compression or encryption on multiple block device 
layers whereas an implementation for the QCOW2 container format provides 
these functionalities on one block device layer. Using FUSE is also not 
possible due to performance reasons and user space interaction.

Therefore, I propose the extension of the loop device module. I created a 
new file format subsystem which is part of the loop device module. The file 
format subsystem abstracts the direct file access and provides an driver 
API to implement various disk file formats such as QCOW2, VDI and VMDK. 
File format drivers are implemented as kernel modules and can be registered 
by the file format subsystem.

The patch series contains documentation for the file format subsystem and 
the loop device module, too. Also, it provides a default RAW file format 
driver and a read-only QCOW2 driver. The RAW file format driver is based on 
the file specific parts of the existing loop device implementation and 
preserves the default behaviour of a loop device. More specific information 
can be found in the commit logs of the following patches.

Regards,
Manuel

[1] https://www.spinics.net/lists/linux-block/msg39538.html
[2] https://www.spinics.net/lists/linux-block/msg40479.html

Manuel Bentele (5):
  block: loop: add file format subsystem for loop devices
  doc: admin-guide: add loop block device documentation
  doc: driver-api: add loop file format subsystem API documentation
  block: loop: add QCOW2 loop file format driver (read-only)
  doc: admin-guide: add QCOW2 file format to loop device documentation

 Documentation/admin-guide/blockdev/index.rst  |   1 +
 Documentation/admin-guide/blockdev/loop.rst   |  85 ++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/loop-file-fmt.rst    | 137 +++
 arch/alpha/configs/defconfig                  |   1 +
 arch/arc/configs/axs103_defconfig             |   1 +
 arch/arc/configs/axs103_smp_defconfig         |   1 +
 arch/arm/configs/am200epdkit_defconfig        |   1 +
 arch/arm/configs/aspeed_g4_defconfig          |   1 +
 arch/arm/configs/aspeed_g5_defconfig          |   1 +
 arch/arm/configs/assabet_defconfig            |   1 +
 arch/arm/configs/at91_dt_defconfig            |   1 +
 arch/arm/configs/axm55xx_defconfig            |   1 +
 arch/arm/configs/badge4_defconfig             |   1 +
 arch/arm/configs/cerfcube_defconfig           |   1 +
 arch/arm/configs/cm_x2xx_defconfig            |   1 +
 arch/arm/configs/cm_x300_defconfig            |   1 +
 arch/arm/configs/cns3420vb_defconfig          |   1 +
 arch/arm/configs/colibri_pxa270_defconfig     |   1 +
 arch/arm/configs/collie_defconfig             |   1 +
 arch/arm/configs/corgi_defconfig              |   1 +
 arch/arm/configs/davinci_all_defconfig        |   1 +
 arch/arm/configs/dove_defconfig               |   1 +
 arch/arm/configs/em_x270_defconfig            |   1 +
 arch/arm/configs/eseries_pxa_defconfig        |   1 +
 arch/arm/configs/exynos_defconfig             |   1 +
 arch/arm/configs/ezx_defconfig                |   1 +
 arch/arm/configs/footbridge_defconfig         |   1 +
 arch/arm/configs/h3600_defconfig              |   1 +
 arch/arm/configs/imote2_defconfig             |   1 +
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 arch/arm/configs/integrator_defconfig         |   1 +
 arch/arm/configs/iop32x_defconfig             |   1 +
 arch/arm/configs/ixp4xx_defconfig             |   1 +
 arch/arm/configs/jornada720_defconfig         |   1 +
 arch/arm/configs/keystone_defconfig           |   1 +
 arch/arm/configs/lpc32xx_defconfig            |   1 +
 arch/arm/configs/milbeaut_m10v_defconfig      |   1 +
 arch/arm/configs/mini2440_defconfig           |   1 +
 arch/arm/configs/multi_v5_defconfig           |   1 +
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/mv78xx0_defconfig            |   1 +
 arch/arm/configs/mvebu_v5_defconfig           |   1 +
 arch/arm/configs/netwinder_defconfig          |   1 +
 arch/arm/configs/nhk8815_defconfig            |   1 +
 arch/arm/configs/omap1_defconfig              |   1 +
 arch/arm/configs/omap2plus_defconfig          |   1 +
 arch/arm/configs/orion5x_defconfig            |   1 +
 arch/arm/configs/oxnas_v6_defconfig           |   1 +
 arch/arm/configs/palmz72_defconfig            |   1 +
 arch/arm/configs/pleb_defconfig               |   1 +
 arch/arm/configs/prima2_defconfig             |   1 +
 arch/arm/configs/pxa3xx_defconfig             |   1 +
 arch/arm/configs/pxa_defconfig                |   1 +
 arch/arm/configs/qcom_defconfig               |   1 +
 arch/arm/configs/rpc_defconfig                |   1 +
 arch/arm/configs/s3c2410_defconfig            |   1 +
 arch/arm/configs/s3c6400_defconfig            |   1 +
 arch/arm/configs/s5pv210_defconfig            |   1 +
 arch/arm/configs/sama5_defconfig              |   1 +
 arch/arm/configs/simpad_defconfig             |   1 +
 arch/arm/configs/socfpga_defconfig            |   1 +
 arch/arm/configs/spitz_defconfig              |   1 +
 arch/arm/configs/tango4_defconfig             |   1 +
 arch/arm/configs/tegra_defconfig              |   1 +
 arch/arm/configs/trizeps4_defconfig           |   1 +
 arch/arm/configs/viper_defconfig              |   1 +
 arch/arm/configs/zeus_defconfig               |   1 +
 arch/arm/configs/zx_defconfig                 |   1 +
 arch/arm64/configs/defconfig                  |   1 +
 arch/c6x/configs/dsk6455_defconfig            |   1 +
 arch/c6x/configs/evmc6457_defconfig           |   1 +
 arch/c6x/configs/evmc6472_defconfig           |   1 +
 arch/c6x/configs/evmc6474_defconfig           |   1 +
 arch/c6x/configs/evmc6678_defconfig           |   1 +
 arch/csky/configs/defconfig                   |   1 +
 arch/hexagon/configs/comet_defconfig          |   1 +
 arch/ia64/configs/bigsur_defconfig            |   1 +
 arch/ia64/configs/generic_defconfig           |   1 +
 arch/ia64/configs/gensparse_defconfig         |   1 +
 arch/ia64/configs/tiger_defconfig             |   1 +
 arch/ia64/configs/zx1_defconfig               |   1 +
 arch/m68k/configs/amiga_defconfig             |   1 +
 arch/m68k/configs/apollo_defconfig            |   1 +
 arch/m68k/configs/atari_defconfig             |   1 +
 arch/m68k/configs/bvme6000_defconfig          |   1 +
 arch/m68k/configs/hp300_defconfig             |   1 +
 arch/m68k/configs/mac_defconfig               |   1 +
 arch/m68k/configs/multi_defconfig             |   1 +
 arch/m68k/configs/mvme147_defconfig           |   1 +
 arch/m68k/configs/mvme16x_defconfig           |   1 +
 arch/m68k/configs/q40_defconfig               |   1 +
 arch/m68k/configs/sun3_defconfig              |   1 +
 arch/m68k/configs/sun3x_defconfig             |   1 +
 arch/mips/configs/bigsur_defconfig            |   1 +
 arch/mips/configs/cavium_octeon_defconfig     |   1 +
 arch/mips/configs/cobalt_defconfig            |   1 +
 arch/mips/configs/decstation_64_defconfig     |   1 +
 arch/mips/configs/decstation_defconfig        |   1 +
 arch/mips/configs/decstation_r4k_defconfig    |   1 +
 arch/mips/configs/fuloong2e_defconfig         |   1 +
 arch/mips/configs/generic/board-ocelot.config |   1 +
 arch/mips/configs/gpr_defconfig               |   1 +
 arch/mips/configs/ip27_defconfig              |   1 +
 arch/mips/configs/ip32_defconfig              |   1 +
 arch/mips/configs/jazz_defconfig              |   1 +
 arch/mips/configs/lemote2f_defconfig          |   1 +
 arch/mips/configs/loongson1b_defconfig        |   1 +
 arch/mips/configs/loongson1c_defconfig        |   1 +
 arch/mips/configs/loongson3_defconfig         |   1 +
 arch/mips/configs/malta_defconfig             |   1 +
 arch/mips/configs/malta_kvm_defconfig         |   1 +
 arch/mips/configs/malta_kvm_guest_defconfig   |   1 +
 arch/mips/configs/malta_qemu_32r6_defconfig   |   1 +
 arch/mips/configs/maltaaprp_defconfig         |   1 +
 arch/mips/configs/maltasmvp_defconfig         |   1 +
 arch/mips/configs/maltasmvp_eva_defconfig     |   1 +
 arch/mips/configs/maltaup_defconfig           |   1 +
 arch/mips/configs/maltaup_xpa_defconfig       |   1 +
 arch/mips/configs/markeins_defconfig          |   1 +
 arch/mips/configs/mips_paravirt_defconfig     |   1 +
 arch/mips/configs/nlm_xlp_defconfig           |   1 +
 arch/mips/configs/nlm_xlr_defconfig           |   1 +
 arch/mips/configs/pic32mzda_defconfig         |   1 +
 arch/mips/configs/pistachio_defconfig         |   1 +
 arch/mips/configs/pnx8335_stb225_defconfig    |   1 +
 arch/mips/configs/rbtx49xx_defconfig          |   1 +
 arch/mips/configs/rm200_defconfig             |   1 +
 arch/mips/configs/tb0219_defconfig            |   1 +
 arch/mips/configs/tb0226_defconfig            |   1 +
 arch/mips/configs/tb0287_defconfig            |   1 +
 arch/nios2/configs/10m50_defconfig            |   1 +
 arch/nios2/configs/3c120_defconfig            |   1 +
 arch/parisc/configs/712_defconfig             |   1 +
 arch/parisc/configs/a500_defconfig            |   1 +
 arch/parisc/configs/b180_defconfig            |   1 +
 arch/parisc/configs/c3000_defconfig           |   1 +
 arch/parisc/configs/c8000_defconfig           |   1 +
 arch/parisc/configs/defconfig                 |   1 +
 arch/parisc/configs/generic-32bit_defconfig   |   1 +
 arch/parisc/configs/generic-64bit_defconfig   |   1 +
 arch/powerpc/configs/40x/virtex_defconfig     |   1 +
 arch/powerpc/configs/44x/sam440ep_defconfig   |   1 +
 arch/powerpc/configs/44x/virtex5_defconfig    |   1 +
 arch/powerpc/configs/52xx/cm5200_defconfig    |   1 +
 arch/powerpc/configs/52xx/lite5200b_defconfig |   1 +
 arch/powerpc/configs/52xx/motionpro_defconfig |   1 +
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   1 +
 arch/powerpc/configs/83xx/asp8347_defconfig   |   1 +
 .../configs/83xx/mpc8313_rdb_defconfig        |   1 +
 .../configs/83xx/mpc8315_rdb_defconfig        |   1 +
 .../configs/83xx/mpc832x_mds_defconfig        |   1 +
 .../configs/83xx/mpc832x_rdb_defconfig        |   1 +
 .../configs/83xx/mpc834x_itx_defconfig        |   1 +
 .../configs/83xx/mpc834x_itxgp_defconfig      |   1 +
 .../configs/83xx/mpc834x_mds_defconfig        |   1 +
 .../configs/83xx/mpc836x_mds_defconfig        |   1 +
 .../configs/83xx/mpc836x_rdk_defconfig        |   1 +
 .../configs/83xx/mpc837x_mds_defconfig        |   1 +
 .../configs/83xx/mpc837x_rdb_defconfig        |   1 +
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |   1 +
 arch/powerpc/configs/85xx/ksi8560_defconfig   |   1 +
 .../configs/85xx/mpc8540_ads_defconfig        |   1 +
 .../configs/85xx/mpc8560_ads_defconfig        |   1 +
 .../configs/85xx/mpc85xx_cds_defconfig        |   1 +
 arch/powerpc/configs/85xx/sbc8548_defconfig   |   1 +
 arch/powerpc/configs/85xx/socrates_defconfig  |   1 +
 arch/powerpc/configs/85xx/stx_gp3_defconfig   |   1 +
 arch/powerpc/configs/85xx/tqm8540_defconfig   |   1 +
 arch/powerpc/configs/85xx/tqm8541_defconfig   |   1 +
 arch/powerpc/configs/85xx/tqm8548_defconfig   |   1 +
 arch/powerpc/configs/85xx/tqm8555_defconfig   |   1 +
 arch/powerpc/configs/85xx/tqm8560_defconfig   |   1 +
 .../configs/85xx/xes_mpc85xx_defconfig        |   1 +
 arch/powerpc/configs/amigaone_defconfig       |   1 +
 arch/powerpc/configs/cell_defconfig           |   1 +
 arch/powerpc/configs/chrp32_defconfig         |   1 +
 arch/powerpc/configs/ep8248e_defconfig        |   1 +
 arch/powerpc/configs/fsl-emb-nonhw.config     |   1 +
 arch/powerpc/configs/g5_defconfig             |   1 +
 arch/powerpc/configs/gamecube_defconfig       |   1 +
 arch/powerpc/configs/holly_defconfig          |   1 +
 arch/powerpc/configs/linkstation_defconfig    |   1 +
 arch/powerpc/configs/mgcoge_defconfig         |   1 +
 arch/powerpc/configs/mpc5200_defconfig        |   1 +
 arch/powerpc/configs/mpc7448_hpc2_defconfig   |   1 +
 arch/powerpc/configs/mpc8272_ads_defconfig    |   1 +
 arch/powerpc/configs/mpc83xx_defconfig        |   1 +
 arch/powerpc/configs/mpc866_ads_defconfig     |   1 +
 arch/powerpc/configs/mvme5100_defconfig       |   1 +
 arch/powerpc/configs/pasemi_defconfig         |   1 +
 arch/powerpc/configs/pmac32_defconfig         |   1 +
 arch/powerpc/configs/powernv_defconfig        |   1 +
 arch/powerpc/configs/ppc64_defconfig          |   1 +
 arch/powerpc/configs/ppc64e_defconfig         |   1 +
 arch/powerpc/configs/ppc6xx_defconfig         |   1 +
 arch/powerpc/configs/pq2fads_defconfig        |   1 +
 arch/powerpc/configs/ps3_defconfig            |   1 +
 arch/powerpc/configs/pseries_defconfig        |   1 +
 arch/powerpc/configs/skiroot_defconfig        |   1 +
 arch/powerpc/configs/wii_defconfig            |   1 +
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/configs/rv32_defconfig             |   1 +
 arch/s390/configs/debug_defconfig             |   1 +
 arch/s390/configs/defconfig                   |   1 +
 arch/sh/configs/cayman_defconfig              |   1 +
 arch/sh/configs/landisk_defconfig             |   1 +
 arch/sh/configs/lboxre2_defconfig             |   1 +
 arch/sh/configs/rsk7264_defconfig             |   1 +
 arch/sh/configs/sdk7780_defconfig             |   1 +
 arch/sh/configs/sdk7786_defconfig             |   1 +
 arch/sh/configs/se7206_defconfig              |   1 +
 arch/sh/configs/se7780_defconfig              |   1 +
 arch/sh/configs/sh03_defconfig                |   1 +
 arch/sh/configs/sh2007_defconfig              |   1 +
 arch/sh/configs/sh7785lcr_32bit_defconfig     |   1 +
 arch/sh/configs/shmin_defconfig               |   1 +
 arch/sh/configs/titan_defconfig               |   1 +
 arch/sparc/configs/sparc32_defconfig          |   1 +
 arch/sparc/configs/sparc64_defconfig          |   1 +
 arch/um/configs/i386_defconfig                |   1 +
 arch/um/configs/x86_64_defconfig              |   1 +
 arch/unicore32/configs/defconfig              |   1 +
 arch/x86/configs/i386_defconfig               |   1 +
 arch/x86/configs/x86_64_defconfig             |   1 +
 arch/xtensa/configs/audio_kc705_defconfig     |   1 +
 arch/xtensa/configs/cadence_csp_defconfig     |   1 +
 arch/xtensa/configs/generic_kc705_defconfig   |   1 +
 arch/xtensa/configs/nommu_kc705_defconfig     |   1 +
 arch/xtensa/configs/smp_lx200_defconfig       |   1 +
 arch/xtensa/configs/virt_defconfig            |   1 +
 drivers/block/Kconfig                         |  73 +-
 drivers/block/Makefile                        |   4 +-
 drivers/block/loop/Kconfig                    |  93 ++
 drivers/block/loop/Makefile                   |  13 +
 drivers/block/{ => loop}/cryptoloop.c         |   2 +-
 drivers/block/loop/loop_file_fmt.c            | 328 ++++++
 drivers/block/loop/loop_file_fmt.h            | 351 +++++++
 drivers/block/loop/loop_file_fmt_qcow_cache.c | 218 ++++
 drivers/block/loop/loop_file_fmt_qcow_cache.h |  51 +
 .../block/loop/loop_file_fmt_qcow_cluster.c   | 270 +++++
 .../block/loop/loop_file_fmt_qcow_cluster.h   |  23 +
 drivers/block/loop/loop_file_fmt_qcow_main.c  | 945 ++++++++++++++++++
 drivers/block/loop/loop_file_fmt_qcow_main.h  | 417 ++++++++
 drivers/block/loop/loop_file_fmt_raw.c        | 449 +++++++++
 drivers/block/{loop.c => loop/loop_main.c}    | 567 ++++-------
 drivers/block/{loop.h => loop/loop_main.h}    |  14 +-
 include/uapi/linux/loop.h                     |  14 +-
 248 files changed, 3861 insertions(+), 422 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/loop.rst
 create mode 100644 Documentation/driver-api/loop-file-fmt.rst
 create mode 100644 drivers/block/loop/Kconfig
 create mode 100644 drivers/block/loop/Makefile
 rename drivers/block/{ => loop}/cryptoloop.c (99%)
 create mode 100644 drivers/block/loop/loop_file_fmt.c
 create mode 100644 drivers/block/loop/loop_file_fmt.h
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cache.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cache.h
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cluster.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_cluster.h
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_main.c
 create mode 100644 drivers/block/loop/loop_file_fmt_qcow_main.h
 create mode 100644 drivers/block/loop/loop_file_fmt_raw.c
 rename drivers/block/{loop.c => loop/loop_main.c} (86%)
 rename drivers/block/{loop.h => loop/loop_main.h} (92%)

-- 
2.23.0

