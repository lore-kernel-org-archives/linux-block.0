Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1602EC433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 00:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39A561621
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 00:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhEKAGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 20:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhEKAGt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 20:06:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3CEC061574
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 17:05:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m124so14447660pgm.13
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akzdqQUoGlUv51eYFziXT8eP2K9cS46vQAq6RiOgMKU=;
        b=tgUr16WtYGYgoWiUJWpGnwCj7HhBRcYASYOec7qffk0WozADEbUxv64h1jUDSWDnsw
         SabUF6eHk/JVY33r6flIeuRfC95hEtnAN38zg7gFKqId8Wf9z6YO4exY7Llv+WvtxzIn
         ZXWGqr6OwQxcrkoAdy2ObWvEcq1wUBE7KVpbbDNpDhpirc6o16+EH9PSS0Cgp00vQs+U
         jPFttq8sy91gjxqBTj8+rE8T8BFtEkr0dRelAOCsgB0BJgKXqcvovMxvblHBKVidLMBw
         Eel5j3NWha/ClOEGmtExGNPKavriBumpdqQUJADSL1yRI6PeKL55itfYvu5qQbTY2HgE
         vt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akzdqQUoGlUv51eYFziXT8eP2K9cS46vQAq6RiOgMKU=;
        b=CjaRBFbAIDd3+XAfL9t5oi44m2dLIJyHrgbB8CuxZ6N1akRYiEJg3V57HaxW+XXT7n
         W+w1cRfOONnT2EmOzXoIzXRHhGqjZcYSSxLIYh6WdAbBNYiBxUYyRrJKakXa3vfQxIsR
         ZF7bj6gGTuMeskmxcMQXfd7gfRyB81HOC2PEgS+7Nz0ZX3OuBG9mL34wxv2AdpUQMiwu
         dE7z7Bwf8K+s0DRaoArpfCcFYpbZCumDc2K3re+CtPT6f3OMNJBW98syY+WAtNEZszUM
         fWlTxuh1jH/xgW8pFU0qNd86TVFfF6joOU645LaQIETi/QPSM985r/C0ZOZGYa81NadB
         w1Bg==
X-Gm-Message-State: AOAM530InMhhevXOvjJAvfLej96twiS8FR7H68oY3lnTcscxhWV+cBEg
        1ixJ+ytwOAAbDhkKZ9HDlPanGHcVnFFsRw==
X-Google-Smtp-Source: ABdhPJxr/gcUZtnPzfcMan1i8maOorsStkfMzvNcFVCI9MDvGUHYgZb8hAmpErvioR3ArKcY75bndA==
X-Received: by 2002:a65:6549:: with SMTP id a9mr4211769pgw.213.1620691543232;
        Mon, 10 May 2021 17:05:43 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1e60])
        by smtp.gmail.com with ESMTPSA id n8sm9373966pff.167.2021.05.10.17.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:05:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH] kyber: fix out of bounds access when preempted
Date:   Mon, 10 May 2021 17:05:35 -0700
Message-Id: <c7598605401a48d5cfeadebb678abd10af22b83f.1620691329.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

__blk_mq_sched_bio_merge() gets the ctx and hctx for the current CPU and
passes the hctx to ->bio_merge(). kyber_bio_merge() then gets the ctx
for the current CPU again and uses that to get the corresponding Kyber
context in the passed hctx. However, the thread may be preempted between
the two calls to blk_mq_get_ctx(), and the ctx returned the second time
may no longer correspond to the passed hctx. This "works" accidentally
most of the time, but it can cause us to read garbage if the second ctx
came from an hctx with more ctx's than the first one (i.e., if
ctx->index_hw[hctx->type] > hctx->nr_ctx).

This manifested as this UBSAN array index out of bounds error reported
by Jakub:

