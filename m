Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D075C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F02146D
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0x/C4GSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33F02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeKPGA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:00:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35645 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeKPGA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:00:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so9479894pgu.2
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zuE5HiN6neQwo6VH85lAFmz18mDze9gV2PKq91gHoV8=;
        b=0x/C4GSEu5uWMnS9zXJLj2Vu0t48P29eeuRKNyER7XKQN0LML2PtJn/wtOcw37ODq5
         hGsWs2403kqk+g8mNtWWsfArE+SsSfNVF8+c8OoIk9B3SHIL0SzkoYKE3TurAHvZfZF/
         P+PMxO1WDxo3N9uV94++NFS40Xx/DmFpVY2cXqwfIrE2O1mFSYfLYwxCCUkxIROG2kPs
         TzD+dj4eGiVaWPTpBARucDQ6LYLYBITp8JvgyWiE1xXXRUksD3dCFeVbfR7ITEuoc1Tl
         Lt8CmL80Bo9V64a65bP9LMddB86TPaaRH1A8xmrM4pzVL7Y6PWFcEnik4FPPJjydoVYK
         Vv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zuE5HiN6neQwo6VH85lAFmz18mDze9gV2PKq91gHoV8=;
        b=hOsjmuj2+S2N7U3pBbyzO49eCcP/uwQGfYhNwAzGAcNdbV2fcG57w/kDg697iDTf41
         XOdRGNePp99i9BrY0lBNDuv6xACCDlmC6hUVYmzmudzJzxNNStJ9Xe21HQyOi90TOgqV
         rrcePUP9BMYyWn0OlsKvjpJLYaG45MURCVDTBG54KC+ZL0A1k6pAF7XzTLKvvNBqoWRB
         3HvMKZvZ0OH+K/BBo9GxaAxmKIJAqYpO6NgKSxe+1tv2SVrTmrF1r3jLxn9bKQe+lSbv
         s1bbJvUm8qGja0ueQWyGPsPBU4n3RYmxXdAWwSDj+uRd3wxZrh69eYEV7PWbxrFOcH1X
         xg+w==
X-Gm-Message-State: AGRZ1gIN8oyjcq2h6lqxKQ7mTyifXF8eY4114brpxjbVea5fWiv31aMu
        s5GqsQqIBbNWvNmjWxb1qlB6gaF6AtA=
X-Google-Smtp-Source: AJdET5drrjnTtzAvgAN40qUt4zjgMLaOLqQ+y8m+GpF8m8VLy+EnqpVobXqMoX+Rk9xzIFhj5LmVJA==
X-Received: by 2002:a63:a41:: with SMTP id z1mr7037228pgk.117.1542311504663;
        Thu, 15 Nov 2018 11:51:44 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] block: add queue_is_mq() helper
Date:   Thu, 15 Nov 2018 12:51:26 -0700
Message-Id: <20181115195135.22812-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various spots check for q->mq_ops being non-NULL, but provide
a helper to do this instead.

Where the ->mq_ops != NULL check is redundant, remove it.

