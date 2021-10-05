Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E68C433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6D16115A
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhJEPbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbhJEPbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:31:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBFC061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:29:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z184so11605325iof.5
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wq+oqbY3OXbYU4xoktRAbf0Sc2U0Pk/eJhj5zJYmGs=;
        b=6XpJF8Sg5sABri8YlrUVSLxME9a3eQhqYTdqh3dvGx6DDObDDXDlFzhBlV7Dxhyab3
         3M0z6nqYp/kkg9+NDu4ap3Lvsy5opOvftMQ88XaHu3fCe0TY67iZzqmU9pKcvCf7eS72
         fpvIs4i6GyVE2Q4+8F/MdRDsiIlBHW8Z/ivNsG+3o6FYc8HKB9bPuTXq2mVLzx3ncwRd
         lypDQowiIFhWgsjZC/DVJ1TMd1ab1WS4OvaAPkihtOgdmPwV0PQD1IDRHH6C9dAAB4aA
         8rzH8hR5h9K15PAhW3V2k9X+FUm6jLCqE9Nhm0ALsimNoeaABN5balMbJrBhSyiRbwvl
         ErsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wq+oqbY3OXbYU4xoktRAbf0Sc2U0Pk/eJhj5zJYmGs=;
        b=moMCbqGrDQjde3POkoZyjQzwuoDHunzgBDpfmDQPA0Ctq/vjuMgzWim7CL4OLoU2SJ
         /4ZGlGrcn+nSf64r0LLwQu76vvx1SvC89O84nRFEFQ2+GpWKcHYK4+VHJHyzXDYrerG8
         gzqXjwXswZ3HdZ/EBEPiS+d6oegjtQtjXfvkgcrjFxbCeXMdyEXjkqGgRuYj70qDPrRK
         AH3l8K0l4xFa9KcqlWqCbGltFZyAiOYzktsVY3rKny7GArwUoKikITC2kWYxJ1uCD4Gn
         HnxK5cxvQ2L1X0ApBMm386YcxVtWLFa92B+xYTKCHaWSU5gwtYpdUj1qHb3IA9E2ayH9
         FOvQ==
X-Gm-Message-State: AOAM5323AEMm5VYBav2PSutrZShzo2UYbUasvBe2wgp61rN/S1ffG7/x
        5GqO8MRun+UFAuyXE6k3z7mIXM04ezatmX8zwks=
X-Google-Smtp-Source: ABdhPJxALz9/N3Gzk56KSnFl0e+Pez5q3bkLmqFZqsDLkfuX6my8ML+BuNYTJxeYW38bG7ZDA1YsLA==
X-Received: by 2002:a02:5444:: with SMTP id t65mr3318148jaa.42.1633447766766;
        Tue, 05 Oct 2021 08:29:26 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m5sm6317762ild.45.2021.10.05.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:29:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     tj@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: move blk-throtl fast path inline
Date:   Tue,  5 Oct 2021 09:29:21 -0600
Message-Id: <20211005152922.57326-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005152922.57326-1-axboe@kernel.dk>
References: <20211005152922.57326-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even if no policies are defined, we spend ~2% of the total IO time
checking. Move the fast path inline.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c   |   1 +
 block/blk-core.c     |   1 +
 block/blk-merge.c    |   1 +
 block/blk-sysfs.c    |   1 +
 block/blk-throttle.c | 161 +-------------------------------------
 block/blk-throttle.h | 182 +++++++++++++++++++++++++++++++++++++++++++
 block/blk.h          |  16 ----
 7 files changed, 189 insertions(+), 174 deletions(-)
 create mode 100644 block/blk-throttle.h

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 38b9f7684952..eb48090eefce 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,6 +32,7 @@
 #include <linux/psi.h>
 #include "blk.h"
 #include "blk-ioprio.h"
+#include "blk-throttle.h"
 
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
diff --git a/block/blk-core.c b/block/blk-core.c
index 532c817525de..d83e56b2f64e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -51,6 +51,7 @@
 #include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 struct dentry *blk_debugfs_root;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5b4f23014df8..bf7aedaad8f8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -13,6 +13,7 @@
 
 #include "blk.h"
 #include "blk-rq-qos.h"
