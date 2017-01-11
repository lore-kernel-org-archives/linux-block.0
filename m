Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754806AbdAKVkS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 16:40:18 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <osandov@osandov.com>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 10/10] blk-mq-sched: allow setting of default IO scheduler
Date: Wed, 11 Jan 2017 14:40:03 -0700
Message-ID: <1484170803-9311-11-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add Kconfig entries to manage what devices get assigned an MQ
scheduler, and add a blk-mq flag for drivers to opt out of scheduling.
The latter is useful for admin type queues that still allocate a blk-mq
queue and tag set, but aren't use for normal IO.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Kconfig.iosched   | 56 +++++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq-sched.c    | 20 ++++++++++++++++++
 block/blk-mq-sched.h    |  2 ++
 block/blk-mq.c          |  8 +++++++
 block/elevator.c        |  8 ++++++-
 drivers/nvme/host/pci.c |  1 +
 include/linux/blk-mq.h  |  1 +
 7 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 490ef2850fae..0715ce93daef 100644
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
@@ -69,6 +63,56 @@ config DEFAULT_IOSCHED
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
+	prompt "Default single-queue blk-mq I/O scheduler"
+	default DEFAULT_SQ_NONE
+	help
+	  Select the I/O scheduler which will be used by default for blk-mq
+	  managed block devices with a single queue.
+
+	config DEFAULT_SQ_DEADLINE
+		bool "MQ Deadline" if MQ_IOSCHED_DEADLINE=y
+
+	config DEFAULT_SQ_NONE
+		bool "None"
+
+endchoice
+
+config DEFAULT_SQ_IOSCHED
+	string
+	default "mq-deadline" if DEFAULT_SQ_DEADLINE
+	default "none" if DEFAULT_SQ_NONE
+
+choice
+	prompt "Default multi-queue blk-mq I/O scheduler"
+	default DEFAULT_MQ_NONE
+	help
+	  Select the I/O scheduler which will be used by default for blk-mq
+	  managed block devices with multiple queues.
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
 endmenu
 
 endif
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 44cf30eb1589..26e9e20f67ce 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -332,3 +332,23 @@ int blk_mq_sched_teardown(struct request_queue *q)
 
 	return 0;
 }
+
+int blk_mq_sched_init(struct request_queue *q)
+{
+	int ret;
+
+#if defined(CONFIG_DEFAULT_SQ_NONE)
+	if (q->nr_hw_queues == 1)
+		return 0;
+#endif
+#if defined(CONFIG_DEFAULT_MQ_NONE)
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
index 68d6a202b827..77859eae19c9 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -25,6 +25,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 int blk_mq_sched_setup(struct request_queue *q);
 int blk_mq_sched_teardown(struct request_queue *q);
 
+int blk_mq_sched_init(struct request_queue *q);
+
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3180b5fac88c..0dcd593e4ddd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2227,6 +2227,14 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	mutex_unlock(&all_q_mutex);
 	put_online_cpus();
 
+	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
+		int ret;
+
+		ret = blk_mq_sched_init(q);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return q;
 
 err_hctxs:
diff --git a/block/elevator.c b/block/elevator.c
index 79e74da26343..b3ea721e51b4 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -219,7 +219,13 @@ int elevator_init(struct request_queue *q, char *name)
 	}
 
 	if (!e) {
-		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+		if (q->mq_ops && q->nr_hw_queues == 1)
+			e = elevator_get(CONFIG_DEFAULT_SQ_IOSCHED, false);
+		else if (q->mq_ops)
+			e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
+		else
+			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 19beeb7b2ac2..e1b4e603b1cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1181,6 +1181,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 63569eb46d15..8e4df3d6c8cd 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -153,6 +153,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.7.4

