Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] nbd: set discard granularity properly
Date: Wed, 23 May 2018 13:35:59 -0400
Message-Id: <20180523173559.6336-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

For some reason we had discard granularity set to 512 always even when
discards were disabled.  Fix this by having the default be 0, and then
if we turn it on set the discard granularity to the blocksize.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/nbd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1147e4680c80..bdfbb2a7018c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -236,6 +236,10 @@ static void nbd_size_update(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 	struct block_device *bdev = bdget_disk(nbd->disk, 0);
 
+	if (config->flags & NBD_FLAG_SEND_TRIM) {
+		nbd->disk->queue->limits.discard_granularity = config->blksize;
+		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
+	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
@@ -1050,6 +1054,8 @@ static void nbd_config_put(struct nbd_device *nbd)
 		nbd->config = NULL;
 
 		nbd->tag_set.timeout = 0;
+		nbd->disk->queue->limits.discard_granularity = 0;
+		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 
 		mutex_unlock(&nbd->config_lock);
@@ -1502,8 +1508,8 @@ static int nbd_dev_add(int index)
 	 */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
-	disk->queue->limits.discard_granularity = 512;
-	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+	disk->queue->limits.discard_granularity = 0;
+	blk_queue_max_discard_sectors(disk->queue, 0);
 	blk_queue_max_segment_size(disk->queue, UINT_MAX);
 	blk_queue_max_segments(disk->queue, USHRT_MAX);
 	blk_queue_max_hw_sectors(disk->queue, 65536);
-- 
2.14.3
