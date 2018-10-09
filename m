Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35756 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIV6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 17:58:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009144105euoutp013f2dfa7145e2f53ae922e0d91c99657f~b97eQCoQH3034930349euoutp01R
        for <linux-block@vger.kernel.org>; Tue,  9 Oct 2018 14:41:05 +0000 (GMT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] drivers/block: remove redundant 'default n' from Kconfig-s
Date: Tue, 9 Oct 2018 16:41:01 +0200
MIME-Version: 1.0
Message-Id: <20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1~b97cjWjY10058900589eucas1p1n@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20181009144103eucas1p1dbf48b04c923877cdbdcf2197725ccd1@eucas1p1.samsung.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/block/Kconfig      |    1 -
 drivers/block/drbd/Kconfig |    1 -
 drivers/block/zram/Kconfig |    2 --
 3 files changed, 4 deletions(-)

Index: b/drivers/block/Kconfig
===================================================================
--- a/drivers/block/Kconfig	2018-09-26 15:54:31.958819766 +0200
+++ b/drivers/block/Kconfig	2018-10-09 16:35:01.327177898 +0200
@@ -461,7 +461,6 @@ config BLK_DEV_RBD
 	select LIBCRC32C
 	select CRYPTO_AES
 	select CRYPTO
-	default n
 	help
 	  Say Y here if you want include the Rados block device, which stripes
 	  a block device over objects stored in the Ceph distributed object
Index: b/drivers/block/drbd/Kconfig
===================================================================
--- a/drivers/block/drbd/Kconfig	2018-09-03 18:11:21.973792264 +0200
+++ b/drivers/block/drbd/Kconfig	2018-10-09 16:35:10.251178122 +0200
@@ -11,7 +11,6 @@ config BLK_DEV_DRBD
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select LIBCRC32C
-	default n
 	help
 
 	  NOTE: In order to authenticate connections you have to select
Index: b/drivers/block/zram/Kconfig
===================================================================
--- a/drivers/block/zram/Kconfig	2018-09-03 18:11:22.185792260 +0200
+++ b/drivers/block/zram/Kconfig	2018-10-09 16:35:21.667178410 +0200
@@ -3,7 +3,6 @@ config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
 	select CRYPTO_LZO
-	default n
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
@@ -18,7 +17,6 @@ config ZRAM
 config ZRAM_WRITEBACK
        bool "Write back incompressible page to backing device"
        depends on ZRAM
-       default n
        help
 	 With incompressible page, there is no memory saving to keep it
 	 in memory. Instead, write it out to backing device.
