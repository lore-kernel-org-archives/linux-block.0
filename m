Return-Path: <prvs=591f9e40c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: Suppress kernel-doc warnings triggered by blk-zoned.c
Date: Thu,  1 Mar 2018 08:20:26 -0800
Message-Id: <20180301162026.13970-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that building with W=1 causes the kernel-doc tool to complain
about undocumented function arguments for the blk-zoned.c source file.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index acb7252c7e81..08e84ef2bc05 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -296,7 +296,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 }
 EXPORT_SYMBOL_GPL(blkdev_reset_zones);
 
-/**
+/*
  * BLKREPORTZONE ioctl processing.
  * Called from blkdev_ioctl.
  */
@@ -355,7 +355,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-/**
+/*
  * BLKRESETZONE ioctl processing.
  * Called from blkdev_ioctl.
  */
-- 
2.16.2
