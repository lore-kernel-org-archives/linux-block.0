Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10556C43219
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED11460F6F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244800AbhJQBkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbhJQBkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690AAC061767
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:02 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h196so12231657iof.2
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q06yRTuE0yUtpQX8v5cJDBVfvslgHmWeMrwXlrQbRGM=;
        b=OHQ+xn9K5+YEBNhzvXWoEf6KFMy3+q3JRrlj28kabliuOXgfMvuT0Dg64K5udfppYS
         TLMqlT2dtp4IIMy5h5v9QRowbDEW7RhpNOGFx5LCktPvAezVYyUgSZC87fsD7NHGZ8H6
         tUj3OcLSLumbGPnSPHtid6fYa62vhgyE6c7AK+ofMBDzNpwuv3dB33QK20Cbfn854vym
         ibHYkfpShT0YwDtt1y4vGS31PlCYDuBCxlDR1BJ7D2i22CSeAZFOw/xngXV523olLU3s
         8Ff78LoJR7uYSYHzORrEi1O+2Iw7iX2GhDBVANPooA7RYfYOdX+8kwgmYd/sGAdz32tQ
         hqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q06yRTuE0yUtpQX8v5cJDBVfvslgHmWeMrwXlrQbRGM=;
        b=04AVFJmvJmkyo11O3RIugjhNtP2ds2QEBuTdMox6uneOLSBil5wNBsPxUBuUvR6i1K
         5PbU49G7DC6ZcU0uz9XbeUwPD8xSYPohbDaIDskhemkthZwbhOzYLzUm1+GrnkCfK/kP
         iqGMPOzUv4IzOadqCyxwlMJoU1t5zl7UwI1gn8J3MYS1Phu8ftENGpSqpIKO825c839l
         gKW25q1FaHJN1DcfiAHLeSYik+4ldCi1dXqDzx/S/6QLULWqmm8hG+B4Gl0cP5IeVYVZ
         uKAHSCdHiJu0OaTthkK6V2qgCPDNhkZ9O4XymhavVIVPx3MBaE2NKI0Ko34/q8CoPt/f
         UC7A==
X-Gm-Message-State: AOAM530sQU8y9lwBR/hpNBdy+OPeyb2U1lhEqDx4NnjEBr32LUJ5mzqI
        NbiV8at6/DS0U5lssxy+4Txj8/Xxrk6bQA==
X-Google-Smtp-Source: ABdhPJwpR/7oVjeB/GXYyAwH7uQ4cnXeBQ9zSt8JkKXw72r328HKf3YFbSkwRc7/TQhe4BCa23/amA==
X-Received: by 2002:a05:6602:29c6:: with SMTP id z6mr9338966ioq.215.1634434681633;
        Sat, 16 Oct 2021 18:38:01 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:38:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/14] block: remove some blk_mq_hw_ctx debugfs entries
Date:   Sat, 16 Oct 2021 19:37:48 -0600
Message-Id: <20211017013748.76461-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just like the blk_mq_ctx counterparts, we've got a bunch of counters
in here that are only for debugfs and are of questionnable value. They
are:

- dispatched, index of how many requests were dispatched in one go

- poll_{considered,invoked,success}, which track poll sucess rates. We're
  confident in the iopoll implementation at this point, don't bother
  tracking these.

As a bonus, this shrinks each hardware queue from 576 bytes to 512 bytes,
dropping a whole cacheline.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c | 67 ------------------------------------------
 block/blk-mq.c         | 16 ----------
 include/linux/blk-mq.h | 10 -------
 3 files changed, 93 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 928a16af9175..68ca5d21cda7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -529,70 +529,6 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 	return res;
 }
 
