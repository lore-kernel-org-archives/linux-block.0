Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD70C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 07:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiCNH7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiCNH7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 03:59:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFD4198C;
        Mon, 14 Mar 2022 00:57:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s42so13626301pfg.0;
        Mon, 14 Mar 2022 00:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=08sZu6COebjXXB/cr8nrSOsukIgpm81uIttgLhaC5ko=;
        b=VF+pRw1Rh2433TCVbwqFl+sr7BMdmWN8E5mTSoExtlxzZFey1Y5az0CIcrQ3stFMN/
         zvJRAYQwvAxhqyIM7Q5tLBzMo3pk04CqUDd+eMKCE94Sirff5zhhSqC1hMn4tE/Svhoo
         KSeJlRA+yfhmdRBoz+Pk7onNjvwB1N5G1v4iQ2voaG4eA/KHrrnEZFkOjxp7but5dqls
         EkweFJ546IlqXlY98yzSt0/vHyXkJdM14PRHTJdhYQPQcczDj5EJkm+ghI1SJnRYwuOc
         R1PXg1JNxPq25S+a1n7Op94NkuHlhcCS9W6B3XMAuZl7d7w7mExM8JgpAtnFww/FyoGu
         /qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=08sZu6COebjXXB/cr8nrSOsukIgpm81uIttgLhaC5ko=;
        b=uAIay55LigoqaAM6BegK/DrjDnWPrM1ucXVnhZ4kdzTzd/iWTI8sNmPDrlMsFYHLgC
         l1RMqNxkA3NN1+mGT1eZxa3Yae+gKBw2qo0G/IRTVymApYkPfAz6zxVDXg3hpxgIrvDD
         34fV9yiidOaAr5V779MT0pigbcfU9pRUnFH5C6DzjXTe16+c1GrDSikbEd+Tf1M5waoE
         SOqGLkgWEeQqP6+0Ib6xlIpVEnmQg0nZti6RrKBXfm/7M4K064zEau+6TCi+vSsk+L1P
         Sa/ehjPJE6mzMQ+g7nVsd06V07+b07Ol4Dj9sen3/5buNE0IeiK/Kg9izl00NhXq772M
         Qj9w==
X-Gm-Message-State: AOAM530i0fjdu7qp6Fpi0En//pKj/zttJRzYi8qniptWxq/egbJxEkPY
        o6VsuVK4a8Lg1Z1mC+nvpCIhxVCiae1hFw==
X-Google-Smtp-Source: ABdhPJyQOwQ1V3MSuJzqD5y1wDrSSDDTu3dGtMeqvOFIUH5lgFti1hsS/bWPki+bntX4NNBBGVw5/A==
X-Received: by 2002:a63:4d60:0:b0:36c:8803:b92d with SMTP id n32-20020a634d60000000b0036c8803b92dmr18919727pgl.179.1647244635069;
        Mon, 14 Mar 2022 00:57:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm15308750pgf.46.2022.03.14.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:57:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 13 Mar 2022 21:57:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linxu-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH block-5.17] block: don't merge across cgroup boundaries if
 iocost or iolatency is active
Message-ID: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-iocost and iolatency are cgroup aware rq-qos policies but, unlike
elevators, they didn't have a way to disable merges across different
cgroups. This obviously can lead to accounting and control errors but more
importantly to priority inversions - e.g. an IO which belongs to a higher
priority cgroup or IO class may end up getting throttled incorrectly because
it gets merged to an IO issued from a low priority cgroup.

Fix it by adding blk_cgroup_mergeable() which is called from merge paths to
test whether merges are acceptable from cgroup POV. When iocost or iolatency
is active, this rejects cross-cgroup and cross-issue_as_root merges.

While at it,

* Add WARN_ON_ONCE() on blkg mismatch in ioc_rqos_merge() so that we can
  easily notice similar failures in the future.

* Make sure iocost enable/disable transitions only happen when iocost is
  actually enabled / disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Cc: stable@vger.kernel.org # v4.19+
