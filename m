Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1D8C77B7E
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjDRWke (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjDRWkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:31 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B69A27A
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:29 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-63d4595d60fso3034956b3a.0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857628; x=1684449628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W40Ig18bb0AgO/lsQlauFUXtXH7+eOGjmvW1cjt/fOQ=;
        b=lgchuIcUiHYoSBeQVCuG/XbQDB2pYY9/EwEXhbYnHGfY6ro2zkP2X8vDyc4PZQCadC
         64z9QH/GY4BlJsnmnjbhEHU+sUD+/npJSn3rt3UtYzYYUCouM9PdolaWdHtK/1f1hYkE
         bak32CdufZcSOCAlRbFYh2M2cW3VViz3cAMS7ygOZ6GXHDIbucaJkXK/CDqlHc2D8KfF
         m/l0uyl5K1hDHj2Rk1ultGQ8Bxc18gYnn5hqjRUJuzTkrOy+5zCfzEEcBmNEYwO9rtl5
         u8g9cRAsa0VZUuBPd4N243sWik0apL7G0IKzFzSY/Ex+fD4xldSET7aO9AIymuzeTbBe
         Kjjg==
X-Gm-Message-State: AAQBX9ecMEG3h0frJQoZ+3d8yPYM/jFoj1HHiiujqXXcThgNOc8B9gf5
        aDBarvjQN4VR+m1xLdielL1bzLm4gQE=
X-Google-Smtp-Source: AKy350ZsENQX5B9yzIZ6hVDubnk23BhvXxbtJrdFqrzI+5NlKQGmaLUPHDI7ntMQ54rsJKsslvVMIA==
X-Received: by 2002:a17:902:b184:b0:1a6:6bd4:cd8c with SMTP id s4-20020a170902b18400b001a66bd4cd8cmr267285plr.25.1681857628479;
        Tue, 18 Apr 2023 15:40:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 11/11] block: mq-deadline: Respect the active zone limit
Date:   Tue, 18 Apr 2023 15:40:02 -0700
Message-ID: <20230418224002.1195163-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some zoned block devices restrict the number of active zones. Attempts
to exceed the number of active zones fail with
BLK_STS_ZONE_ACTIVE_RESOURCE. Prevent that data loss happens if a
filesystem is using a zoned block device by restricting the number of
active zones in the mq-deadline I/O scheduler.

This patch prevents that the following pattern triggers write errors:
* Data is written sequentially. The number of data streams is identical to
  the maximum number of active zones.
* Per stream, writes for a new zone are queued before the previous zone
  is full.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig.iosched     |   4 ++
 block/Makefile            |   1 +
 block/mq-deadline-zoned.c | 146 ++++++++++++++++++++++++++++++++++++++
 block/mq-deadline-zoned.h |  33 +++++++++
 block/mq-deadline.c       | 117 ++++++++++++------------------
 block/mq-deadline.h       |  81 +++++++++++++++++++++
 include/linux/blkdev.h    |  11 +++
 7 files changed, 320 insertions(+), 73 deletions(-)
 create mode 100644 block/mq-deadline-zoned.c
 create mode 100644 block/mq-deadline-zoned.h
 create mode 100644 block/mq-deadline.h

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 27f11320b8d1..604edd5da8d8 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -4,9 +4,13 @@ menu "IO Schedulers"
 config MQ_IOSCHED_DEADLINE
 	tristate "MQ deadline I/O scheduler"
 	default y
+	select MQ_IOSCHED_DEADLINE_ZONED if BLK_DEV_ZONED
 	help
 	  MQ version of the deadline IO scheduler.
 
+config MQ_IOSCHED_DEADLINE_ZONED
+	bool
+
 config MQ_IOSCHED_KYBER
 	tristate "Kyber I/O scheduler"
 	default y
diff --git a/block/Makefile b/block/Makefile
index b31b05390749..a685035ac325 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
 obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
