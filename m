Return-Path: <prvs=562a2f801=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] block: Fix a race between the throttling code and request queue initialization
Date: Wed, 31 Jan 2018 11:13:00 -0800
Message-Id: <20180131191300.25664-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Initialize the request queue lock earlier such that the following
race can no longer occur:

blk_init_queue_node                 blkcg_print_blkgs
  blk_alloc_queue_node (1)
    q->queue_lock = &q->__queue_lock (2)
    blkcg_init_queue(q) (3)
                                    spin_lock_irq(blkg->q->queue_lock) (4)
  q->queue_lock = lock (5)
                                    spin_unlock_irq(blkg->q->queue_lock) (6)

(1) allocate an uninitialized queue;
(2) initialize queue_lock to its default internal lock;
(3) initialize blkcg part of request queue, which will create blkg and
    then insert it to blkg_list;
(4) traverse blkg_list and find the created blkg, and then take its
    queue lock, here it is the default *internal lock*;
(5) *race window*, now queue_lock is overridden with *driver specified
    lock*;
(6) now unlock *driver specified lock*, not the locked *internal lock*,
    unlock balance breaks.

The changes in this patch are as follows:
- Rename blk_alloc_queue_node() into blk_alloc_queue_node2() and add
  a new queue lock argument.
- Introduce a wrapper function with the same name and behavior as the
  old blk_alloc_queue_node() function.
- Move the .queue_lock initialization from blk_init_queue_node() into
  blk_alloc_queue_node2().
- For all all block drivers that initialize .queue_lock explicitly,
  change the blk_alloc_queue() call in the driver into a
  blk_alloc_queue_node2() call and remove the explicit .queue_lock
  initialization. Additionally, initialize the spin lock that will
  be used as queue lock earlier if necessary.

Reported-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
---
 block/blk-core.c               | 33 ++++++++++++++++++++++++---------
 drivers/block/drbd/drbd_main.c |  4 ++--
 drivers/block/umem.c           |  7 +++----
 drivers/mmc/core/queue.c       |  3 +--
 include/linux/blkdev.h         |  2 ++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bd43bc50740a..cb18f57e5b13 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -946,7 +946,22 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
 	kblockd_schedule_work(&q->timeout_work);
 }
 
-struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
+/**
+ * blk_alloc_queue_node2 - allocate a request queue
+ * @gfp_mask: memory allocation flags
+ * @node_id: NUMA node to allocate memory from
+ * @lock: Pointer to a spinlock that will be used to e.g. serialize calls to
+ *	  the legacy .request_fn(). Only set this pointer for queues that use
+ *	  legacy mode and not for queues that use blk-mq.
+ *
+ * Note: use this function instead of calling blk_alloc_queue_node() and
+ * setting the queue lock pointer explicitly to avoid triggering a crash in
+ * the blkcg throttling code. That code namely makes sysfs attributes visible
+ * in user space before this function returns and the show method of these
+ * attributes uses the queue lock.
+ */
+struct request_queue *blk_alloc_queue_node2(gfp_t gfp_mask, int node_id,
+					    spinlock_t *lock)
 {
 	struct request_queue *q;
 
@@ -997,11 +1012,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
 
-	/*
-	 * By default initialize queue_lock to internal lock and driver can
-	 * override it later if need be.
-	 */
-	q->queue_lock = &q->__queue_lock;
+	q->queue_lock = lock ? : &q->__queue_lock;
 
 	/*
 	 * A queue starts its life with bypass turned on to avoid
@@ -1042,6 +1053,12 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	kmem_cache_free(blk_requestq_cachep, q);
 	return NULL;
 }
+EXPORT_SYMBOL(blk_alloc_queue_node2);
+
+struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
+{
+	return blk_alloc_queue_node2(gfp_mask, node_id, NULL);
+}
 EXPORT_SYMBOL(blk_alloc_queue_node);
 
 /**
@@ -1088,13 +1105,11 @@ blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
 {
 	struct request_queue *q;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, node_id);
+	q = blk_alloc_queue_node2(GFP_KERNEL, node_id, lock);
 	if (!q)
 		return NULL;
 
 	q->request_fn = rfn;
-	if (lock)
-		q->queue_lock = lock;
 	if (blk_init_allocated_queue(q) < 0) {
 		blk_cleanup_queue(q);
 		return NULL;
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 4b4697a1f963..965e80b13443 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2822,7 +2822,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	q = blk_alloc_queue(GFP_KERNEL);
+	q = blk_alloc_queue_node2(GFP_KERNEL, NUMA_NO_NODE,
+				  &resource->req_lock);
 	if (!q)
 		goto out_no_q;
 	device->rq_queue = q;
@@ -2854,7 +2855,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
 	blk_queue_max_hw_sectors(q, DRBD_MAX_BIO_SIZE_SAFE >> 8);
-	q->queue_lock = &resource->req_lock;
 
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 8077123678ad..f6bb78782afa 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -888,13 +888,14 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	card->Active = -1;	/* no page is active */
 	card->bio = NULL;
 	card->biotail = &card->bio;
+	spin_lock_init(&card->lock);
 
-	card->queue = blk_alloc_queue(GFP_KERNEL);
+	card->queue = blk_alloc_queue_node2(GFP_KERNEL, NUMA_NO_NODE,
+					    &card->lock);
 	if (!card->queue)
 		goto failed_alloc;
 
 	blk_queue_make_request(card->queue, mm_make_request);
-	card->queue->queue_lock = &card->lock;
 	card->queue->queuedata = card;
 
 	tasklet_init(&card->tasklet, process_page, (unsigned long)card);
@@ -968,8 +969,6 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	dev_printk(KERN_INFO, &card->dev->dev,
 		"Window size %d bytes, IRQ %d\n", data, dev->irq);
 
-	spin_lock_init(&card->lock);
-
 	pci_set_drvdata(dev, card);
 
 	if (pci_write_cmd != 0x0F) 	/* If not Memory Write & Invalidate */
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 5ecd54088988..274a8c6c8d64 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -216,10 +216,9 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	int ret = -ENOMEM;
 
 	mq->card = card;
-	mq->queue = blk_alloc_queue(GFP_KERNEL);
+	mq->queue = blk_alloc_queue_node2(GFP_KERNEL, NUMA_NO_NODE, lock);
 	if (!mq->queue)
 		return -ENOMEM;
-	mq->queue->queue_lock = lock;
 	mq->queue->request_fn = mmc_request_fn;
 	mq->queue->init_rq_fn = mmc_init_request;
 	mq->queue->exit_rq_fn = mmc_exit_request;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 781992c4124e..37723a8b799c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1331,6 +1331,8 @@ extern long nr_blockdev_pages(void);
 bool __must_check blk_get_queue(struct request_queue *);
 struct request_queue *blk_alloc_queue(gfp_t);
 struct request_queue *blk_alloc_queue_node(gfp_t, int);
+struct request_queue *blk_alloc_queue_node2(gfp_t gfp_mask, int node_id,
+					    spinlock_t *lock);
 extern void blk_put_queue(struct request_queue *);
 extern void blk_set_queue_dying(struct request_queue *);
 
-- 
2.16.0