-static int hctx_io_poll_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	seq_printf(m, "considered=%lu\n", hctx->poll_considered);
-	seq_printf(m, "invoked=%lu\n", hctx->poll_invoked);
-	seq_printf(m, "success=%lu\n", hctx->poll_success);
-	return 0;
-}
-
-static ssize_t hctx_io_poll_write(void *data, const char __user *buf,
-				  size_t count, loff_t *ppos)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	hctx->poll_considered = hctx->poll_invoked = hctx->poll_success = 0;
-	return count;
-}
-
-static int hctx_dispatched_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-	int i;
-
-	seq_printf(m, "%8u\t%lu\n", 0U, hctx->dispatched[0]);
-
-	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER - 1; i++) {
-		unsigned int d = 1U << (i - 1);
-
-		seq_printf(m, "%8u\t%lu\n", d, hctx->dispatched[i]);
-	}
-
-	seq_printf(m, "%8u+\t%lu\n", 1U << (i - 1), hctx->dispatched[i]);
-	return 0;
-}
-
-static ssize_t hctx_dispatched_write(void *data, const char __user *buf,
-				     size_t count, loff_t *ppos)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-	int i;
-
-	for (i = 0; i < BLK_MQ_MAX_DISPATCH_ORDER; i++)
-		hctx->dispatched[i] = 0;
-	return count;
-}
-
-static int hctx_queued_show(void *data, struct seq_file *m)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	seq_printf(m, "%lu\n", hctx->queued);
-	return 0;
-}
-
-static ssize_t hctx_queued_write(void *data, const char __user *buf,
-				 size_t count, loff_t *ppos)
-{
-	struct blk_mq_hw_ctx *hctx = data;
-
-	hctx->queued = 0;
-	return count;
-}
-
 static int hctx_run_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -738,9 +674,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
 	{"sched_tags", 0400, hctx_sched_tags_show},
 	{"sched_tags_bitmap", 0400, hctx_sched_tags_bitmap_show},
-	{"io_poll", 0600, hctx_io_poll_show, hctx_io_poll_write},
-	{"dispatched", 0600, hctx_dispatched_show, hctx_dispatched_write},
-	{"queued", 0600, hctx_queued_show, hctx_queued_write},
 	{"run", 0600, hctx_run_show, hctx_run_write},
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d91b74ce67a..2197cfbf081f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -316,7 +316,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->mq_ctx = ctx;
 	rq->mq_hctx = hctx;
 	rq->cmd_flags = cmd_flags;
-	data->hctx->queued++;
 	if (!q->elevator) {
 		rq->rq_flags = 0;
 		rq->tag = tag;
@@ -1268,14 +1267,6 @@ struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 	return data.rq;
 }
 
-static inline unsigned int queued_to_index(unsigned int queued)
-{
-	if (!queued)
-		return 0;
-
-	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
-}
-
 static bool __blk_mq_alloc_driver_tag(struct request *rq)
 {
 	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
@@ -1597,8 +1588,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	if (!list_empty(&zone_list))
 		list_splice_tail_init(&zone_list, list);
 
-	hctx->dispatched[queued_to_index(queued)]++;
-
 	/* If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.
 	 */
@@ -4212,14 +4201,9 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
 	long state = get_current_state();
 	int ret;
 
-	hctx->poll_considered++;
-
 	do {
-		hctx->poll_invoked++;
-
 		ret = q->mq_ops->poll(hctx);
 		if (ret > 0) {
-			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
 			return ret;
 		}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1dccea9505e5..9fc868abcc81 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -341,9 +341,6 @@ struct blk_mq_hw_ctx {
 	unsigned long		queued;
 	/** @run: Number of dispatched requests. */
 	unsigned long		run;
-#define BLK_MQ_MAX_DISPATCH_ORDER	7
-	/** @dispatched: Number of dispatch requests by queue. */
-	unsigned long		dispatched[BLK_MQ_MAX_DISPATCH_ORDER];
 
 	/** @numa_node: NUMA node the storage adapter has been connected to. */
 	unsigned int		numa_node;
@@ -363,13 +360,6 @@ struct blk_mq_hw_ctx {
 	/** @kobj: Kernel object for sysfs. */
 	struct kobject		kobj;
 
-	/** @poll_considered: Count times blk_mq_poll() was called. */
-	unsigned long		poll_considered;
-	/** @poll_invoked: Count how many requests blk_mq_poll() polled. */
-	unsigned long		poll_invoked;
-	/** @poll_success: Count how many polled requests were completed. */
-	unsigned long		poll_success;
-
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
 	 * @debugfs_dir: debugfs directory for this hardware queue. Named
-- 
2.33.1

