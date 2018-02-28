Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65085 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933476AbeB1T2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 14:28:25 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/11] block: Introduce blk_queue_flag_{set,clear,test_and_{set,clear}}()
Date: Wed, 28 Feb 2018 11:28:15 -0800
Message-Id: <20180228192823.5191-4-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Introduce functions that modify the queue flags and that protect
these modifications with the request queue lock. Except for moving
one wake_up_all() call from inside to outside a critical section,
this patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 91 +++++++++++++++++++++++++++++++++++++++++---------
 block/blk-mq.c         | 12 ++-----
 block/blk-settings.c   |  6 ++--
 block/blk-sysfs.c      | 22 ++++--------
 block/blk-timeout.c    |  6 ++--
 include/linux/blkdev.h |  5 +++
 6 files changed, 93 insertions(+), 49 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1d6b4b0545aa..475b8926a616 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -72,6 +72,78 @@ struct kmem_cache *blk_requestq_cachep;
  */
 static struct workqueue_struct *kblockd_workqueue;
 
+/**
+ * blk_queue_flag_set - atomically set a queue flag
+ * @flag: flag to be set
+ * @q: request queue
+ */
+void blk_queue_flag_set(unsigned int flag, struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	queue_flag_set(flag, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL(blk_queue_flag_set);
+
+/**
+ * blk_queue_flag_clear - atomically clear a queue flag
+ * @flag: flag to be cleared
+ * @q: request queue
+ */
+void blk_queue_flag_clear(unsigned int flag, struct request_queue *q)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	queue_flag_clear(flag, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+EXPORT_SYMBOL(blk_queue_flag_clear);
+
+/**
+ * blk_queue_flag_test_and_set - atomically test and set a queue flag
+ * @flag: flag to be set
+ * @q: request queue
+ *
+ * Returns the previous value of @flag - 0 if the flag was not set and 1 if
+ * the flag was already set.
+ */
+bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q)
+{
+	unsigned long flags;
+	bool res;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	res = queue_flag_test_and_set(flag, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_set);
+
+/**
+ * blk_queue_flag_test_and_clear - atomically test and clear a queue flag
+ * @flag: flag to be cleared
+ * @q: request queue
+ *
+ * Returns the previous value of @flag - 0 if the flag was not set and 1 if
+ * the flag was set.
+ */
+bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q)
+{
+	unsigned long flags;
+	bool res;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	res = queue_flag_test_and_clear(flag, q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(blk_queue_flag_test_and_clear);
+
 static void blk_clear_congested(struct request_list *rl, int sync)
 {
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -362,25 +434,14 @@ EXPORT_SYMBOL(blk_sync_queue);
  */
 int blk_set_preempt_only(struct request_queue *q)
 {
-	unsigned long flags;
-	int res;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	res = queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
-	return res;
+	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
 }
 EXPORT_SYMBOL_GPL(blk_set_preempt_only);
 
 void blk_clear_preempt_only(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
 	wake_up_all(&q->mq_freeze_wq);
-	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
 
@@ -630,9 +691,7 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_end);
 
 void blk_set_queue_dying(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
-	queue_flag_set(QUEUE_FLAG_DYING, q);
-	spin_unlock_irq(q->queue_lock);
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
 	/*
 	 * When queue DYING flag is set, we need to block new req
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 96baa6511c1e..67026494119b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -198,11 +198,7 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -243,11 +239,7 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 
 	/* dispatch requests which are inserted during quiescing */
 	blk_mq_run_hw_queues(q, true);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 7f719da0eadd..d1de71124656 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -859,12 +859,10 @@ EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 
 void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
 {
-	spin_lock_irq(q->queue_lock);
 	if (queueable)
-		queue_flag_clear(QUEUE_FLAG_FLUSH_NQ, q);
+		blk_queue_flag_clear(QUEUE_FLAG_FLUSH_NQ, q);
 	else
-		queue_flag_set(QUEUE_FLAG_FLUSH_NQ, q);
-	spin_unlock_irq(q->queue_lock);
+		blk_queue_flag_set(QUEUE_FLAG_FLUSH_NQ, q);
 }
 EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 49bc4aa8d1fc..f8457d6f0190 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -276,12 +276,10 @@ queue_store_##name(struct request_queue *q, const char *page, size_t count) \
 	if (neg)							\
 		val = !val;						\
 									\
-	spin_lock_irq(q->queue_lock);					\
 	if (val)							\
-		queue_flag_set(QUEUE_FLAG_##flag, q);			\
+		blk_queue_flag_set(QUEUE_FLAG_##flag, q);		\
 	else								\
-		queue_flag_clear(QUEUE_FLAG_##flag, q);			\
-	spin_unlock_irq(q->queue_lock);					\
+		blk_queue_flag_clear(QUEUE_FLAG_##flag, q);		\
 	return ret;							\
 }
 
@@ -414,12 +412,10 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	if (ret < 0)
 		return ret;
 
-	spin_lock_irq(q->queue_lock);
 	if (poll_on)
-		queue_flag_set(QUEUE_FLAG_POLL, q);
+		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
 	else
-		queue_flag_clear(QUEUE_FLAG_POLL, q);
-	spin_unlock_irq(q->queue_lock);
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
 
 	return ret;
 }
@@ -487,12 +483,10 @@ static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 	if (set == -1)
 		return -EINVAL;
 
-	spin_lock_irq(q->queue_lock);
 	if (set)
-		queue_flag_set(QUEUE_FLAG_WC, q);
+		blk_queue_flag_set(QUEUE_FLAG_WC, q);
 	else
-		queue_flag_clear(QUEUE_FLAG_WC, q);
-	spin_unlock_irq(q->queue_lock);
+		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
 
 	return count;
 }
@@ -948,9 +942,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	mutex_lock(&q->sysfs_lock);
 
-	spin_lock_irq(q->queue_lock);
-	queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
-	spin_unlock_irq(q->queue_lock);
+	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
 
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index d35ad737e8b0..a5b06eeb3874 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -57,12 +57,10 @@ ssize_t part_timeout_store(struct device *dev, struct device_attribute *attr,
 		char *p = (char *) buf;
 
 		val = simple_strtoul(p, &p, 10);
-		spin_lock_irq(q->queue_lock);
 		if (val)
-			queue_flag_set(QUEUE_FLAG_FAIL_IO, q);
+			blk_queue_flag_set(QUEUE_FLAG_FAIL_IO, q);
 		else
-			queue_flag_clear(QUEUE_FLAG_FAIL_IO, q);
-		spin_unlock_irq(q->queue_lock);
+			blk_queue_flag_clear(QUEUE_FLAG_FAIL_IO, q);
 	}
 
 	return count;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e1e2a06559dc..eca31d0ef2df 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -705,6 +705,11 @@ struct request_queue {
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
 				 (1 << QUEUE_FLAG_POLL))
 
+void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
+void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
+bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
+bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
+
 /*
  * @q->queue_lock is set while a queue is being initialized. Since we know
  * that no other threads access the queue object before @q->queue_lock has
-- 
2.16.2