Cc: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-cgroup.c         |    2 +
 block/blk-iocost.c         |   20 ++++++++++++-------
 block/blk-iolatency.c      |    9 +++++---
 block/blk-merge.c          |   11 ++++++++++
 include/linux/blk-cgroup.h |   46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h     |    4 ++-
 6 files changed, 81 insertions(+), 11 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1176,6 +1176,8 @@ int blkcg_init_queue(struct request_queu
 	bool preloaded;
 	int ret;
 
+	atomic_set(&q->cgroup_no_cross_merges, 0);
+
 	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2703,6 +2703,8 @@ static void ioc_rqos_merge(struct rq_qos
 	if (!ioc->enabled || !iocg || !iocg->level)
 		return;
 
+	WARN_ON_ONCE(rq->bio->bi_blkg != bio->bi_blkg);
+
 	abs_cost = calc_vtime_cost(bio, iocg, true);
 	if (!abs_cost)
 		return;
@@ -3253,13 +3255,17 @@ static ssize_t ioc_qos_write(struct kern
 
 	spin_lock_irq(&ioc->lock);
 
-	if (enable) {
-		blk_stat_enable_accounting(ioc->rqos.q);
-		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
-		ioc->enabled = true;
-	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
-		ioc->enabled = false;
+	if (enable != ioc->enabled) {
+		if (enable) {
+			blk_stat_enable_accounting(ioc->rqos.q);
+			blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
+			blk_cgroup_disable_cross_merges(ioc->rqos.q);
+			ioc->enabled = true;
+		} else {
+			blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
+			blk_cgroup_enable_cross_merges(ioc->rqos.q);
+			ioc->enabled = false;
+		}
 	}
 
 	if (user) {
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -855,12 +855,15 @@ out:
 
 		blk_mq_freeze_queue(blkg->q);
 
-		if (enable == 1)
+		if (enable == 1) {
 			atomic_inc(&blkiolat->enabled);
-		else if (enable == -1)
+			blk_cgroup_disable_cross_merges(blkg->q);
+		} else if (enable == -1) {
 			atomic_dec(&blkiolat->enabled);
-		else
+			blk_cgroup_enable_cross_merges(blkg->q);
+		} else {
 			WARN_ON_ONCE(1);
+		}
 
 		blk_mq_unfreeze_queue(blkg->q);
 
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -9,6 +9,7 @@
 #include <linux/blk-integrity.h>
 #include <linux/scatterlist.h>
 #include <linux/part_stat.h>
+#include <linux/blk-cgroup.h>
 
 #include <trace/events/block.h>
 
@@ -600,6 +601,9 @@ static inline unsigned int blk_rq_get_ma
 static inline int ll_new_hw_segment(struct request *req, struct bio *bio,
 		unsigned int nr_phys_segs)
 {
+	if (!blk_cgroup_mergeable(req, bio))
+		goto no_merge;
+
 	if (blk_integrity_merge_bio(req->q, req, bio) == false)
 		goto no_merge;
 
@@ -696,6 +700,9 @@ static int ll_merge_requests_fn(struct r
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
 
+	if (!blk_cgroup_mergeable(req, next->bio))
+		return 0;
+
 	if (blk_integrity_merge_rq(q, req, next) == false)
 		return 0;
 
@@ -904,6 +911,10 @@ bool blk_rq_merge_ok(struct request *rq,
 	if (bio_data_dir(bio) != rq_data_dir(rq))
 		return false;
 
+	/* don't merge across cgroup boundaries */
+	if (!blk_cgroup_mergeable(rq, bio))
+		return false;
+
 	/* only merge integrity protected bio into ditto rq */
 	if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
 		return false;
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/radix-tree.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/atomic.h>
 #include <linux/kthread.h>
 #include <linux/fs.h>
@@ -604,6 +605,48 @@ static inline void blkcg_clear_delay(str
 		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
 }
 
+/**
+ * blk_cgroup_disable_cross_merges - Disable cross-cgroup merges
+ * @q: target request_queue
+ *
+ * Disallow merges between bios that belong to different cgroups. Disabling can
+ * be nested. Used by cgroup-aware rq-qos policies.
+ */
+static inline void blk_cgroup_disable_cross_merges(struct request_queue *q)
+{
+	atomic_inc(&q->cgroup_no_cross_merges);
+}
+
+/**
+ * blk_cgroup_enable_cross_merges - Enable cross-cgroup merges
+ * @q: target request_queue
+ *
+ * Reverses blk_cgroup_disable_cross_merges().
+ */
+static inline void blk_cgroup_enable_cross_merges(struct request_queue *q)
+{
+	WARN_ON_ONCE(atomic_dec_return(&q->cgroup_no_cross_merges) < 0);
+}
+
+/**
+ * blk_cgroup_mergeable - Determine whether to allow or disallow merges
+ * @rq: request to merge into
+ * @bio: bio to merge
+ *
+ * Can @bio be merged into @rq? If cross merges are disallowed, the two should
+ * belong to the same cgroup and their issue_as_root should match. The latter is
+ * necessary as we don't want to throttle e.g. a metadata update because it
+ * happens to be next to a regular IO.
+ */
+static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio)
+{
+	if (!atomic_read(&rq->q->cgroup_no_cross_merges))
+		return true;
+
+	return rq->bio->bi_blkg == bio->bi_blkg &&
+		bio_issue_as_root_blkg(rq->bio) == bio_issue_as_root_blkg(bio);
+}
+
 void blk_cgroup_bio_start(struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
@@ -659,6 +702,9 @@ static inline void blkg_put(struct blkcg
 static inline bool blkcg_punt_bio_submit(struct bio *bio) { return false; }
 static inline void blkcg_bio_issue_init(struct bio *bio) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
+static inline void blk_cgroup_disallow_cross_merges(struct request_queue *q) { }
+static inline void blk_cgroup_allow_cross_merges(struct request_queue *q) { }
+static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
 
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -274,7 +274,9 @@ struct request_queue {
 	struct work_struct	timeout_work;
 
 	atomic_t		nr_active_requests_shared_tags;
-
+#ifdef CONFIG_BLK_CGROUP
+	atomic_t		cgroup_no_cross_merges;
+#endif
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