+obj-$(CONFIG_MQ_IOSCHED_DEADLINE_ZONED)	+= mq-deadline-zoned.o
 obj-$(CONFIG_MQ_IOSCHED_KYBER)	+= kyber-iosched.o
 bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
diff --git a/block/mq-deadline-zoned.c b/block/mq-deadline-zoned.c
new file mode 100644
index 000000000000..fe42e27dad41
--- /dev/null
+++ b/block/mq-deadline-zoned.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Google LLC <bvanassche@google.com>
+ */
+
+#include <linux/blk-mq.h>
+#include <linux/hashtable.h>
+#include <linux/lockdep.h>
+#include "mq-deadline.h"
+#include "mq-deadline-zoned.h"
+
+struct dd_zone {
+	struct hlist_node entry; /* Bucket list entry */
+	unsigned int zno; /* Zone number */
+	sector_t start; /* First sector of zone */
+	sector_t end; /* First sector past zone capacity */
+	sector_t wp; /* Write pointer */
+};
+
+static struct dd_zone *dd_find_zone(struct deadline_data *dd,
+				    struct request *rq)
+{
+	unsigned int zno = blk_rq_zone_no(rq);
+	struct dd_zone *zone;
+
+	lockdep_assert_held(&dd->lock);
+
+	hash_for_each_possible(dd->active_zones, zone, entry, zno)
+		if (zone->zno == zno)
+			return zone;
+
+	return NULL;
+}
+
+static struct dd_zone *dd_find_add_zone(struct deadline_data *dd,
+					struct request *rq)
+{
+	const struct queue_limits *lim = &rq->q->limits;
+	struct dd_zone *zone;
+	unsigned int zno;
+
+	lockdep_assert_held(&dd->lock);
+
+	zone = dd_find_zone(dd, rq);
+	if (zone)
+		return zone;
+	zone = kzalloc(sizeof(*zone), GFP_ATOMIC);
+	if (WARN_ON_ONCE(!zone))
+		return zone;
+	zno = blk_rq_zone_no(rq);
+	zone->zno = zno;
+	zone->start = zno * lim->chunk_sectors;
+	zone->end = zone->start + lim->zone_capacity;
+	hash_add(dd->active_zones, &zone->entry, zno);
+	return zone;
+}
+
+unsigned int dd_active_zones(struct deadline_data *dd)
+{
+	struct dd_zone *zone;
+	unsigned int bkt, n = 0;
+
+	lockdep_assert_held(&dd->lock);
+
+	hash_for_each(dd->active_zones, bkt, zone, entry)
+		n++;
+
+	return n;
+}
+
+/*
+ * Returns true if and only if dispatching request @rq won't cause the active
+ * zones limit to be exceeded.
+ */
+bool dd_check_zone(struct deadline_data *dd, struct request *rq)
+{
+	unsigned int zno = blk_rq_zone_no(rq);
+	struct dd_zone *zone;
+
+	lockdep_assert_held(&dd->lock);
+
+	if (rq->q->disk->max_active_zones == 0)
+		return true;
+
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ZONE_APPEND:
+		break;
+	default:
+		return true;
+	}
+
+	hash_for_each_possible(dd->active_zones, zone, entry, zno)
+		if (zone->zno == zno)
+			return true; /* zone already open */
+
+	/* zone is empty or closed */
+	return dd_active_zones(dd) < rq->q->disk->max_active_zones;
+}
+
+void dd_update_wp(struct deadline_data *dd, struct request *rq,
+		  sector_t completed)
+{
+	struct dd_zone *zone;
+
+	lockdep_assert_held(&dd->lock);
+
+	if (WARN_ON_ONCE(rq->q->disk->max_active_zones == 0))
+		return;
+
+	switch (req_op(rq)) {
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ZONE_APPEND:
+		zone = dd_find_add_zone(dd, rq);
+		if (!zone)
+			return;
+		zone->wp = blk_rq_pos(rq) + completed;
+		if (zone->wp < zone->end)
+			return;
+		hash_del(&zone->entry);
+		kfree(zone);
+		break;
+	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_RESET:
+		zone = dd_find_zone(dd, rq);
+		if (!zone)
+			return;
+		hash_del(&zone->entry);
+		kfree(zone);
+		break;
+	case REQ_OP_ZONE_RESET_ALL: {
+		struct hlist_node *tmp;
+		unsigned int bkt;
+
+		hash_for_each_safe(dd->active_zones, bkt, tmp, zone, entry) {
+			hash_del(&zone->entry);
+			kfree(zone);
+		}
+		break;
+	}
+	default:
+		break;
+	}
+}
diff --git a/block/mq-deadline-zoned.h b/block/mq-deadline-zoned.h
new file mode 100644
index 000000000000..614c83e3f95a
--- /dev/null
+++ b/block/mq-deadline-zoned.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _MQ_DEADLINE_ZONED_H_
+#define _MQ_DEADLINE_ZONED_H_
+
+#include <linux/types.h>
+
+struct deadline_data;
+struct request;
+
+#ifdef CONFIG_BLK_DEV_ZONED
+bool dd_check_zone(struct deadline_data *dd, struct request *rq);
+void dd_update_wp(struct deadline_data *dd, struct request *rq,
+		  sector_t completed);
+unsigned int dd_active_zones(struct deadline_data *dd);
+#else
+static inline bool dd_check_zone(struct deadline_data *dd, struct request *rq)
+{
+	return true;
+}
+
+static inline void dd_update_wp(struct deadline_data *dd, struct request *rq,
+				sector_t completed)
+{
+}
+
+static inline unsigned int dd_active_zones(struct deadline_data *dd)
+{
+	return 0;
+}
+#endif
+
+#endif /* _MQ_DEADLINE_ZONED_H_ */
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 4d2bfb3898b0..e8609e1a58dd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/hashtable.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -23,6 +24,8 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
+#include "mq-deadline.h"
+#include "mq-deadline-zoned.h"
 
 /*
  * See Documentation/block/deadline-iosched.rst
@@ -38,73 +41,6 @@ static const int writes_starved = 2;    /* max times reads can starve a write */
 static const int fifo_batch = 16;       /* # of sequential requests treated as one
 				     by the above parameters. For throughput. */
 
