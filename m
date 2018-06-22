Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] block: add helper interface blk_queue_registered
Date: Fri, 22 Jun 2018 15:11:18 +0800
Message-Id: <1529651480-1734-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Add blk_queue_registered to check whether QUEUE_FLAG_REGISTERED
is set. And also replace the positions where test it with test_bit
directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-sysfs.c      | 4 ++--
 block/blk-wbt.c        | 2 +-
 block/elevator.c       | 2 +-
 include/linux/blkdev.h | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 94987b1..159c586 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -863,7 +863,7 @@ int blk_register_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return -ENXIO;
 
-	WARN_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags),
+	WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
 	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
@@ -940,7 +940,7 @@ void blk_unregister_queue(struct gendisk *disk)
 		return;
 
 	/* Return early if disk->queue was never registered. */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return;
 
 	/*
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 4f89b28..43ae265 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -707,7 +707,7 @@ void wbt_enable_default(struct request_queue *q)
 		return;
 
 	/* Queue not registered? Maybe shutting down... */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return;
 
 	if ((q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ)) ||
diff --git a/block/elevator.c b/block/elevator.c
index fa828b5..a574841 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1084,7 +1084,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	struct elevator_type *e;
 
 	/* Make sure queue is not in the middle of being removed */
-	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+	if (!blk_queue_registered(q))
 		return -ENOENT;
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 37511c4..d6174ed 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -740,6 +740,9 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 
+#define blk_queue_registered(q) \
+	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
+
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-- 
2.7.4
