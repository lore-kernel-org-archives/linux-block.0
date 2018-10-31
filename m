Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/30] block: remove legacy rq tagging
Date: Wed, 31 Oct 2018 11:59:10 -0600
Message-Id: <20181031175922.8849-19-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It's now unused, kill it.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/block/biodoc.txt |  88 --------
 block/Makefile                 |   2 +-
 block/blk-core.c               |   6 -
 block/blk-mq-debugfs.c         |   2 -
 block/blk-mq-tag.c             |   6 +-
 block/blk-sysfs.c              |   3 -
 block/blk-tag.c                | 378 ---------------------------------
 include/linux/blkdev.h         |  35 ---
 8 files changed, 3 insertions(+), 517 deletions(-)
 delete mode 100644 block/blk-tag.c

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index 207eca58efaa..ac18b488cb5e 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -65,7 +65,6 @@ Description of Contents:
     3.2.3 I/O completion
     3.2.4 Implications for drivers that do not interpret bios (don't handle
  	  multiple segments)
-    3.2.5 Request command tagging
   3.3 I/O submission
 4. The I/O scheduler
 5. Scalability related changes
@@ -708,93 +707,6 @@ is crossed on completion of a transfer. (The end*request* functions should
 be used if only if the request has come down from block/bio path, not for
 direct access requests which only specify rq->buffer without a valid rq->bio)
 
