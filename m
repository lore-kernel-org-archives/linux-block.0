Return-Path: <sj38.park@gmail.com>
Return-Path: <sj38.park@gmail.com>
From: SeongJae Park <sj38.park@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] brd: Mark as non-rotational
Date: Thu,  3 May 2018 18:53:26 +0900
Message-Id: <20180503095326.7414-1-sj38.park@gmail.com>
List-ID: <linux-block@vger.kernel.org>

This commit sets QUEUE_FLAG_NONROT and clears up QUEUE_FLAG_ADD_RANDOM
to mark the ramdisks as non-rotational device.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 drivers/block/brd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 66cb0f857f64..39c5b90cc187 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -402,6 +402,10 @@ static struct brd_device *brd_alloc(int i)
 	set_capacity(disk, rd_size * 2);
 	disk->queue->backing_dev_info->capabilities |= BDI_CAP_SYNCHRONOUS_IO;
 
+	/* Tell the block layer that this is not a rotational device */
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+
 	return brd;
 
 out_free_queue:
-- 
2.13.0
