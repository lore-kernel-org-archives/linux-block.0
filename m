Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22142 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755141AbeCHBKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Mar 2018 20:10:17 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 11/11] block: Move the queue_flag_*() functions from a public into a private header file
Date: Wed,  7 Mar 2018 17:10:12 -0800
Message-Id: <20180308011012.31522-12-bart.vanassche@wdc.com>
In-Reply-To: <20180308011012.31522-1-bart.vanassche@wdc.com>
References: <20180308011012.31522-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch helps to avoid that new code gets introduced in block drivers
that manipulates queue flags without holding the queue lock when that
lock should be held.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h            | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h | 69 --------------------------------------------------
 2 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 46db5dc83dcb..b034fd2460c4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -41,6 +41,75 @@ extern struct kmem_cache *request_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
+/*
+ * @q->queue_lock is set while a queue is being initialized. Since we know
+ * that no other threads access the queue object before @q->queue_lock has
+ * been set, it is safe to manipulate queue flags without holding the
+ * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
+ * blk_init_allocated_queue().
+ */
+static inline void queue_lockdep_assert_held(struct request_queue *q)
+{
+	if (q->queue_lock)
+		lockdep_assert_held(q->queue_lock);
+}
+
+static inline void queue_flag_set_unlocked(unsigned int flag,
+					   struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
+	    kref_read(&q->kobj.kref))
+		lockdep_assert_held(q->queue_lock);
+	__set_bit(flag, &q->queue_flags);
+}
+
+static inline void queue_flag_clear_unlocked(unsigned int flag,
+					     struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
+	    kref_read(&q->kobj.kref))
+		lockdep_assert_held(q->queue_lock);
+	__clear_bit(flag, &q->queue_flags);
+}
+
+static inline int queue_flag_test_and_clear(unsigned int flag,
+					    struct request_queue *q)
+{
+	queue_lockdep_assert_held(q);
+
+	if (test_bit(flag, &q->queue_flags)) {
+		__clear_bit(flag, &q->queue_flags);
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline int queue_flag_test_and_set(unsigned int flag,
+					  struct request_queue *q)
+{
+	queue_lockdep_assert_held(q);
+
+	if (!test_bit(flag, &q->queue_flags)) {
+		__set_bit(flag, &q->queue_flags);
+		return 0;
+	}
+
+	return 1;
+}
+
+static inline void queue_flag_set(unsigned int flag, struct request_queue *q)
+{
+	queue_lockdep_assert_held(q);
+	__set_bit(flag, &q->queue_flags);
+}
+
+static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
+{
+	queue_lockdep_assert_held(q);
+	__clear_bit(flag, &q->queue_flags);
+}
+
 static inline struct blk_flush_queue *blk_get_flush_queue(
 		struct request_queue *q, struct blk_mq_ctx *ctx)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1f3ec9a7fbc7..478c1845c179 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -710,75 +710,6 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 
-/*
- * @q->queue_lock is set while a queue is being initialized. Since we know
- * that no other threads access the queue object before @q->queue_lock has
- * been set, it is safe to manipulate queue flags without holding the
- * queue_lock if @q->queue_lock == NULL. See also blk_alloc_queue_node() and
- * blk_init_allocated_queue().
- */
-static inline void queue_lockdep_assert_held(struct request_queue *q)
-{
-	if (q->queue_lock)
-		lockdep_assert_held(q->queue_lock);
-}
-
-static inline void queue_flag_set_unlocked(unsigned int flag,
-					   struct request_queue *q)
-{
-	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
-	    kref_read(&q->kobj.kref))
-		lockdep_assert_held(q->queue_lock);
-	__set_bit(flag, &q->queue_flags);
-}
-
-static inline void queue_flag_clear_unlocked(unsigned int flag,
-					     struct request_queue *q)
-{
-	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
-	    kref_read(&q->kobj.kref))
-		lockdep_assert_held(q->queue_lock);
-	__clear_bit(flag, &q->queue_flags);
-}
-
-static inline int queue_flag_test_and_clear(unsigned int flag,
-					    struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-
-	if (test_bit(flag, &q->queue_flags)) {
-		__clear_bit(flag, &q->queue_flags);
-		return 1;
-	}
-
-	return 0;
-}
-
-static inline int queue_flag_test_and_set(unsigned int flag,
-					  struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-
-	if (!test_bit(flag, &q->queue_flags)) {
-		__set_bit(flag, &q->queue_flags);
-		return 0;
-	}
-
-	return 1;
-}
-
-static inline void queue_flag_set(unsigned int flag, struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-	__set_bit(flag, &q->queue_flags);
-}
-
-static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
-{
-	queue_lockdep_assert_held(q);
-	__clear_bit(flag, &q->queue_flags);
-}
-
 #define blk_queue_tagged(q)	test_bit(QUEUE_FLAG_QUEUED, &(q)->queue_flags)
 #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
-- 
2.16.2
