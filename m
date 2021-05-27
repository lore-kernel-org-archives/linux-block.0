Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB883C4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08F66128B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhE0BDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:31 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38657 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhE0BDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:30 -0400
Received: by mail-pj1-f42.google.com with SMTP id mp9-20020a17090b1909b029015fd1e3ad5aso1329558pjb.3
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nq+cjmm3jqmpucjC3WcUjC8nein4jmI17n/Vl9OOIsM=;
        b=gX4Rhs91Q0m3HB/GPLNLy1zHqBQEJ66KDhgKwgML0SugcgOdOhc4+3KaqzWiuZLh+l
         9WL1YASemYW3DAd2Gp8gdhy4ixt0Y267sHFp0OJ9yqg0D9rrgSz0+/V6zhD+zuKoSB1N
         uxjdZx5HV3aGDpCSaq6LfTcMjuoGyDTsJ3/f9jAJhK7d5l8oDHWrpBHPWTp6bKOC4Mia
         WBNSou8SZ4OBfEWO78v16Ts5a9/rwQeQjR6DuOCmdoAU+whUzG301DyOSUINq+qLSB35
         rerUmzUH7gY7LLL0uMwDy8ZJ+q0wad4cqm98RqCjJr8VRXK9rgvljM3ZR3uH/pYKoe0c
         AsFg==
X-Gm-Message-State: AOAM531alngrm/6/3U2qhCf8C7jsNaQrjN7sRvU6kvIOI1c3PW+MCGqI
        X8TnXNLtPRDti4dJQG6Rw3A=
X-Google-Smtp-Source: ABdhPJzg7D3lkcY6c29dPHD6x8y+GJ1a4Epgvc0hxrd+D0EDYTV4SKJ+3rHpEeTKLzLGejVn56QyjA==
X-Received: by 2002:a17:90a:e508:: with SMTP id t8mr886334pjy.221.1622077317475;
        Wed, 26 May 2021 18:01:57 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/9] block/mq-deadline: Reserve 25% of tags for synchronous requests
Date:   Wed, 26 May 2021 18:01:32 -0700
Message-Id: <20210527010134.32448-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For interactive workloads it is important that synchronous requests are
not delayed. Hence reserve 25% of tags for synchronous requests. This patch
still allows asynchronous requests to fill the hardware queues since
blk_mq_init_sched() makes sure that the number of scheduler requests is the
double of the hardware queue depth. From blk_mq_init_sched():

	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
				   BLKDEV_MAX_RQ);

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 2ab844a4b6b5..81f487d77e09 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -69,6 +69,7 @@ struct deadline_data {
 	int fifo_batch;
 	int writes_starved;
 	int front_merges;
+	u32 async_depth;
 
 	spinlock_t lock;
 	spinlock_t zone_lock;
@@ -399,6 +400,38 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
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
+static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	struct deadline_data *dd = q->elevator->elevator_data;
+	struct blk_mq_tags *tags = hctx->sched_tags;
+
+	dd->async_depth = 3 * q->nr_requests / 4;
+
+	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, dd->async_depth);
+}
+
+static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	dd_depth_updated(hctx);
+	return 0;
+}
+
 static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
@@ -744,6 +777,15 @@ static int deadline_starved_show(void *data, struct seq_file *m)
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
@@ -786,6 +828,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 	DEADLINE_QUEUE_DDIR_ATTRS(write),
 	{"batching", 0400, deadline_batching_show},
 	{"starved", 0400, deadline_starved_show},
+	{"async_depth", 0400, dd_async_depth_show},
 	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
 	{},
 };
@@ -794,6 +837,8 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
 
 static struct elevator_type mq_deadline = {
 	.ops = {
+		.depth_updated		= dd_depth_updated,
+		.limit_depth		= dd_limit_depth,
 		.insert_requests	= dd_insert_requests,
 		.dispatch_request	= dd_dispatch_request,
 		.prepare_request	= dd_prepare_request,
@@ -807,6 +852,7 @@ static struct elevator_type mq_deadline = {
 		.has_work		= dd_has_work,
 		.init_sched		= dd_init_sched,
 		.exit_sched		= dd_exit_sched,
+		.init_hctx		= dd_init_hctx,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
