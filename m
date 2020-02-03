Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302EBC35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF89F2087E
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 20:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvziGqOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBCU75 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:59:57 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46651 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCU75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 15:59:57 -0500
Received: by mail-pg1-f201.google.com with SMTP id t12so10204826pgs.13
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gTRSEmoi9SlbgoP8LRgcRMMfTG1cpJF4Pf0fAGTw6cs=;
        b=nvziGqOYag22vRt1BUHqv3ijVB5MpznvcmkDm+J0GVd3A+JXO8miLI18TOo40j2iCf
         8xBp5imQ/6u/6cMAHTAn6TlzjrnAqsKyHOUSqLq8NAEyW2IqXmhSKnEIcfI9TjXj3mYE
         K+UInffoIgC3kIAxWOvmAyUGNfcAZWq1dLuHDCNz/qv883USIpKPyQ5w220rouZ29nrX
         DPRlO5/e+qDm95okomaSzfQi9s7AdgEbesU6LvPk79GVu2+Oq3KPZ4H10OT/Jtu7NssL
         /Ah/HL1SP1Psek70PGgHxzmKkvtraXLngPOsMQ6KvnEYIfjK+cYtZXSqQto08LIwAs/f
         lfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gTRSEmoi9SlbgoP8LRgcRMMfTG1cpJF4Pf0fAGTw6cs=;
        b=bUzUyRyLOIIbxV/jxp8+EnUB55ym5Oh1ruxOuhJuoIDqsFY5Fbd4fA6ocxfdY+nhBM
         tL/a8vbYj2M4/rs/SnnKB8q8+PZPvoal+lRSuy7jNG57BLZqCg2alfTxGfBGP8xfIcm9
         kTWEG5LlCJ0dkscGEjZGYM77F6pJMItXsU116XkD8G4SIul4Oblq5+a46I2nVSGJBTO3
         LRdR6aRRJCIFsOUwBEB4linN8Az7AMpo63QGeygUMu3f6RPt/KnxFDXFPZnvURdeLwHK
         fAMcU2N3ljcUbCPIWcrOgSY6I7X4LVv2NR+HaGvDxTTAegr4LGkMrz8AR1InQoycj3cd
         mVHg==
X-Gm-Message-State: APjAAAX2Q1/hqW1gy1pUk/Q1NUnCO7tjw6p88QfizfXFOglxJqOju6bk
        MM5FfYo6qGpABpdPGKeeXDRFMmBPKw==
X-Google-Smtp-Source: APXvYqxhBEd2mEHERGR4/L3m4qGGuOmGNEVFERYz5nU/oZ7ZBzQnHZloS0PrjSOvMD0TcNtP0kAPURAvTA==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr26389031pgh.331.1580763596109;
 Mon, 03 Feb 2020 12:59:56 -0800 (PST)
Date:   Mon,  3 Feb 2020 12:59:50 -0800
In-Reply-To: <20200203204554.119849-1-sqazi@google.com>
Message-Id: <20200203205950.127629-1-sqazi@google.com>
Mime-Version: 1.0
References: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] block: Limit number of items taken from the I/O scheduler in
 one go
From:   Salman Qazi <sqazi@google.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We observed that it is possible for a flush to bypass the I/O
scheduler and get added to hctx->dispatch in blk_mq_sched_bypass_insert.
This can happen while a kworker is running blk_mq_do_dispatch_sched call
in blk_mq_sched_dispatch_requests.

However, the blk_mq_do_dispatch_sched call doesn't end in bounded time.
As a result, the flush can sit there indefinitely, as the I/O scheduler
feeds an arbitrary number of requests to the hardware.

The solution is to periodically poll hctx->dispatch in
blk_mq_do_dispatch_sched, to put a bound on the latency of the commands
sitting there.

Signed-off-by: Salman Qazi <sqazi@google.com>
---
 block/blk-mq-sched.c   |  6 ++++++
 block/blk-mq.c         |  4 ++++
 block/blk-sysfs.c      | 33 +++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..75cdec64b9c7 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -90,6 +90,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	int count = 0;
 
 	do {
 		struct request *rq;
@@ -97,6 +98,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (count > 0 && count % q->max_sched_batch == 0 &&
+		    !list_empty_careful(&hctx->dispatch))
+			break;
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -112,6 +117,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 * in blk_mq_dispatch_rq_list().
 		 */
 		list_add(&rq->queuelist, &rq_list);
+		count++;
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a12b1763508d..7cb13aa72a94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,6 +40,8 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
+#define BLK_MQ_DEFAULT_MAX_SCHED_BATCH	100
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
@@ -2934,6 +2936,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	 */
 	q->poll_nsec = BLK_MQ_POLL_CLASSIC;
 
+	q->max_sched_batch = BLK_MQ_DEFAULT_MAX_SCHED_BATCH;
+
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..dd7b58a1bd35 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -390,6 +390,32 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 	return count;
 }
 
+static ssize_t queue_max_sched_batch_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%d\n", q->max_sched_batch);
+}
+
+static ssize_t queue_max_sched_batch_store(struct request_queue *q,
+					   const char *page,
+					   size_t count)
+{
+	int err, val;
+
+	if (!q->mq_ops)
+		return -EINVAL;
+
+	err = kstrtoint(page, 10, &val);
+	if (err < 0)
+		return err;
+
+	if (val <= 0)
+		return -EINVAL;
+
+	q->max_sched_batch = val;
+
+	return count;
+}
+
 static ssize_t queue_poll_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(test_bit(QUEUE_FLAG_POLL, &q->queue_flags), page);
@@ -691,6 +717,12 @@ static struct queue_sysfs_entry queue_poll_delay_entry = {
 	.store = queue_poll_delay_store,
 };
 
+static struct queue_sysfs_entry queue_max_sched_batch_entry = {
+	.attr = {.name = "max_sched_batch", .mode = 0644 },
+	.show = queue_max_sched_batch_show,
+	.store = queue_max_sched_batch_store,
+};
+
 static struct queue_sysfs_entry queue_wc_entry = {
 	.attr = {.name = "write_cache", .mode = 0644 },
 	.show = queue_wc_show,
@@ -763,6 +795,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	&queue_io_timeout_entry.attr,
+	&queue_max_sched_batch_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 053ea4b51988..68e7d29d4dd4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -477,6 +477,8 @@ struct request_queue {
 	unsigned int		rq_timeout;
 	int			poll_nsec;
 
+	int			max_sched_batch;
+
 	struct blk_stat_callback	*poll_cb;
 	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
-- 
2.25.0.341.g760bfbb309-goog