+#include "blk-throttle.h"
 
 static inline bool bio_will_gap(struct request_queue *q,
 		struct request *prev_rq, struct bio *prev, struct bio *next)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 614d9d47de36..da883efcba33 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -17,6 +17,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-wbt.h"
+#include "blk-throttle.h"
 
 struct queue_sysfs_entry {
 	struct attribute attr;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 7c4e7993ba97..8cefd14deed5 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -13,6 +13,7 @@
 #include <linux/blk-cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
+#include "blk-throttle.h"
 
 /* Max dispatch from a group in 1 round */
 #define THROTL_GRP_QUANTUM 8
@@ -37,60 +38,9 @@
  */
 #define LATENCY_FILTERED_HD (1000L) /* 1ms */
 
-static struct blkcg_policy blkcg_policy_throtl;
-
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
 
-/*
- * To implement hierarchical throttling, throtl_grps form a tree and bios
- * are dispatched upwards level by level until they reach the top and get
- * issued.  When dispatching bios from the children and local group at each
- * level, if the bios are dispatched into a single bio_list, there's a risk
- * of a local or child group which can queue many bios at once filling up
- * the list starving others.
- *
- * To avoid such starvation, dispatched bios are queued separately
- * according to where they came from.  When they are again dispatched to
- * the parent, they're popped in round-robin order so that no single source
- * hogs the dispatch window.
- *
- * throtl_qnode is used to keep the queued bios separated by their sources.
- * Bios are queued to throtl_qnode which in turn is queued to
- * throtl_service_queue and then dispatched in round-robin order.
- *
- * It's also used to track the reference counts on blkg's.  A qnode always
- * belongs to a throtl_grp and gets queued on itself or the parent, so
- * incrementing the reference of the associated throtl_grp when a qnode is
- * queued and decrementing when dequeued is enough to keep the whole blkg
- * tree pinned while bios are in flight.
- */
-struct throtl_qnode {
-	struct list_head	node;		/* service_queue->queued[] */
-	struct bio_list		bios;		/* queued bios */
-	struct throtl_grp	*tg;		/* tg this qnode belongs to */
-};
-
-struct throtl_service_queue {
-	struct throtl_service_queue *parent_sq;	/* the parent service_queue */
-
-	/*
-	 * Bios queued directly to this service_queue or dispatched from
-	 * children throtl_grp's.
-	 */
-	struct list_head	queued[2];	/* throtl_qnode [READ/WRITE] */
-	unsigned int		nr_queued[2];	/* number of queued bios */
-
-	/*
-	 * RB tree of active children throtl_grp's, which are sorted by
-	 * their ->disptime.
-	 */
-	struct rb_root_cached	pending_tree;	/* RB tree of active tgs */
-	unsigned int		nr_pending;	/* # queued in the tree */
-	unsigned long		first_pending_disptime;	/* disptime of the first tg */
-	struct timer_list	pending_timer;	/* fires on first_pending_disptime */
-};
-
 enum tg_state_flags {
 	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
 	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
@@ -98,93 +48,6 @@ enum tg_state_flags {
 
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
-enum {
-	LIMIT_LOW,
-	LIMIT_MAX,
-	LIMIT_CNT,
-};
-
-struct throtl_grp {
-	/* must be the first member */
-	struct blkg_policy_data pd;
-
-	/* active throtl group service_queue member */
-	struct rb_node rb_node;
-
-	/* throtl_data this group belongs to */
-	struct throtl_data *td;
-
-	/* this group's service queue */
-	struct throtl_service_queue service_queue;
-
-	/*
-	 * qnode_on_self is used when bios are directly queued to this
-	 * throtl_grp so that local bios compete fairly with bios
-	 * dispatched from children.  qnode_on_parent is used when bios are
-	 * dispatched from this throtl_grp into its parent and will compete
-	 * with the sibling qnode_on_parents and the parent's
-	 * qnode_on_self.
-	 */
-	struct throtl_qnode qnode_on_self[2];
-	struct throtl_qnode qnode_on_parent[2];
-
-	/*
-	 * Dispatch time in jiffies. This is the estimated time when group
-	 * will unthrottle and is ready to dispatch more bio. It is used as
-	 * key to sort active groups in service tree.
-	 */
-	unsigned long disptime;
-
-	unsigned int flags;
-
-	/* are there any throtl rules between this group and td? */
-	bool has_rules[2];
-
-	/* internally used bytes per second rate limits */
-	uint64_t bps[2][LIMIT_CNT];
-	/* user configured bps limits */
-	uint64_t bps_conf[2][LIMIT_CNT];
-
-	/* internally used IOPS limits */
-	unsigned int iops[2][LIMIT_CNT];
-	/* user configured IOPS limits */
-	unsigned int iops_conf[2][LIMIT_CNT];
-
-	/* Number of bytes dispatched in current slice */
-	uint64_t bytes_disp[2];
-	/* Number of bio's dispatched in current slice */
-	unsigned int io_disp[2];
-
-	unsigned long last_low_overflow_time[2];
-
-	uint64_t last_bytes_disp[2];
-	unsigned int last_io_disp[2];
-
-	unsigned long last_check_time;
-
-	unsigned long latency_target; /* us */
-	unsigned long latency_target_conf; /* us */
-	/* When did we start a new slice */
-	unsigned long slice_start[2];
-	unsigned long slice_end[2];
-
-	unsigned long last_finish_time; /* ns / 1024 */
-	unsigned long checked_last_finish_time; /* ns / 1024 */
-	unsigned long avg_idletime; /* ns / 1024 */
-	unsigned long idletime_threshold; /* us */
-	unsigned long idletime_threshold_conf; /* us */
-
-	unsigned int bio_cnt; /* total bios */
-	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
-	unsigned long bio_cnt_reset_time;
-
-	atomic_t io_split_cnt[2];
-	atomic_t last_io_split_cnt[2];
-
-	struct blkg_rwstat stat_bytes;
-	struct blkg_rwstat stat_ios;
-};
-
 /* We measure latency for request size from <= 4k to >= 1M */
 #define LATENCY_BUCKET_SIZE 9
 
@@ -231,16 +94,6 @@ struct throtl_data
 
 static void throtl_pending_timer_fn(struct timer_list *t);
 
-static inline struct throtl_grp *pd_to_tg(struct blkg_policy_data *pd)
-{
-	return pd ? container_of(pd, struct throtl_grp, pd) : NULL;
-}
-
-static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
-{
-	return pd_to_tg(blkg_to_pd(blkg, &blkcg_policy_throtl));
-}
-
 static inline struct blkcg_gq *tg_to_blkg(struct throtl_grp *tg)
 {
 	return pd_to_blkg(&tg->pd);
@@ -1794,7 +1647,7 @@ static void throtl_shutdown_wq(struct request_queue *q)
 	cancel_work_sync(&td->dispatch_work);
 }
 
-static struct blkcg_policy blkcg_policy_throtl = {
+struct blkcg_policy blkcg_policy_throtl = {
 	.dfl_cftypes		= throtl_files,
 	.legacy_cftypes		= throtl_legacy_files,
 
@@ -2208,7 +2061,7 @@ void blk_throtl_charge_bio_split(struct bio *bio)
 	} while (parent);
 }
 
-bool blk_throtl_bio(struct bio *bio)
+bool __blk_throtl_bio(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	struct blkcg_gq *blkg = bio->bi_blkg;
@@ -2221,19 +2074,12 @@ bool blk_throtl_bio(struct bio *bio)
 
 	rcu_read_lock();
 
-	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED))
-		goto out;
-
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
 		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 	}
 
-	if (!tg->has_rules[rw])
-		goto out;
-
 	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
@@ -2317,7 +2163,6 @@ bool blk_throtl_bio(struct bio *bio)
 
 out_unlock:
 	spin_unlock_irq(&q->queue_lock);
-out:
 	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
new file mode 100644
index 000000000000..175f03abd9e4
--- /dev/null
+++ b/block/blk-throttle.h
@@ -0,0 +1,182 @@
+#ifndef BLK_THROTTLE_H
+#define BLK_THROTTLE_H
+
+#include "blk-cgroup-rwstat.h"
+
+/*
+ * To implement hierarchical throttling, throtl_grps form a tree and bios
+ * are dispatched upwards level by level until they reach the top and get
+ * issued.  When dispatching bios from the children and local group at each
+ * level, if the bios are dispatched into a single bio_list, there's a risk
+ * of a local or child group which can queue many bios at once filling up
+ * the list starving others.
+ *
+ * To avoid such starvation, dispatched bios are queued separately
+ * according to where they came from.  When they are again dispatched to
+ * the parent, they're popped in round-robin order so that no single source
+ * hogs the dispatch window.
+ *
+ * throtl_qnode is used to keep the queued bios separated by their sources.
+ * Bios are queued to throtl_qnode which in turn is queued to
+ * throtl_service_queue and then dispatched in round-robin order.
+ *
+ * It's also used to track the reference counts on blkg's.  A qnode always
+ * belongs to a throtl_grp and gets queued on itself or the parent, so
+ * incrementing the reference of the associated throtl_grp when a qnode is
+ * queued and decrementing when dequeued is enough to keep the whole blkg
+ * tree pinned while bios are in flight.
+ */
+struct throtl_qnode {
+	struct list_head	node;		/* service_queue->queued[] */
+	struct bio_list		bios;		/* queued bios */
+	struct throtl_grp	*tg;		/* tg this qnode belongs to */
+};
+
+struct throtl_service_queue {
+	struct throtl_service_queue *parent_sq;	/* the parent service_queue */
+
+	/*
+	 * Bios queued directly to this service_queue or dispatched from
+	 * children throtl_grp's.
+	 */
+	struct list_head	queued[2];	/* throtl_qnode [READ/WRITE] */
+	unsigned int		nr_queued[2];	/* number of queued bios */
+
+	/*
+	 * RB tree of active children throtl_grp's, which are sorted by
+	 * their ->disptime.
+	 */
+	struct rb_root_cached	pending_tree;	/* RB tree of active tgs */
+	unsigned int		nr_pending;	/* # queued in the tree */
+	unsigned long		first_pending_disptime;	/* disptime of the first tg */
+	struct timer_list	pending_timer;	/* fires on first_pending_disptime */
+};
+
+enum {
+	LIMIT_LOW,
+	LIMIT_MAX,
+	LIMIT_CNT,
+};
+
+struct throtl_grp {
+	/* must be the first member */
+	struct blkg_policy_data pd;
+
+	/* active throtl group service_queue member */
+	struct rb_node rb_node;
+
+	/* throtl_data this group belongs to */
+	struct throtl_data *td;
+
+	/* this group's service queue */
+	struct throtl_service_queue service_queue;
+
+	/*
+	 * qnode_on_self is used when bios are directly queued to this
+	 * throtl_grp so that local bios compete fairly with bios
+	 * dispatched from children.  qnode_on_parent is used when bios are
+	 * dispatched from this throtl_grp into its parent and will compete
+	 * with the sibling qnode_on_parents and the parent's
+	 * qnode_on_self.
+	 */
+	struct throtl_qnode qnode_on_self[2];
+	struct throtl_qnode qnode_on_parent[2];
+
+	/*
+	 * Dispatch time in jiffies. This is the estimated time when group
+	 * will unthrottle and is ready to dispatch more bio. It is used as
+	 * key to sort active groups in service tree.
+	 */
+	unsigned long disptime;
+
+	unsigned int flags;
+
+	/* are there any throtl rules between this group and td? */
+	bool has_rules[2];
+
+	/* internally used bytes per second rate limits */
+	uint64_t bps[2][LIMIT_CNT];
+	/* user configured bps limits */
+	uint64_t bps_conf[2][LIMIT_CNT];
+
+	/* internally used IOPS limits */
+	unsigned int iops[2][LIMIT_CNT];
+	/* user configured IOPS limits */
+	unsigned int iops_conf[2][LIMIT_CNT];
+
+	/* Number of bytes dispatched in current slice */
+	uint64_t bytes_disp[2];
+	/* Number of bio's dispatched in current slice */
+	unsigned int io_disp[2];
+
+	unsigned long last_low_overflow_time[2];
+
+	uint64_t last_bytes_disp[2];
+	unsigned int last_io_disp[2];
+
+	unsigned long last_check_time;
+
+	unsigned long latency_target; /* us */
+	unsigned long latency_target_conf; /* us */
+	/* When did we start a new slice */
+	unsigned long slice_start[2];
+	unsigned long slice_end[2];
+
+	unsigned long last_finish_time; /* ns / 1024 */
+	unsigned long checked_last_finish_time; /* ns / 1024 */
+	unsigned long avg_idletime; /* ns / 1024 */
+	unsigned long idletime_threshold; /* us */
+	unsigned long idletime_threshold_conf; /* us */
+
+	unsigned int bio_cnt; /* total bios */
+	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
+	unsigned long bio_cnt_reset_time;
+
+	atomic_t io_split_cnt[2];
+	atomic_t last_io_split_cnt[2];
+
+	struct blkg_rwstat stat_bytes;
+	struct blkg_rwstat stat_ios;
+};
+
+extern struct blkcg_policy blkcg_policy_throtl;
+
+static inline struct throtl_grp *pd_to_tg(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct throtl_grp, pd) : NULL;
+}
+
+static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
+{
+	return pd_to_tg(blkg_to_pd(blkg, &blkcg_policy_throtl));
+}
+
+/*
+ * Internal throttling interface
+ */
+#ifndef CONFIG_BLK_DEV_THROTTLING
+static inline int blk_throtl_init(struct request_queue *q) { return 0; }
+static inline void blk_throtl_exit(struct request_queue *q) { }
+static inline void blk_throtl_register_queue(struct request_queue *q) { }
+static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
+static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+#else /* CONFIG_BLK_DEV_THROTTLING */
+int blk_throtl_init(struct request_queue *q);
+void blk_throtl_exit(struct request_queue *q);
+void blk_throtl_register_queue(struct request_queue *q);
+void blk_throtl_charge_bio_split(struct bio *bio);
+bool __blk_throtl_bio(struct bio *bio);
+static inline bool blk_throtl_bio(struct bio *bio)
+{
+	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
+
+	if (bio_flagged(bio, BIO_THROTTLED))
+		return false;
+	if (!tg->has_rules[bio_data_dir(bio)])
+		return false;
+
+	return __blk_throtl_bio(bio);
+}
+#endif /* CONFIG_BLK_DEV_THROTTLING */
+
+#endif
diff --git a/block/blk.h b/block/blk.h
index 762af963b302..21283541a99f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -323,22 +323,6 @@ void ioc_clear_queue(struct request_queue *q);
 
 int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, int node);
 
-/*
- * Internal throttling interface
- */
-#ifdef CONFIG_BLK_DEV_THROTTLING
-extern int blk_throtl_init(struct request_queue *q);
-extern void blk_throtl_exit(struct request_queue *q);
-extern void blk_throtl_register_queue(struct request_queue *q);
-extern void blk_throtl_charge_bio_split(struct bio *bio);
-bool blk_throtl_bio(struct bio *bio);
-#else /* CONFIG_BLK_DEV_THROTTLING */
-static inline int blk_throtl_init(struct request_queue *q) { return 0; }
-static inline void blk_throtl_exit(struct request_queue *q) { }
-static inline void blk_throtl_register_queue(struct request_queue *q) { }
-static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
-static inline bool blk_throtl_bio(struct bio *bio) { return false; }
-#endif /* CONFIG_BLK_DEV_THROTTLING */
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
-- 
2.33.0

