Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 18 Aug 2017 23:54:46 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] block: remove blk_free_devt in add_partition
Message-ID: <20170818155439.GA30487@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

put_device(pdev) will call pdev->type->release finally, and blk_free_devt
has been called in part_release(), so remove it.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/partition-generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index c5ec824..04d82dd 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -391,7 +391,6 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	device_del(pdev);
 out_put:
 	put_device(pdev);
-	blk_free_devt(devt);
 	return ERR_PTR(err);
 }
 
-- 
2.9.4
