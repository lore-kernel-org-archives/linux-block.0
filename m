Return-Path: <minchan@kernel.org>
From: Minchan Kim <minchan@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hyeoncheol Lee <cheol.lee@lge.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Robert Jennings <rcj@linux.vnet.ibm.com>,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [RFC] blk: increase logical_block_size to unsigned int
Date: Mon,  9 Jan 2017 14:04:27 +0900
Message-Id: <1483938267-8858-1-git-send-email-minchan@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Mostly, zram is used as swap system on embedded world so it want to do IO
as PAGE_SIZE aligned/size IO unit. For that, one of the problem was
blk_queue_logical_block_size(zram->disk->queue, PAGE_SIZE) made overflow
in *64K page system* so [1] changed it to constant 4096.
Since that, partial IO can happen so zram should handle it which makes zram
complicated[2].

Now, I want to remove that partial IO handling logics in zram.

Block guys, Robert, Jerome:

Can't we extend q->limits.logical_block_size to unsigned int?
Is there any problem on that?

[1] 7b19b8d45b21, zram: Prevent overflow in logical block size
[2] 924bd88d703e, zram: allow partial page operations

Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Jerome Marchand <jmarchan@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 block/blk-settings.c   |  2 +-
 include/linux/blkdev.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index f679ae122843..0d644f37e3c6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
  *   storage device can address.  The default of 512 covers most
  *   hardware.
  **/
-void blk_queue_logical_block_size(struct request_queue *q, unsigned short size)
+void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
 	q->limits.logical_block_size = size;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358ba052..0aaea317a7f4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -281,7 +281,7 @@ struct queue_limits {
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
-	unsigned short		logical_block_size;
+	unsigned int		logical_block_size;
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 
@@ -991,7 +991,7 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
-extern void blk_queue_logical_block_size(struct request_queue *, unsigned short);
+extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
@@ -1216,9 +1216,9 @@ static inline unsigned int queue_max_segment_size(struct request_queue *q)
 	return q->limits.max_segment_size;
 }
 
-static inline unsigned short queue_logical_block_size(struct request_queue *q)
+static inline unsigned int queue_logical_block_size(struct request_queue *q)
 {
-	int retval = 512;
+	unsigned int retval = 512;
 
 	if (q && q->limits.logical_block_size)
 		retval = q->limits.logical_block_size;
@@ -1226,7 +1226,7 @@ static inline unsigned short queue_logical_block_size(struct request_queue *q)
 	return retval;
 }
 
-static inline unsigned short bdev_logical_block_size(struct block_device *bdev)
+static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
 {
 	return queue_logical_block_size(bdev_get_queue(bdev));
 }
-- 
2.7.4