Since mq == rq-based now that legacy is gone, get rid of the
queue_is_rq_based() and just use queue_is_mq() everywhere.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c     |  8 ++++----
 block/blk-core.c       | 12 ++++++------
 block/blk-flush.c      |  3 +--
 block/blk-mq.c         |  2 +-
 block/blk-sysfs.c      | 14 +++++++-------
 block/blk-throttle.c   |  2 +-
 block/blk-wbt.c        |  2 +-
 block/blk-zoned.c      |  2 +-
 block/bsg.c            |  2 +-
 block/elevator.c       | 11 +++++------
 block/genhd.c          |  8 ++++----
 drivers/md/dm-rq.c     |  2 +-
 drivers/md/dm-table.c  |  4 ++--
 include/linux/blkdev.h |  6 +-----
 14 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0f6b44614165..63d226a084cd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1324,7 +1324,7 @@ int blkcg_activate_policy(struct request_queue *q,
 	if (blkcg_policy_enabled(q, pol))
 		return 0;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 pd_prealloc:
 	if (!pd_prealloc) {
@@ -1363,7 +1363,7 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	spin_unlock_irq(&q->queue_lock);
 out_bypass_end:
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
 	if (pd_prealloc)
 		pol->pd_free_fn(pd_prealloc);
@@ -1387,7 +1387,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	if (!blkcg_policy_enabled(q, pol))
 		return;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_freeze_queue(q);
 
 	spin_lock_irq(&q->queue_lock);
@@ -1405,7 +1405,7 @@ void blkcg_deactivate_policy(struct request_queue *q,
 
 	spin_unlock_irq(&q->queue_lock);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unfreeze_queue(q);
 }
 EXPORT_SYMBOL_GPL(blkcg_deactivate_policy);
diff --git a/block/blk-core.c b/block/blk-core.c
index 92b6b200e9fb..0b684a520a11 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -232,7 +232,7 @@ void blk_sync_queue(struct request_queue *q)
 	del_timer_sync(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
 
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		struct blk_mq_hw_ctx *hctx;
 		int i;
 
@@ -281,7 +281,7 @@ void blk_set_queue_dying(struct request_queue *q)
 	 */
 	blk_freeze_queue_start(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_wake_waiters(q);
 
 	/* Make blk_queue_enter() reexamine the DYING flag. */
@@ -356,7 +356,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * blk_freeze_queue() should be enough for cases of passthrough
 	 * request.
 	 */
-	if (q->mq_ops && blk_queue_init_done(q))
+	if (queue_is_mq(q) && blk_queue_init_done(q))
 		blk_mq_quiesce_queue(q);
 
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
@@ -374,7 +374,7 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_exit_queue(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_free_queue(q);
 
 	percpu_ref_exit(&q->q_usage_counter);
@@ -982,7 +982,7 @@ generic_make_request_checks(struct bio *bio)
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
+	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
 		goto not_supported;
 
 	if (should_fail_bio(bio))
@@ -1657,7 +1657,7 @@ EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
  */
 int blk_lld_busy(struct request_queue *q)
 {
-	if (q->mq_ops && q->mq_ops->busy)
+	if (queue_is_mq(q) && q->mq_ops->busy)
 		return q->mq_ops->busy(q);
 
 	return 0;
diff --git a/block/blk-flush.c b/block/blk-flush.c
index fcd18b158fd6..a3fc7191c694 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -273,8 +273,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * assigned to empty flushes, and we deadlock if we are expecting
 	 * other requests to make progress. Don't defer for that case.
 	 */
-	if (!list_empty(&fq->flush_data_in_flight) &&
-	    !(q->mq_ops && q->elevator) &&
+	if (!list_empty(&fq->flush_data_in_flight) && q->elevator &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3b823891b3ef..32b246ed44c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -150,7 +150,7 @@ void blk_freeze_queue_start(struct request_queue *q)
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
-		if (q->mq_ops)
+		if (queue_is_mq(q))
 			blk_mq_run_hw_queues(q, false);
 	}
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1e370207a20e..80eef48fddc8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -68,7 +68,7 @@ queue_requests_store(struct request_queue *q, const char *page, size_t count)
 	unsigned long nr;
 	int ret, err;
 
-	if (!q->mq_ops)
+	if (!queue_is_mq(q))
 		return -EINVAL;
 
 	ret = queue_var_store(&nr, page, count);
@@ -835,12 +835,12 @@ static void __blk_release_queue(struct work_struct *work)
 
 	blk_queue_free_zone_bitmaps(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_release(q);
 
 	blk_trace_shutdown(q);
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
 	bioset_exit(&q->bio_split);
@@ -914,7 +914,7 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
 	}
@@ -925,7 +925,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_throtl_register_queue(q);
 
-	if ((q->mq_ops && q->elevator)) {
+	if (q->elevator) {
 		ret = elv_register_queue(q);
 		if (ret) {
 			mutex_unlock(&q->sysfs_lock);
@@ -974,7 +974,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
 	 */
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 	mutex_unlock(&q->sysfs_lock);
 
@@ -983,7 +983,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
-	if (q->mq_ops && q->elevator)
+	if (q->elevator)
 		elv_unregister_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d0a23f0bb3ed..8f0a104770ee 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2456,7 +2456,7 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
 
-	td->track_bio_latency = !queue_is_rq_based(q);
+	td->track_bio_latency = !queue_is_mq(q);
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
 }
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9f142b84dc85..d051ebfb4852 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -701,7 +701,7 @@ void wbt_enable_default(struct request_queue *q)
 	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
 		return;
 
-	if (q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ))
+	if (queue_is_mq(q) && IS_ENABLED(CONFIG_BLK_WBT_MQ))
 		wbt_init(q);
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 13ba2011a306..e9c332b1d9da 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -421,7 +421,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 * BIO based queues do not use a scheduler so only q->nr_zones
 	 * needs to be updated so that the sysfs exposed value is correct.
 	 */
-	if (!queue_is_rq_based(q)) {
+	if (!queue_is_mq(q)) {
 		q->nr_zones = nr_zones;
 		return 0;
 	}
diff --git a/block/bsg.c b/block/bsg.c
index 9a442c23a715..44f6028b9567 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -471,7 +471,7 @@ int bsg_register_queue(struct request_queue *q, struct device *parent,
 	/*
 	 * we need a proper transport to send commands, not a stacked device
 	 */
-	if (!queue_is_rq_based(q))
+	if (!queue_is_mq(q))
 		return 0;
 
 	bcd = &q->bsg_dev;
diff --git a/block/elevator.c b/block/elevator.c
index 796436270682..f05e90d4e695 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -667,7 +667,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	/*
 	 * Special case for mq, turn off scheduling
 	 */
-	if (q->mq_ops && !strncmp(name, "none", 4))
+	if (!strncmp(name, "none", 4))
 		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
@@ -685,8 +685,7 @@ static int __elevator_change(struct request_queue *q, const char *name)
 
 static inline bool elv_support_iosched(struct request_queue *q)
 {
-	if (q->mq_ops && q->tag_set && (q->tag_set->flags &
-				BLK_MQ_F_NO_SCHED))
+	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))
 		return false;
 	return true;
 }
@@ -696,7 +695,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!q->mq_ops || !elv_support_iosched(q))
+	if (!queue_is_mq(q) || !elv_support_iosched(q))
 		return count;
 
 	ret = __elevator_change(q, name);
@@ -713,7 +712,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	struct elevator_type *__e;
 	int len = 0;
 
-	if (!queue_is_rq_based(q))
+	if (!queue_is_mq(q))
 		return sprintf(name, "none\n");
 
 	if (!q->elevator)
@@ -732,7 +731,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	}
 	spin_unlock(&elv_list_lock);
 
-	if (q->mq_ops && q->elevator)
+	if (q->elevator)
 		len += sprintf(name+len, "none");
 
 	len += sprintf(len+name, "\n");
diff --git a/block/genhd.c b/block/genhd.c
index cff6bdf27226..0145bcb0cc76 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,7 +47,7 @@ static void disk_release_events(struct gendisk *disk);
 
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		return;
 
 	atomic_inc(&part->in_flight[rw]);
@@ -57,7 +57,7 @@ void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 
 void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		return;
 
 	atomic_dec(&part->in_flight[rw]);
@@ -68,7 +68,7 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 void part_in_flight(struct request_queue *q, struct hd_struct *part,
 		    unsigned int inflight[2])
 {
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		blk_mq_in_flight(q, part, inflight);
 		return;
 	}
@@ -85,7 +85,7 @@ void part_in_flight(struct request_queue *q, struct hd_struct *part,
 void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 		       unsigned int inflight[2])
 {
-	if (q->mq_ops) {
+	if (queue_is_mq(q)) {
 		blk_mq_in_flight_rw(q, part, inflight);
 		return;
 	}
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 7cd36e4d1310..1f1fe9a618ea 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -43,7 +43,7 @@ static unsigned dm_get_blk_mq_queue_depth(void)
 
 int dm_request_based(struct mapped_device *md)
 {
-	return queue_is_rq_based(md->queue);
+	return queue_is_mq(md->queue);
 }
 
 void dm_start_queue(struct request_queue *q)
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9038c302d5c2..844f7d0f2ef8 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -919,12 +919,12 @@ static int device_is_rq_based(struct dm_target *ti, struct dm_dev *dev,
 	struct request_queue *q = bdev_get_queue(dev->bdev);
 	struct verify_rq_based_data *v = data;
 
-	if (q->mq_ops)
+	if (queue_is_mq(q))
 		v->mq_count++;
 	else
 		v->sq_count++;
 
-	return queue_is_rq_based(q);
+	return queue_is_mq(q);
 }
 
 static int dm_table_determine_type(struct dm_table *t)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1d185f1fc333..41aaa05e42c1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -656,11 +656,7 @@ static inline bool blk_account_rq(struct request *rq)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
 
-/*
- * Driver can handle struct request, if it either has an old style
- * request_fn defined, or is blk-mq based.
- */
-static inline bool queue_is_rq_based(struct request_queue *q)
+static inline bool queue_is_mq(struct request_queue *q)
 {
 	return q->mq_ops;
 }
-- 
2.17.1

