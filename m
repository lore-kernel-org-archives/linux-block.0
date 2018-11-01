Return-Path: <khlebnikov@yandex-team.ru>
Subject: [PATCH RFC] blk-mq: initialize default elevator after probing
 device features
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Paolo Valente <paolo.valente@linaro.org>, linux-kernel@vger.kernel.org
Date: Thu, 01 Nov 2018 20:43:18 +0300
Message-ID: <154109419854.925678.9824971245018007905.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

For SATA and SCSI devices features like rotational/non-rotational flag
are detected via requests to VPD pages in asynchronous probe.
During probing queue works in bypass mode without using elevator.

This patch postpones initialization of elevator to use this information
for choosing default elevator or its default configuration.

Old stack theoretically could do the same but it has some paths where
q->elevator expected to be always non-null regardless of bypass mode.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-mq.c    |    8 --------
 block/blk-sysfs.c |   11 +++++++++++
 block/elevator.c  |   18 +++++++++---------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..889797b4313e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2719,14 +2719,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
 
-	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		int ret;
-
-		ret = elevator_init_mq(q);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
 	return q;
 
 err_hctxs:
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0641533597f1..201ef5b69ace 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -909,6 +909,17 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
+
+	/*
+	 * Initialize default elevator after probing device features.
+	 */
+	if (q->mq_ops) {
+		WARN_ON_ONCE(!blk_queue_bypass(q));
+		ret = elevator_init_mq(q);
+		if (ret)
+			return ret;
+	}
+
 	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
 
 	/*
diff --git a/block/elevator.c b/block/elevator.c
index 8fdcd64ae12e..953c8ca4f5bf 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -172,6 +172,14 @@ void __init load_default_elevator_module(void)
 
 static struct kobj_type elv_ktype;
 
+static inline bool elv_support_iosched(struct request_queue *q)
+{
+	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
+				BLK_MQ_F_NO_SCHED))
+		return false;
+	return true;
+}
+
 struct elevator_queue *elevator_alloc(struct request_queue *q,
 				  struct elevator_type *e)
 {
@@ -957,7 +965,7 @@ int elevator_init_mq(struct request_queue *q)
 	struct elevator_type *e;
 	int err = 0;
 
-	if (q->nr_hw_queues != 1)
+	if (q->nr_hw_queues != 1 || !elv_support_iosched(q))
 		return 0;
 
 	/*
@@ -1089,14 +1097,6 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	return elevator_switch(q, e);
 }
 
-static inline bool elv_support_iosched(struct request_queue *q)
-{
-	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
-				BLK_MQ_F_NO_SCHED))
-		return false;
-	return true;
-}
-
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {
