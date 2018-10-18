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
Subject: [PATCH 3/5] block: make dma_alignment as stacked limit
Date: Thu, 18 Oct 2018 21:18:15 +0800
Message-Id: <20181018131817.11813-4-ming.lei@redhat.com>
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch converts .dma_alignment into stacked limit, so the stack
driver may get updated with underlying dma alignment, and allocate
IO buffer as queue DMA aligned.

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
 block/blk-settings.c | 89 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index cf9cd241dc16..aef4510a99b6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -525,6 +525,54 @@ void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b)
 EXPORT_SYMBOL(blk_queue_stack_limits);
 
 /**
+ * blk_queue_dma_alignment - set dma length and memory alignment
+ * @q:     the request queue for the device
+ * @mask:  alignment mask
+ *
+ * description:
+ *    set required memory and length alignment for direct dma transactions.
+ *    this is used when building direct io requests for the queue.
+ *
+ **/
+void blk_queue_dma_alignment(struct request_queue *q, int mask)
+{
+	q->limits.dma_alignment = mask;
+}
+EXPORT_SYMBOL(blk_queue_dma_alignment);
+
+static int __blk_queue_update_dma_alignment(struct queue_limits *t, int mask)
+{
+	BUG_ON(mask >= PAGE_SIZE);
+
+	if (mask > t->dma_alignment)
+		return mask;
+	else
+		return t->dma_alignment;
+}
+
+/**
+ * blk_queue_update_dma_alignment - update dma length and memory alignment
+ * @q:     the request queue for the device
+ * @mask:  alignment mask
+ *
+ * description:
+ *    update required memory and length alignment for direct dma transactions.
+ *    If the requested alignment is larger than the current alignment, then
+ *    the current queue alignment is updated to the new value, otherwise it
+ *    is left alone.  The design of this is to allow multiple objects
+ *    (driver, device, transport etc) to set their respective
+ *    alignments without having them interfere.
+ *
+ **/
+void blk_queue_update_dma_alignment(struct request_queue *q, int mask)
+{
+	q->limits.dma_alignment =
+		__blk_queue_update_dma_alignment(&q->limits, mask);
+}
+EXPORT_SYMBOL(blk_queue_update_dma_alignment);
+
+
+/**
  * blk_stack_limits - adjust queue_limits for stacked devices
  * @t:	the stacking driver limits (top device)
  * @b:  the underlying queue limits (bottom, component device)
@@ -563,6 +611,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					    b->seg_boundary_mask);
 	t->virt_boundary_mask = min_not_zero(t->virt_boundary_mask,
 					    b->virt_boundary_mask);
+	t->dma_alignment = __blk_queue_update_dma_alignment(t,
+							    b->dma_alignment);
 
 	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
 	t->max_discard_segments = min_not_zero(t->max_discard_segments,
@@ -818,45 +868,6 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 }
 EXPORT_SYMBOL(blk_queue_virt_boundary);
 
-/**
- * blk_queue_dma_alignment - set dma length and memory alignment
- * @q:     the request queue for the device
- * @mask:  alignment mask
- *
- * description:
- *    set required memory and length alignment for direct dma transactions.
- *    this is used when building direct io requests for the queue.
- *
- **/
-void blk_queue_dma_alignment(struct request_queue *q, int mask)
-{
-	q->limits.dma_alignment = mask;
-}
-EXPORT_SYMBOL(blk_queue_dma_alignment);
-
-/**
- * blk_queue_update_dma_alignment - update dma length and memory alignment
- * @q:     the request queue for the device
- * @mask:  alignment mask
- *
- * description:
- *    update required memory and length alignment for direct dma transactions.
- *    If the requested alignment is larger than the current alignment, then
- *    the current queue alignment is updated to the new value, otherwise it
- *    is left alone.  The design of this is to allow multiple objects
- *    (driver, device, transport etc) to set their respective
- *    alignments without having them interfere.
- *
- **/
-void blk_queue_update_dma_alignment(struct request_queue *q, int mask)
-{
-	BUG_ON(mask > PAGE_SIZE);
-
-	if (mask > q->limits.dma_alignment)
-		q->limits.dma_alignment = mask;
-}
-EXPORT_SYMBOL(blk_queue_update_dma_alignment);
-
 void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
 {
 	if (queueable)
-- 
2.9.5
