Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: minchan@kernel.org,
	ngupta@vflare.org,
	sergey.senozhatsky.work@gmail.com,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] block: zram: Replace GFP_ATOMIC with GFP_KERNEL
Date: Mon, 23 Jul 2018 22:13:04 +0800
Message-Id: <20180723141304.3300-1-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

read_from_bdev_async() and write_to_bdev() are never called in atomic
context. They call bio_alloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0f3fadd71230..b958ed0b8c35 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -450,7 +450,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_KERNEL, 1);
 	if (!bio)
 		return -ENOMEM;
 
@@ -538,7 +538,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	struct bio *bio;
 	unsigned long entry;
 
-	bio = bio_alloc(GFP_ATOMIC, 1);
+	bio = bio_alloc(GFP_KERNEL, 1);
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.17.0
