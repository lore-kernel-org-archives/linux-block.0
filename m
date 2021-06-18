Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C8C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A162613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhFRAra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:30 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37680 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRAra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:30 -0400
Received: by mail-pl1-f178.google.com with SMTP id h12so3814404plf.4
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRzATgHvu/z80trVJpoEKwWbSzV2PA+TjCz+0Y9Py/w=;
        b=JxCTKoUOc9/1FkmdpNEVaD5/kfj4VT9/geFWG46lbKVIngeRN2bO3uJf5blp8Xgxdb
         18kkWVLbBLhZJsGgvHbNxUqu2NWe7/YcNvyfLMBFlcsXwaBpAeAxIdoNT0J8kV3fu4H/
         eXkH0Nc/1UbBJ10N25ab/+olIMcLa2L3L++nk/5k7fVg8qZ1aiWva1kmMqHM8uUSLyHp
         4x2SE4dJVtTjmo4ex95fTWmCZxVImYYCmU1ybkat0bGwRxpE+QDsg6kDhUUSbftdjvDQ
         zRtsF0h2dfLyrDdgDxktbsaDK0g7tQcAIQxQodxJPST3cVMMgUJHWc4dsqW9hSYYXxsP
         e4VQ==
X-Gm-Message-State: AOAM530ppm/b7PxRPrDjfuPzPmWXIOkSZnEgbxl318CBTb3n3xURGgp6
        QFyUVlvYJeXFc8aDFC5lsDs=
X-Google-Smtp-Source: ABdhPJwyvkFYNHGYd+gIxVfh8R8lfcH34vph0aEnYBUF3Nzm/2QFYoWtWdezabZRMZ91tGlX/7cVRQ==
X-Received: by 2002:a17:90b:108f:: with SMTP id gj15mr8469501pjb.124.1623977121731;
        Thu, 17 Jun 2021 17:45:21 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 11/16] block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests
Date:   Thu, 17 Jun 2021 17:44:51 -0700
Message-Id: <20210618004456.7280-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For interactive workloads it is important that synchronous requests are
not delayed. Hence reserve 25% of scheduler tags for synchronous requests.
This patch still allows asynchronous requests to fill the hardware queues
since blk_mq_init_sched() makes sure that the number of scheduler requests
is the double of the hardware queue depth. From blk_mq_init_sched():

	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
				   BLKDEV_MAX_RQ);

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f92224ff0256..44da481c3fea 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -67,6 +67,7 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
+	u32 async_depth;
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
@@ -397,6 +398,44 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
+/*
+ * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
+ * function is used by __blk_mq_get_tag().
+ */
+static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+{
+	struct deadline_data *dd = data->q->elevator->elevator_data;
+
+	/* Do not throttle synchronous reads. */
+	if (op_is_sync(op) && !op_is_write(op))
+		return;
+
+	/*
+	 * Throttle asynchronous requests and writes such that these requests
+	 * do not block the allocation of synchronous requests.
+	 */
+	data->shallow_depth = dd->async_depth;
+}
+
+/* Called by blk_mq_update_nr_requests(). */
+static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	struct deadline_data *dd = q->elevator->elevator_data;
+	struct blk_mq_tags *tags = hctx->sched_tags;
+
+	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
+
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, dd->async_depth);
+}
+
+/* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
+static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	dd_depth_updated(hctx);
+	return 0;
+}
+
 static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
@@ -617,6 +656,7 @@ SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
 SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
 SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
 SHOW_INT(deadline_front_merges_show, dd->front_merges);
+SHOW_INT(deadline_async_depth_show, dd->front_merges);
 SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
 #undef SHOW_INT
 #undef SHOW_JIFFIES
@@ -645,6 +685,7 @@ STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX)
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
+STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_FUNCTION
 #undef STORE_INT
@@ -658,6 +699,7 @@ static struct elv_fs_entry deadline_attrs[] = {
 	DD_ATTR(write_expire),
 	DD_ATTR(writes_starved),
 	DD_ATTR(front_merges),
+	DD_ATTR(async_depth),
 	DD_ATTR(fifo_batch),
 	__ATTR_NULL
 };
@@ -733,6 +775,15 @@ static int deadline_starved_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int dd_async_depth_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	struct deadline_data *dd = q->elevator->elevator_data;
+
+	seq_printf(m, "%u\n", dd->async_depth);
+	return 0;
+}
+
 static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
 	__acquires(&dd->lock)
 {
@@ -775,6 +826,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_QUEUE_DDIR_ATTRS(write),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
+	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
 	{},
 };
@@ -783,6 +835,8 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 
 static struct elevator_type mq_deadline = {
 	.ops = {
+		.depth_updated		= dd_depth_updated,
+		.limit_depth		= dd_limit_depth,
 		.insert_requests	= dd_insert_requests,
 		.dispatch_request	= dd_dispatch_request,
 		.prepare_request	= dd_prepare_request,
@@ -796,6 +850,7 @@ static struct elevator_type mq_deadline = {
 		.has_work		= dd_has_work,
 		.init_sched		= dd_init_sched,
 		.exit_sched		= dd_exit_sched,
+		.init_hctx		= dd_init_hctx,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
