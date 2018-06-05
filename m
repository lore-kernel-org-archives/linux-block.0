Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd@other.debian.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] nbd: set discard_alignment to the granularity
Date: Tue,  5 Jun 2018 11:41:23 -0400
Message-Id: <20180605154123.3226-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

Technically we should be able to get away with 0 as the
discard_alignment, but there's no way currently for the protocol to
indicate different alignments, and in real life most disks have
discard_alignment == discard_granularity.  Just set our alignment to our
blocksize to make sure discards will actually work properly with 4k
drives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index bdfbb2a7018c..ec9b43c9f7e3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -238,6 +238,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 
 	if (config->flags & NBD_FLAG_SEND_TRIM) {
 		nbd->disk->queue->limits.discard_granularity = config->blksize;
+		nbd->disk->queue->limits.discard_alignment = config->blksize;
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 	}
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
@@ -1055,6 +1056,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 
 		nbd->tag_set.timeout = 0;
 		nbd->disk->queue->limits.discard_granularity = 0;
+		nbd->disk->queue->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 
@@ -1509,6 +1511,7 @@ static int nbd_dev_add(int index)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	disk->queue->limits.discard_granularity = 0;
+	disk->queue->limits.discard_alignment = 0;
 	blk_queue_max_discard_sectors(disk->queue, 0);
 	blk_queue_max_segment_size(disk->queue, UINT_MAX);
 	blk_queue_max_segments(disk->queue, USHRT_MAX);
-- 
2.14.3
