Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/5] block: move .dma_alignment into q->limits
Date: Thu, 18 Oct 2018 21:18:14 +0800
Message-Id: <20181018131817.11813-3-ming.lei@redhat.com>
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Turns out q->dma_alignement should be stack limit because now bvec table
is immutalbe, the underlying queue's dma alignment has to be perceptible
by stack driver, so IO buffer can be allocated as dma aligned before
adding to bio.

So this patch moves .dma_alignment into q->limits and prepares for
making it as one stacked limit.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: xfs@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c   | 6 +++---
 include/linux/blkdev.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index ffd459969689..cf9cd241dc16 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -830,7 +830,7 @@ EXPORT_SYMBOL(blk_queue_virt_boundary);
  **/
 void blk_queue_dma_alignment(struct request_queue *q, int mask)
 {
-	q->dma_alignment = mask;
+	q->limits.dma_alignment = mask;
 }
 EXPORT_SYMBOL(blk_queue_dma_alignment);
 
@@ -852,8 +852,8 @@ void blk_queue_update_dma_alignment(struct request_queue *q, int mask)
 {
 	BUG_ON(mask > PAGE_SIZE);
 
-	if (mask > q->dma_alignment)
-		q->dma_alignment = mask;
+	if (mask > q->limits.dma_alignment)
+		q->limits.dma_alignment = mask;
 }
 EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 61207560e826..be938a31bc2e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -366,6 +366,7 @@ struct queue_limits {
 	unsigned long		seg_boundary_mask;
 	unsigned long		virt_boundary_mask;
 
+	unsigned int		dma_alignment;
 	unsigned int		max_hw_sectors;
 	unsigned int		max_dev_sectors;
 	unsigned int		chunk_sectors;
@@ -561,7 +562,6 @@ struct request_queue {
 	unsigned int		dma_drain_size;
 	void			*dma_drain_buffer;
 	unsigned int		dma_pad_mask;
-	unsigned int		dma_alignment;
 
 	struct blk_queue_tag	*queue_tags;
 
@@ -1617,7 +1617,7 @@ static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
 
 static inline int queue_dma_alignment(struct request_queue *q)
 {
-	return q ? q->dma_alignment : 511;
+	return q ? q->limits.dma_alignment : 511;
 }
 
 static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
-- 
2.9.5
