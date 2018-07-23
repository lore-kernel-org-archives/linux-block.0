Return-Path: <prvs=735483b7d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Matias Bjorling <matias.bjorling@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: Rename the null_blk_mod kernel module back into null_blk
Date: Mon, 23 Jul 2018 14:18:33 -0700
Message-Id: <20180723211833.15498-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Commit ca4b2a011948 ("null_blk: add zone support") breaks several
blktests scripts because it renamed the null_blk kernel module into
null_blk_mod. Hence rename null_blk_mod back into null_blk.

Fixes: ca4b2a011948 ("null_blk: add zone support")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Matias Bjorling <matias.bjorling@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/Makefile                        | 6 +++---
 drivers/block/{null_blk.c => null_blk_main.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/block/{null_blk.c => null_blk_main.c} (100%)

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a0d88aa0c05d..8566b188368b 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -38,9 +38,9 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
 
-obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk_mod.o
-null_blk_mod-objs	:= null_blk.o
-null_blk_mod-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
+null_blk-objs	:= null_blk_main.o
+null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
 
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk_main.c
similarity index 100%
rename from drivers/block/null_blk.c
rename to drivers/block/null_blk_main.c
-- 
2.18.0
