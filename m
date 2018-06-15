Return-Path: <prvs=697b38d23=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH 5/5] block: Make struct request_queue smaller for CONFIG_BLK_DEV_ZONED=n
Date: Fri, 15 Jun 2018 14:55:21 -0700
Message-Id: <20180615215521.27435-6-bart.vanassche@wdc.com>
In-Reply-To: <20180615215521.27435-1-bart.vanassche@wdc.com>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Exclude zoned block device members from struct request_queue for
CONFIG_BLK_DEV_ZONED == n. Avoid breaking the build by only building
the code that uses these struct request_queue members if
CONFIG_BLK_DEV_ZONED != n.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig                |  4 ++++
 block/Makefile               |  1 +
 block/blk-mq-debugfs-zoned.c | 24 ++++++++++++++++++++++++
 block/blk-mq-debugfs.c       | 15 ---------------
 block/blk-mq-debugfs.h       |  9 +++++++++
 include/linux/blkdev.h       |  6 ++++++
 6 files changed, 44 insertions(+), 15 deletions(-)
 create mode 100644 block/blk-mq-debugfs-zoned.c

diff --git a/block/Kconfig b/block/Kconfig
index 28ec55752b68..0514f0b61226 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -177,6 +177,10 @@ config BLK_DEBUG_FS
 	Unless you are building a kernel for a tiny system, you should
 	say Y here.
 
+config BLK_DEBUG_FS_ZONED
+       bool
+       default BLK_DEBUG_FS && BLK_DEV_ZONED
+
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
 	---help---
diff --git a/block/Makefile b/block/Makefile
index 6a56303b9925..a8f94cdb75c3 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -34,4 +34,5 @@ obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
+obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
diff --git a/block/blk-mq-debugfs-zoned.c b/block/blk-mq-debugfs-zoned.c
new file mode 100644
index 000000000000..fb2c82c351e4
--- /dev/null
+++ b/block/blk-mq-debugfs-zoned.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Western Digital Corporation or its affiliates.
+ *
+ * This file is released under the GPL.
+ */
+
+#include <linux/blkdev.h>
+#include "blk-mq-debugfs.h"
+
+int queue_zone_wlock_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	unsigned int i;
+
+	if (!q->seq_zones_wlock)
+		return 0;
+
+	for (i = 0; i < q->nr_zones; i++)
+		if (test_bit(i, q->seq_zones_wlock))
+			seq_printf(m, "%u\n", i);
+
+	return 0;
+}
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b92ef4c3038e..9907e6610656 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -206,21 +206,6 @@ static ssize_t queue_write_hint_store(void *data, const char __user *buf,
 	return count;
 }
 
-static int queue_zone_wlock_show(void *data, struct seq_file *m)
-{
-	struct request_queue *q = data;
-	unsigned int i;
-
-	if (!q->seq_zones_wlock)
-		return 0;
-
-	for (i = 0; i < q->nr_zones; i++)
-		if (test_bit(i, q->seq_zones_wlock))
-			seq_printf(m, "%u\n", i);
-
-	return 0;
-}
-
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index b3342d8dc934..d287638b2c6a 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -81,4 +81,13 @@ static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hc
 }
 #endif
 
+#ifdef CONFIG_BLK_DEBUG_FS_ZONED
+int queue_zone_wlock_show(void *data, struct seq_file *m);
+#else
+static inline int queue_zone_wlock_show(void *data, struct seq_file *m)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 96640bcd5e78..f7c8dcd3127c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -589,6 +589,7 @@ struct request_queue {
 
 	struct queue_limits	limits;
 
+#ifdef CONFIG_BLK_DEV_ZONED
 	/*
 	 * Zoned block device information for request dispatch control.
 	 * nr_zones is the total number of zones of the device. This is always
@@ -609,6 +610,7 @@ struct request_queue {
 	unsigned int		nr_zones;
 	unsigned long		*seq_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 	/*
 	 * sg stuff
@@ -800,6 +802,7 @@ static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
@@ -815,6 +818,7 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 		return false;
 	return test_bit(blk_queue_zone_no(q, sector), q->seq_zones_bitmap);
 }
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 static inline bool rq_is_sync(struct request *rq)
 {
@@ -1073,6 +1077,7 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 	return blk_rq_cur_bytes(rq) >> SECTOR_SHIFT;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int blk_rq_zone_no(struct request *rq)
 {
 	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));
@@ -1082,6 +1087,7 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 {
 	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
 }
+#endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
  * Some commands like WRITE SAME have a payload or data transfer size which
-- 
2.17.0