UBSAN: array-index-out-of-bounds in ../kernel/locking/qspinlock.c:130:9
index 13106 is out of range for type 'long unsigned int [128]'
Call Trace:
 dump_stack+0xa4/0xe5
 ubsan_epilogue+0x5/0x40
 __ubsan_handle_out_of_bounds.cold.13+0x2a/0x34
 queued_spin_lock_slowpath+0x476/0x480
 do_raw_spin_lock+0x1c2/0x1d0
 kyber_bio_merge+0x112/0x180
 blk_mq_submit_bio+0x1f5/0x1100
 submit_bio_noacct+0x7b0/0x870
 submit_bio+0xc2/0x3a0
 btrfs_map_bio+0x4f0/0x9d0
 btrfs_submit_data_bio+0x24e/0x310
 submit_one_bio+0x7f/0xb0
 submit_extent_page+0xc4/0x440
 __extent_writepage_io+0x2b8/0x5e0
 __extent_writepage+0x28d/0x6e0
 extent_write_cache_pages+0x4d7/0x7a0
 extent_writepages+0xa2/0x110
 do_writepages+0x8f/0x180
 __writeback_single_inode+0x99/0x7f0
 writeback_sb_inodes+0x34e/0x790
 __writeback_inodes_wb+0x9e/0x120
 wb_writeback+0x4d2/0x660
 wb_workfn+0x64d/0xa10
 process_one_work+0x53a/0xa80
 worker_thread+0x69/0x5b0
 kthread+0x20b/0x240
 ret_from_fork+0x1f/0x30

Only Kyber uses the hctx, so fix it by passing the request_queue to
->bio_merge() instead. BFQ and mq-deadline just use that, and Kyber can
map the queues itself to avoid the mismatch.

Fixes: a6088845c2bf ("block: kyber: make kyber more friendly with merging")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on linux-block/for-next.

 block/bfq-iosched.c      | 3 +--
 block/blk-mq-sched.c     | 8 +++++---
 block/kyber-iosched.c    | 5 +++--
 block/mq-deadline.c      | 3 +--
 include/linux/elevator.h | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0270cd7ca165..59b2499d3f8b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2263,10 +2263,9 @@ static void bfq_remove_request(struct request_queue *q,
 
 }
 
-static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
-	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *free = NULL;
 	/*
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 42a365b1b9c0..996a4b2f73aa 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -358,14 +358,16 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct elevator_queue *e = q->elevator;
-	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
+	struct blk_mq_ctx *ctx;
+	struct blk_mq_hw_ctx *hctx;
 	bool ret = false;
 	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge)
-		return e->type->ops.bio_merge(hctx, bio, nr_segs);
+		return e->type->ops.bio_merge(q, bio, nr_segs);
 
+	ctx = blk_mq_get_ctx(q);
+	hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	type = hctx->type;
 	if (!(hctx->flags & BLK_MQ_F_SHOULD_MERGE) ||
 	    list_empty_careful(&ctx->rq_lists[type]))
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 8969e122f081..81e3279ecd57 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -561,11 +561,12 @@ static void kyber_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
 	}
 }
 
-static bool kyber_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
 	struct kyber_hctx_data *khd = hctx->sched_data;
-	struct blk_mq_ctx *ctx = blk_mq_get_ctx(hctx->queue);
 	struct kyber_ctx_queue *kcq = &khd->kcqs[ctx->index_hw[hctx->type]];
 	unsigned int sched_domain = kyber_sched_domain(bio->bi_opf);
 	struct list_head *rq_list = &kcq->rq_list[sched_domain];
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 04aded71ead2..8eea2cbf2bf4 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -461,10 +461,9 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 	return ELEVATOR_NO_MERGE;
 }
 
-static bool dd_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio,
+static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	struct request *free = NULL;
 	bool ret;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 1fe8e105b83b..dcb2f9022c1d 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -34,7 +34,7 @@ struct elevator_mq_ops {
 	void (*depth_updated)(struct blk_mq_hw_ctx *);
 
 	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
-	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *, unsigned int);
+	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);
 	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
 	void (*request_merged)(struct request_queue *, struct request *, enum elv_merge);
 	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
-- 
2.30.2