-3.2.5 Generic request command tagging
-
-3.2.5.1 Tag helpers
-
-Block now offers some simple generic functionality to help support command
-queueing (typically known as tagged command queueing), ie manage more than
-one outstanding command on a queue at any given time.
-
-	blk_queue_init_tags(struct request_queue *q, int depth)
-
-	Initialize internal command tagging structures for a maximum
-	depth of 'depth'.
-
-	blk_queue_free_tags((struct request_queue *q)
-
-	Teardown tag info associated with the queue. This will be done
-	automatically by block if blk_queue_cleanup() is called on a queue
-	that is using tagging.
-
-The above are initialization and exit management, the main helpers during
-normal operations are:
-
-	blk_queue_start_tag(struct request_queue *q, struct request *rq)
-
-	Start tagged operation for this request. A free tag number between
-	0 and 'depth' is assigned to the request (rq->tag holds this number),
-	and 'rq' is added to the internal tag management. If the maximum depth
-	for this queue is already achieved (or if the tag wasn't started for
-	some other reason), 1 is returned. Otherwise 0 is returned.
-
-	blk_queue_end_tag(struct request_queue *q, struct request *rq)
-
-	End tagged operation on this request. 'rq' is removed from the internal
-	book keeping structures.
-
-To minimize struct request and queue overhead, the tag helpers utilize some
-of the same request members that are used for normal request queue management.
-This means that a request cannot both be an active tag and be on the queue
-list at the same time. blk_queue_start_tag() will remove the request, but
-the driver must remember to call blk_queue_end_tag() before signalling
-completion of the request to the block layer. This means ending tag
-operations before calling end_that_request_last()! For an example of a user
-of these helpers, see the IDE tagged command queueing support.
-
-3.2.5.2 Tag info
-
-Some block functions exist to query current tag status or to go from a
-tag number to the associated request. These are, in no particular order:
-
-	blk_queue_tagged(q)
-
-	Returns 1 if the queue 'q' is using tagging, 0 if not.
-
-	blk_queue_tag_request(q, tag)
-
-	Returns a pointer to the request associated with tag 'tag'.
-
-	blk_queue_tag_depth(q)
-	
-	Return current queue depth.
-
-	blk_queue_tag_queue(q)
-
-	Returns 1 if the queue can accept a new queued command, 0 if we are
-	at the maximum depth already.
-
-	blk_queue_rq_tagged(rq)
-
-	Returns 1 if the request 'rq' is tagged.
-
-3.2.5.2 Internal structure
-
-Internally, block manages tags in the blk_queue_tag structure:
-
-	struct blk_queue_tag {
-		struct request **tag_index;	/* array or pointers to rq */
-		unsigned long *tag_map;		/* bitmap of free tags */
-		struct list_head busy_list;	/* fifo list of busy tags */
-		int busy;			/* queue depth */
-		int max_depth;			/* max queue depth */
-	};
-
-Most of the above is simple and straight forward, however busy_list may need
-a bit of explaining. Normally we don't care too much about request ordering,
-but in the event of any barrier requests in the tag queue we need to ensure
-that requests are restarted in the order they were queue.
-
 3.3 I/O Submission
 
 The routine submit_bio() is used to submit a single io. Higher level i/o
diff --git a/block/Makefile b/block/Makefile
index 27eac600474f..213674c8faaa 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel block layer
 #
 
-obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
+obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
diff --git a/block/blk-core.c b/block/blk-core.c
index 5044a1c41493..9e4c791f2fb9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1655,9 +1655,6 @@ void blk_requeue_request(struct request_queue *q, struct request *rq)
 	trace_block_rq_requeue(q, rq);
 	rq_qos_requeue(q, rq);
 
-	if (rq->rq_flags & RQF_QUEUED)
-		blk_queue_end_tag(q, rq);
-
 	BUG_ON(blk_queued_rq(rq));
 
 	elv_requeue_request(q, rq);
@@ -3172,9 +3169,6 @@ void blk_finish_request(struct request *req, blk_status_t error)
 	if (req->rq_flags & RQF_STATS)
 		blk_stat_add(req, now);
 
-	if (req->rq_flags & RQF_QUEUED)
-		blk_queue_end_tag(q, req);
-
 	BUG_ON(blk_queued_rq(req));
 
 	if (unlikely(laptop_mode) && !blk_rq_is_passthrough(req))
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 10b284a1f18d..9ed43a7c70b5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -112,7 +112,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(QUEUED),
 	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(BYPASS),
@@ -318,7 +317,6 @@ static const char *const cmd_flag_name[] = {
 static const char *const rqf_name[] = {
 	RQF_NAME(SORTED),
 	RQF_NAME(STARTED),
-	RQF_NAME(QUEUED),
 	RQF_NAME(SOFTBARRIER),
 	RQF_NAME(FLUSH_SEQ),
 	RQF_NAME(MIXED_MERGE),
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cfda95b85d34..4254e74c1446 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -530,10 +530,8 @@ u32 blk_mq_unique_tag(struct request *rq)
 	struct blk_mq_hw_ctx *hctx;
 	int hwq = 0;
 
-	if (q->mq_ops) {
-		hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
-		hwq = hctx->queue_num;
-	}
+	hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
+	hwq = hctx->queue_num;
 
 	return (hwq << BLK_MQ_UNIQUE_TAG_BITS) |
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0641533597f1..e4fc3bd9c32e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -849,9 +849,6 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_exit_rl(q, &q->root_rl);
 
-	if (q->queue_tags)
-		__blk_queue_free_tags(q);
-
 	blk_queue_free_zone_bitmaps(q);
 
 	if (!q->mq_ops) {
diff --git a/block/blk-tag.c b/block/blk-tag.c
deleted file mode 100644
index fbc153aef166..000000000000
--- a/block/blk-tag.c
+++ /dev/null
@@ -1,378 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Functions related to tagged command queuing
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/slab.h>
-
-#include "blk.h"
-
-/**
- * blk_queue_find_tag - find a request by its tag and queue
- * @q:	 The request queue for the device
- * @tag: The tag of the request
- *
- * Notes:
- *    Should be used when a device returns a tag and you want to match
- *    it with a request.
- *
- *    no locks need be held.
- **/
-struct request *blk_queue_find_tag(struct request_queue *q, int tag)
-{
-	return blk_map_queue_find_tag(q->queue_tags, tag);
-}
-EXPORT_SYMBOL(blk_queue_find_tag);
-
-/**
- * blk_free_tags - release a given set of tag maintenance info
- * @bqt:	the tag map to free
- *
- * Drop the reference count on @bqt and frees it when the last reference
- * is dropped.
- */
-void blk_free_tags(struct blk_queue_tag *bqt)
-{
-	if (atomic_dec_and_test(&bqt->refcnt)) {
-		BUG_ON(find_first_bit(bqt->tag_map, bqt->max_depth) <
-							bqt->max_depth);
-
-		kfree(bqt->tag_index);
-		bqt->tag_index = NULL;
-
-		kfree(bqt->tag_map);
-		bqt->tag_map = NULL;
-
-		kfree(bqt);
-	}
-}
-EXPORT_SYMBOL(blk_free_tags);
-
-/**
- * __blk_queue_free_tags - release tag maintenance info
- * @q:  the request queue for the device
- *
- *  Notes:
- *    blk_cleanup_queue() will take care of calling this function, if tagging
- *    has been used. So there's no need to call this directly.
- **/
-void __blk_queue_free_tags(struct request_queue *q)
-{
-	struct blk_queue_tag *bqt = q->queue_tags;
-
-	if (!bqt)
-		return;
-
-	blk_free_tags(bqt);
-
-	q->queue_tags = NULL;
-	queue_flag_clear_unlocked(QUEUE_FLAG_QUEUED, q);
-}
-
-/**
- * blk_queue_free_tags - release tag maintenance info
- * @q:  the request queue for the device
- *
- *  Notes:
- *	This is used to disable tagged queuing to a device, yet leave
- *	queue in function.
- **/
-void blk_queue_free_tags(struct request_queue *q)
-{
-	queue_flag_clear_unlocked(QUEUE_FLAG_QUEUED, q);
-}
-EXPORT_SYMBOL(blk_queue_free_tags);
-
-static int
-init_tag_map(struct request_queue *q, struct blk_queue_tag *tags, int depth)
-{
-	struct request **tag_index;
-	unsigned long *tag_map;
-	int nr_ulongs;
-
-	if (q && depth > q->nr_requests * 2) {
-		depth = q->nr_requests * 2;
-		printk(KERN_ERR "%s: adjusted depth to %d\n",
-		       __func__, depth);
-	}
-
-	tag_index = kcalloc(depth, sizeof(struct request *), GFP_ATOMIC);
-	if (!tag_index)
-		goto fail;
-
-	nr_ulongs = ALIGN(depth, BITS_PER_LONG) / BITS_PER_LONG;
-	tag_map = kcalloc(nr_ulongs, sizeof(unsigned long), GFP_ATOMIC);
-	if (!tag_map)
-		goto fail;
-
-	tags->real_max_depth = depth;
-	tags->max_depth = depth;
-	tags->tag_index = tag_index;
-	tags->tag_map = tag_map;
-
-	return 0;
-fail:
-	kfree(tag_index);
-	return -ENOMEM;
-}
-
-static struct blk_queue_tag *__blk_queue_init_tags(struct request_queue *q,
-						int depth, int alloc_policy)
-{
-	struct blk_queue_tag *tags;
-
-	tags = kmalloc(sizeof(struct blk_queue_tag), GFP_ATOMIC);
-	if (!tags)
-		goto fail;
-
-	if (init_tag_map(q, tags, depth))
-		goto fail;
-
-	atomic_set(&tags->refcnt, 1);
-	tags->alloc_policy = alloc_policy;
-	tags->next_tag = 0;
-	return tags;
-fail:
-	kfree(tags);
-	return NULL;
-}
-
-/**
- * blk_init_tags - initialize the tag info for an external tag map
- * @depth:	the maximum queue depth supported
- * @alloc_policy: tag allocation policy
- **/
-struct blk_queue_tag *blk_init_tags(int depth, int alloc_policy)
-{
-	return __blk_queue_init_tags(NULL, depth, alloc_policy);
-}
-EXPORT_SYMBOL(blk_init_tags);
-
-/**
- * blk_queue_init_tags - initialize the queue tag info
- * @q:  the request queue for the device
- * @depth:  the maximum queue depth supported
- * @tags: the tag to use
- * @alloc_policy: tag allocation policy
- *
- * Queue lock must be held here if the function is called to resize an
- * existing map.
- **/
-int blk_queue_init_tags(struct request_queue *q, int depth,
-			struct blk_queue_tag *tags, int alloc_policy)
-{
-	int rc;
-
-	BUG_ON(tags && q->queue_tags && tags != q->queue_tags);
-
-	if (!tags && !q->queue_tags) {
-		tags = __blk_queue_init_tags(q, depth, alloc_policy);
-
-		if (!tags)
-			return -ENOMEM;
-
-	} else if (q->queue_tags) {
-		rc = blk_queue_resize_tags(q, depth);
-		if (rc)
-			return rc;
-		queue_flag_set(QUEUE_FLAG_QUEUED, q);
-		return 0;
-	} else
-		atomic_inc(&tags->refcnt);
-
-	/*
-	 * assign it, all done
-	 */
-	q->queue_tags = tags;
-	queue_flag_set_unlocked(QUEUE_FLAG_QUEUED, q);
-	return 0;
-}
-EXPORT_SYMBOL(blk_queue_init_tags);
-
-/**
- * blk_queue_resize_tags - change the queueing depth
- * @q:  the request queue for the device
- * @new_depth: the new max command queueing depth
- *
- *  Notes:
- *    Must be called with the queue lock held.
- **/
-int blk_queue_resize_tags(struct request_queue *q, int new_depth)
-{
-	struct blk_queue_tag *bqt = q->queue_tags;
-	struct request **tag_index;
-	unsigned long *tag_map;
-	int max_depth, nr_ulongs;
-
-	if (!bqt)
-		return -ENXIO;
-
-	/*
-	 * if we already have large enough real_max_depth.  just
-	 * adjust max_depth.  *NOTE* as requests with tag value
-	 * between new_depth and real_max_depth can be in-flight, tag
-	 * map can not be shrunk blindly here.
-	 */
-	if (new_depth <= bqt->real_max_depth) {
-		bqt->max_depth = new_depth;
-		return 0;
-	}
-
-	/*
-	 * Currently cannot replace a shared tag map with a new
-	 * one, so error out if this is the case
-	 */
-	if (atomic_read(&bqt->refcnt) != 1)
-		return -EBUSY;
-
-	/*
-	 * save the old state info, so we can copy it back
-	 */
-	tag_index = bqt->tag_index;
-	tag_map = bqt->tag_map;
-	max_depth = bqt->real_max_depth;
-
-	if (init_tag_map(q, bqt, new_depth))
-		return -ENOMEM;
-
-	memcpy(bqt->tag_index, tag_index, max_depth * sizeof(struct request *));
-	nr_ulongs = ALIGN(max_depth, BITS_PER_LONG) / BITS_PER_LONG;
-	memcpy(bqt->tag_map, tag_map, nr_ulongs * sizeof(unsigned long));
-
-	kfree(tag_index);
-	kfree(tag_map);
-	return 0;
-}
-EXPORT_SYMBOL(blk_queue_resize_tags);
-
-/**
- * blk_queue_end_tag - end tag operations for a request
- * @q:  the request queue for the device
- * @rq: the request that has completed
- *
- *  Description:
- *    Typically called when end_that_request_first() returns %0, meaning
- *    all transfers have been done for a request. It's important to call
- *    this function before end_that_request_last(), as that will put the
- *    request back on the free list thus corrupting the internal tag list.
- **/
-void blk_queue_end_tag(struct request_queue *q, struct request *rq)
-{
-	struct blk_queue_tag *bqt = q->queue_tags;
-	unsigned tag = rq->tag; /* negative tags invalid */
-
-	lockdep_assert_held(q->queue_lock);
-
-	BUG_ON(tag >= bqt->real_max_depth);
-
-	list_del_init(&rq->queuelist);
-	rq->rq_flags &= ~RQF_QUEUED;
-	rq->tag = -1;
-	rq->internal_tag = -1;
-
-	if (unlikely(bqt->tag_index[tag] == NULL))
-		printk(KERN_ERR "%s: tag %d is missing\n",
-		       __func__, tag);
-
-	bqt->tag_index[tag] = NULL;
-
-	if (unlikely(!test_bit(tag, bqt->tag_map))) {
-		printk(KERN_ERR "%s: attempt to clear non-busy tag (%d)\n",
-		       __func__, tag);
-		return;
-	}
-	/*
-	 * The tag_map bit acts as a lock for tag_index[bit], so we need
-	 * unlock memory barrier semantics.
-	 */
-	clear_bit_unlock(tag, bqt->tag_map);
-}
-
-/**
- * blk_queue_start_tag - find a free tag and assign it
- * @q:  the request queue for the device
- * @rq:  the block request that needs tagging
- *
- *  Description:
- *    This can either be used as a stand-alone helper, or possibly be
- *    assigned as the queue &prep_rq_fn (in which case &struct request
- *    automagically gets a tag assigned). Note that this function
- *    assumes that any type of request can be queued! if this is not
- *    true for your device, you must check the request type before
- *    calling this function.  The request will also be removed from
- *    the request queue, so it's the drivers responsibility to readd
- *    it if it should need to be restarted for some reason.
- **/
-int blk_queue_start_tag(struct request_queue *q, struct request *rq)
-{
-	struct blk_queue_tag *bqt = q->queue_tags;
-	unsigned max_depth;
-	int tag;
-
-	lockdep_assert_held(q->queue_lock);
-
-	if (unlikely((rq->rq_flags & RQF_QUEUED))) {
-		printk(KERN_ERR
-		       "%s: request %p for device [%s] already tagged %d",
-		       __func__, rq,
-		       rq->rq_disk ? rq->rq_disk->disk_name : "?", rq->tag);
-		BUG();
-	}
-
-	/*
-	 * Protect against shared tag maps, as we may not have exclusive
-	 * access to the tag map.
-	 *
-	 * We reserve a few tags just for sync IO, since we don't want
-	 * to starve sync IO on behalf of flooding async IO.
-	 */
-	max_depth = bqt->max_depth;
-	if (!rq_is_sync(rq) && max_depth > 1) {
-		switch (max_depth) {
-		case 2:
-			max_depth = 1;
-			break;
-		case 3:
-			max_depth = 2;
-			break;
-		default:
-			max_depth -= 2;
-		}
-		if (q->in_flight[BLK_RW_ASYNC] > max_depth)
-			return 1;
-	}
-
-	do {
-		if (bqt->alloc_policy == BLK_TAG_ALLOC_FIFO) {
-			tag = find_first_zero_bit(bqt->tag_map, max_depth);
-			if (tag >= max_depth)
-				return 1;
-		} else {
-			int start = bqt->next_tag;
-			int size = min_t(int, bqt->max_depth, max_depth + start);
-			tag = find_next_zero_bit(bqt->tag_map, size, start);
-			if (tag >= size && start + size > bqt->max_depth) {
-				size = start + size - bqt->max_depth;
-				tag = find_first_zero_bit(bqt->tag_map, size);
-			}
-			if (tag >= size)
-				return 1;
-		}
-
-	} while (test_and_set_bit_lock(tag, bqt->tag_map));
-	/*
-	 * We need lock ordering semantics given by test_and_set_bit_lock.
-	 * See blk_queue_end_tag for details.
-	 */
-
-	bqt->next_tag = (tag + 1) % bqt->max_depth;
-	rq->rq_flags |= RQF_QUEUED;
-	rq->tag = tag;
-	bqt->tag_index[tag] = rq;
-	blk_start_request(rq);
-	return 0;
-}
-EXPORT_SYMBOL(blk_queue_start_tag);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6baea6563364..8afe3331777e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -85,8 +85,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_SORTED		((__force req_flags_t)(1 << 0))
 /* drive already may have started this one */
 #define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* uses tagged queueing */
-#define RQF_QUEUED		((__force req_flags_t)(1 << 2))
 /* may not be passed by ioscheduler */
 #define RQF_SOFTBARRIER		((__force req_flags_t)(1 << 3))
 /* request for flush sequence */
@@ -336,15 +334,6 @@ enum blk_queue_state {
 	Queue_up,
 };
 
-struct blk_queue_tag {
-	struct request **tag_index;	/* map of busy tags */
-	unsigned long *tag_map;		/* bit map of free/busy tags */
-	int max_depth;			/* what we will send to device */
-	int real_max_depth;		/* what the array can hold */
-	atomic_t refcnt;		/* map can be shared */
-	int alloc_policy;		/* tag allocation policy */
-	int next_tag;			/* next tag */
-};
 #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
 #define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
 
@@ -568,8 +557,6 @@ struct request_queue {
 	unsigned int		dma_pad_mask;
 	unsigned int		dma_alignment;
 
-	struct blk_queue_tag	*queue_tags;
-
 	unsigned int		nr_sorted;
 	unsigned int		in_flight[2];
 
@@ -680,7 +667,6 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-#define QUEUE_FLAG_QUEUED	0	/* uses generic tag queueing */
 #define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 #define QUEUE_FLAG_DYING	2	/* queue being torn down */
 #define QUEUE_FLAG_BYPASS	3	/* act as dumb FIFO queue */
@@ -724,7 +710,6 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 
-#define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
@@ -1359,26 +1344,6 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 		 !list_empty(&plug->cb_list));
 }
 
-/*
- * tag stuff
- */
-extern int blk_queue_start_tag(struct request_queue *, struct request *);
-extern struct request *blk_queue_find_tag(struct request_queue *, int);
-extern void blk_queue_end_tag(struct request_queue *, struct request *);
-extern int blk_queue_init_tags(struct request_queue *, int, struct blk_queue_tag *, int);
-extern void blk_queue_free_tags(struct request_queue *);
-extern int blk_queue_resize_tags(struct request_queue *, int);
-extern struct blk_queue_tag *blk_init_tags(int, int);
-extern void blk_free_tags(struct blk_queue_tag *);
-
-static inline struct request *blk_map_queue_find_tag(struct blk_queue_tag *bqt,
-						int tag)
-{
-	if (unlikely(bqt == NULL || tag >= bqt->real_max_depth))
-		return NULL;
-	return bqt->tag_index[tag];
-}
-
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
-- 
2.17.1