-enum dd_data_dir {
-	DD_READ		= READ,
-	DD_WRITE	= WRITE,
-};
-
-enum { DD_DIR_COUNT = 2 };
-
-enum dd_prio {
-	DD_RT_PRIO	= 0,
-	DD_BE_PRIO	= 1,
-	DD_IDLE_PRIO	= 2,
-	DD_PRIO_MAX	= 2,
-};
-
-enum { DD_PRIO_COUNT = 3 };
-
-/*
- * I/O statistics per I/O priority. It is fine if these counters overflow.
- * What matters is that these counters are at least as wide as
- * log2(max_outstanding_requests).
- */
-struct io_stats_per_prio {
-	uint32_t inserted;
-	uint32_t merged;
-	uint32_t dispatched;
-	atomic_t completed;
-};
-
-/*
- * Deadline scheduler data per I/O priority (enum dd_prio). Requests are
- * present on both sort_list[] and fifo_list[].
- */
-struct dd_per_prio {
-	struct list_head dispatch;
-	struct rb_root sort_list[DD_DIR_COUNT];
-	struct list_head fifo_list[DD_DIR_COUNT];
-	/* Next request in FIFO order. Read, write or both are NULL. */
-	struct request *next_rq[DD_DIR_COUNT];
-	struct io_stats_per_prio stats;
-};
-
-struct deadline_data {
-	/*
-	 * run time data
-	 */
-
-	struct dd_per_prio per_prio[DD_PRIO_COUNT];
-
-	/* Data direction of latest dispatched request. */
-	enum dd_data_dir last_dir;
-	unsigned int batching;		/* number of sequential requests made */
-	unsigned int starved;		/* times reads have starved writes */
-
-	/*
-	 * settings that change how the i/o scheduler behaves
-	 */
-	int fifo_expire[DD_DIR_COUNT];
-	int fifo_batch;
-	int writes_starved;
-	int front_merges;
-	u32 async_depth;
-	int prio_aging_expire;
-
-	spinlock_t lock;
-	spinlock_t zone_lock;
-};
-
 /* Maps an I/O priority class to a deadline scheduler priority. */
 static const enum dd_prio ioprio_class_to_prio[] = {
 	[IOPRIO_CLASS_NONE]	= DD_BE_PRIO,
@@ -459,7 +395,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	if (!list_empty(&per_prio->dispatch)) {
 		rq = list_first_entry(&per_prio->dispatch, struct request,
 				      queuelist);
-		if (started_after(dd, rq, latest_start))
+		if (started_after(dd, rq, latest_start) ||
+		    !dd_check_zone(dd, rq))
 			return NULL;
 		list_del_init(&rq->queuelist);
 		goto done;
@@ -469,6 +406,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * batches are currently reads XOR writes
 	 */
 	rq = deadline_next_request(dd, per_prio, dd->last_dir);
+	if (rq && !dd_check_zone(dd, rq))
+		return NULL;
 	if (rq && dd->batching < dd->fifo_batch)
 		/* we have a next request are still entitled to batch */
 		goto dispatch_request;
@@ -512,13 +451,16 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	 * we are not running a batch, find best request for selected data_dir
 	 */
 	next_rq = deadline_next_request(dd, per_prio, data_dir);
-	if (deadline_check_fifo(per_prio, data_dir) || !next_rq) {
+	if (deadline_check_fifo(per_prio, data_dir) || !next_rq ||
+	    !dd_check_zone(dd, next_rq)) {
 		/*
 		 * A deadline has expired, the last request was in the other
 		 * direction, or we have run out of higher-sectored requests.
 		 * Start again from the request with the earliest expiry time.
 		 */
 		rq = deadline_fifo_request(dd, per_prio, data_dir);
+		if (rq && !dd_check_zone(dd, rq))
+			rq = NULL;
 	} else {
 		/*
 		 * The last req was the same dir and we have a next request in
@@ -538,6 +480,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	dd->batching = 0;
 
 dispatch_request:
+	WARN_ON_ONCE(!dd_check_zone(dd, rq));
 	if (started_after(dd, rq, latest_start))
 		return NULL;
 
@@ -604,7 +547,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
-		goto unlock;
+		goto update_wp;
 
 	/*
 	 * Next, dispatch requests in priority order. Ignore lower priority
@@ -616,7 +559,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 			break;
 	}
 
-unlock:
+update_wp:
+	if (rq && disk_max_active_zones(rq->q->disk))
+		dd_update_wp(dd, rq, 0);
+
 	spin_unlock(&dd->lock);
 
 	return rq;
@@ -722,6 +668,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	dd->prio_aging_expire = prio_aging_expire;
+	hash_init(dd->active_zones);
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
 
@@ -919,6 +866,7 @@ static void dd_finish_request(struct request *rq)
 	const u8 ioprio_class = dd_rq_ioclass(rq);
 	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	unsigned long flags;
 
 	/*
 	 * The block layer core may call dd_finish_request() without having
@@ -930,9 +878,16 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
-		unsigned long flags;
+	if (disk_max_active_zones(rq->q->disk)) {
+		spin_lock_irqsave(&dd->lock, flags);
+		dd_update_wp(dd, rq, blk_rq_sectors(rq));
+		spin_unlock_irqrestore(&dd->lock, flags);
 
+		if (dd_has_write_work(rq->mq_hctx))
+			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);
+	}
+
+	if (blk_queue_is_zoned(q)) {
 		spin_lock_irqsave(&dd->zone_lock, flags);
 		blk_req_zone_write_unlock(rq);
 		spin_unlock_irqrestore(&dd->zone_lock, flags);
@@ -1132,6 +1087,21 @@ static int dd_queued_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int dd_active_zones_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+	unsigned int n;
+
+	spin_lock(&dd->lock);
+	n = dd_active_zones(dd);
+	spin_unlock(&dd->lock);
+
+	seq_printf(m, "%u\n", n);
+
+	return 0;
+}
+
 /* Number of requests owned by the block driver for a given priority. */
 static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
 {
@@ -1230,6 +1200,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	{"dispatch2", 0400, .seq_ops = &deadline_dispatch2_seq_ops},
 	{"owned_by_driver", 0400, dd_owned_by_driver_show},
 	{"queued", 0400, dd_queued_show},
+	{"active_zones", 0400, dd_active_zones_show},
 	{},
 };
 #undef DEADLINE_QUEUE_DDIR_ATTRS
diff --git a/block/mq-deadline.h b/block/mq-deadline.h
new file mode 100644
index 000000000000..98a3e9c43931
--- /dev/null
+++ b/block/mq-deadline.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _MQ_DEADLINE_H_
+#define _MQ_DEADLINE_H_
+
+#include <linux/hashtable.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock_types.h>
+
+enum dd_data_dir {
+	DD_READ		= READ,
+	DD_WRITE	= WRITE,
+};
+
+enum { DD_DIR_COUNT = 2 };
+
+enum dd_prio {
+	DD_RT_PRIO	= 0,
+	DD_BE_PRIO	= 1,
+	DD_IDLE_PRIO	= 2,
+	DD_PRIO_MAX	= 2,
+};
+
+enum { DD_PRIO_COUNT = 3 };
+
+/*
+ * I/O statistics per I/O priority. It is fine if these counters overflow.
+ * What matters is that these counters are at least as wide as
+ * log2(max_outstanding_requests).
+ */
+struct io_stats_per_prio {
+	uint32_t inserted;
+	uint32_t merged;
+	uint32_t dispatched;
+	atomic_t completed;
+};
+
+/*
+ * Deadline scheduler data per I/O priority (enum dd_prio). Requests are
+ * present on both sort_list[] and fifo_list[].
+ */
+struct dd_per_prio {
+	struct list_head dispatch;
+	struct rb_root sort_list[DD_DIR_COUNT];
+	struct list_head fifo_list[DD_DIR_COUNT];
+	/* Next request in FIFO order. Read, write or both are NULL. */
+	struct request *next_rq[DD_DIR_COUNT];
+	struct io_stats_per_prio stats;
+};
+
+struct deadline_data {
+	/*
+	 * run time data
+	 */
+
+	struct dd_per_prio per_prio[DD_PRIO_COUNT];
+
+	/* Data direction of latest dispatched request. */
+	enum dd_data_dir last_dir;
+	unsigned int batching;		/* number of sequential requests made */
+	unsigned int starved;		/* times reads have starved writes */
+
+	/*
+	 * settings that change how the i/o scheduler behaves
+	 */
+	int fifo_expire[DD_DIR_COUNT];
+	int fifo_batch;
+	int writes_starved;
+	int front_merges;
+	u32 async_depth;
+	int prio_aging_expire;
+
+	DECLARE_HASHTABLE(active_zones, 8);
+
+	spinlock_t lock;
+	spinlock_t zone_lock;
+};
+
+#endif /* _MQ_DEADLINE_H_ */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4fb0e6d7fdc8..6d7ec5d9841c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -686,6 +686,11 @@ static inline void disk_set_max_active_zones(struct gendisk *disk,
 	disk->max_active_zones = max_active_zones;
 }
 
+static inline unsigned int disk_max_active_zones(const struct gendisk *disk)
+{
+	return disk->max_active_zones;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return bdev->bd_disk->max_open_zones;
@@ -709,6 +714,12 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	return 0;
 }
+
+static inline unsigned int disk_max_active_zones(const struct gendisk *disk)
+{
+	return 0;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return 0;
