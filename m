Return-Path: <prvs=1157cbc043=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 7/7] blk-mq-sched: allow setting of default IO scheduler
Date: Wed, 14 Dec 2016 22:26:08 -0700
Message-ID: <1481779568-10642-8-git-send-email-axboe@fb.com>
In-Reply-To: <1481779568-10642-1-git-send-email-axboe@fb.com>
References: <1481779568-10642-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Kconfig.iosched   | 43 +++++++++++++++++++++++++++++++++++++------
 block/blk-mq-sched.c    | 19 +++++++++++++++++++
 block/blk-mq-sched.h    |  2 ++
 block/blk-mq.c          |  3 +++
 block/elevator.c        |  5 ++++-
 drivers/nvme/host/pci.c |  1 +
 include/linux/blk-mq.h  |  1 +
 7 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 490ef2850fae..96216cf18560 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -32,12 +32,6 @@ config IOSCHED_CFQ
 
 	  This is the default I/O scheduler.
 
-config MQ_IOSCHED_DEADLINE
-	tristate "MQ deadline I/O scheduler"
-	default y
-	---help---
-	  MQ version of the deadline IO scheduler.
-
 config CFQ_GROUP_IOSCHED
 	bool "CFQ Group Scheduling support"
 	depends on IOSCHED_CFQ && BLK_CGROUP
@@ -69,6 +63,43 @@ config DEFAULT_IOSCHED
 	default "cfq" if DEFAULT_CFQ
 	default "noop" if DEFAULT_NOOP
 
+config MQ_IOSCHED_DEADLINE
+	tristate "MQ deadline I/O scheduler"
+	default y
+	---help---
+	  MQ version of the deadline IO scheduler.
+
+config MQ_IOSCHED_NONE
+	bool
+	default y
+
+choice
+	prompt "Default MQ I/O scheduler"
+	default MQ_IOSCHED_NONE
+	help
+	  Select the I/O scheduler which will be used by default for all
+	  blk-mq managed block devices.
+
+	config DEFAULT_MQ_DEADLINE
+		bool "MQ Deadline" if MQ_IOSCHED_DEADLINE=y
+
+	config DEFAULT_MQ_NONE
+		bool "None"
+
+endchoice
+
+config DEFAULT_MQ_IOSCHED
+	string
+	default "mq-deadline" if DEFAULT_MQ_DEADLINE
+	default "none" if DEFAULT_MQ_NONE
+
+config MQ_IOSCHED_ONLY_SQ
+	bool "Enable blk-mq IO scheduler only for single queue devices"
+	default y
+	help
+	  Say Y here, if you only want to enable IO scheduling on block
+	  devices that have a single queue registered.
+
 endmenu
 
 endif
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 02ad17258666..606d519b42ee 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -373,3 +373,22 @@ void blk_mq_sched_request_inserted(struct request *rq)
 	trace_block_rq_insert(rq->q, rq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
+
+int blk_mq_sched_init(struct request_queue *q)
+{
+	int ret;
+
+#if defined(CONFIG_DEFAULT_MQ_NONE)
+	return 0;
+#endif
+#if defined(CONFIG_MQ_IOSCHED_ONLY_SQ)
+	if (q->nr_hw_queues > 1)
+		return 0;
+#endif
+
+	mutex_lock(&q->sysfs_lock);
+	ret = elevator_init(q, NULL);
+	mutex_unlock(&q->sysfs_lock);
+
+	return ret;
+}
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index b68dccc0190e..e398412d3fcf 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -28,6 +28,8 @@ void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 
+int blk_mq_sched_init(struct request_queue *q);
+
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 static inline bool
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d10a246a3bc7..48c28e1cb42a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2101,6 +2101,9 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
+	if (!(set->flags & BLK_MQ_F_NO_SCHED))
+		blk_mq_sched_init(q);
+
 	if (q->nr_hw_queues > 1)
 		blk_queue_make_request(q, blk_mq_make_request);
 	else
diff --git a/block/elevator.c b/block/elevator.c
index 6d39197768c1..7ad906689833 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -219,7 +219,10 @@ int elevator_init(struct request_queue *q, char *name)
 	}
 
 	if (!e) {
-		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+		if (q->mq_ops)
+			e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
+		else
+			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d6e6bce93d0c..063410d9b3cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1188,6 +1188,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 73b58b5be6e0..5fffccf3b95f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -152,6 +152,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.7.4
