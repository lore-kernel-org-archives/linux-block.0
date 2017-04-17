Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] nbd: set the max segment size to UINT_MAX
Date: Mon, 17 Apr 2017 09:44:37 -0400
Message-Id: <1492436677-11209-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

NBD doesn't care about limiting the segment size, let the user push the
largest bio's they want.  This allows us to control the request size
solely through max_sectors_kb.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index d220045..0f62d86 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1469,6 +1469,8 @@ static int nbd_dev_add(int index)
 	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	disk->queue->limits.discard_granularity = 512;
 	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+	blk_queue_max_segment_size(disk->queue, UINT_MAX);
+
 	disk->queue->limits.discard_zeroes_data = 0;
 	blk_queue_max_hw_sectors(disk->queue, 65536);
 	disk->queue->limits.max_sectors = 256;
-- 
2.7.4
