Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA1C43612
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5305321773
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c5Gua/V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAJCoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42827 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfAJCob (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so4167628pga.9
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NmQ4UO3QmH+HkLFK/h1DeE1y2XnZFdARIN74g9Q9Wo=;
        b=c5Gua/V/gtKGXZ9kRMX7Xafn5M3Qp7Hz3PRl2E6cqurqAmfD+yotRxTPOp/kohM//S
         rm4pjXrsxcf05e+THTtXAZGwMgpB6FLlppV6KAWvTuxRqKvJ/9b+diliXmt9MDbDHUsv
         WpxmuC/pMZvksySZqB/fXHMqRJr+0rg9Xr+CgsTWm/aw+ALMIQgoECBcoo/Sdg/MED2O
         UgnWFyW5P56JF0DGcf5gIyn/np4eU3IAIMWeJ54LfI8TutcAnLTCRA1V3tcJjfUcmokA
         zO+lRGd/Af0HSEaeOH/DL4E9voOzxipSbbR96ACi1+VBLeKX2ANRzVH3GW23GhlLqGKc
         3CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NmQ4UO3QmH+HkLFK/h1DeE1y2XnZFdARIN74g9Q9Wo=;
        b=npRGigWJNWlAphDCjynzPr7hnDh9GYBo12RKMZFq++eBz4ynkUZe1CGrl8qg/WKY9d
         Tk8LPrsqSGw7nISfd3CBSTd+1jXde4qanI58iIQo60yZmVYeD5lHshSsiHB7DJEbTt9v
         14QquAi5X6923sqeRbNltR6sMibv5fqbUc+98FIJ3RV+HI9yUgLB97nNNP+Z30BU89YD
         YraDjfKRnWwClB2BBJUBBkilsqdgCsbPySJ0zbOlOYbeJ3W949LlXcxHzXDtRv0ZdtCq
         ajXmBwHKuNSo4Qy8lFNihY7PWmDu0VyTDdJX6UqWz8e4ij3EXvTBvl2giyz3LjSi+C2I
         gmUw==
X-Gm-Message-State: AJcUukdryM3CbB+Ez9b+bN9bF/ykk+1d8gcQBCBNwDZC8+gSLwZPgT0v
        EyBgQQIXET8DPlECBIjALJRLPw==
X-Google-Smtp-Source: ALg8bN6iTZsowVLpkNrD7zlSN6tCUaG/Dvy1z2s5qRc+rgWc8WVsNHGm1runHbrONHLo9OCsCmmgyg==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr7839493pge.391.1547088270620;
        Wed, 09 Jan 2019 18:44:30 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/15] io_uring: add submission side request cache
Date:   Wed,  9 Jan 2019 19:43:56 -0700
Message-Id: <20190110024404.25372-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have to add each submitted polled request to the io_ring_ctx
poll_submitted list, which means we have to grab the poll_lock. We
already use the block plug to batch submissions if we're doing a batch
of IO submissions, extend that to cover the poll requests internally as
well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 122 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c872bfb32a03..f7938156552f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -113,6 +113,21 @@ struct sqe_submit {
 	unsigned index;
 };
 
+struct io_submit_state {
+	struct io_ring_ctx *ctx;
+
+	struct blk_plug plug;
+#ifdef CONFIG_BLOCK
+	struct blk_plug_cb plug_cb;
+#endif
+
+	/*
+	 * Polled iocbs that have been submitted, but not added to the ctx yet
+	 */
+	struct list_head req_list;
+	unsigned int req_count;
+};
+
 static struct kmem_cache *kiocb_cachep;
 
 static const struct file_operations io_scqring_fops;
@@ -480,21 +495,29 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
 }
 
 /*
- * After the iocb has been issued, it's safe to be found on the poll list.
- * Adding the kiocb to the list AFTER submission ensures that we don't
- * find it from a io_getevents() thread before the issuer is done accessing
- * the kiocb cookie.
+ * Called either at the end of IO submission, or through a plug callback
+ * because we're going to schedule. Moves out local batch of requests to
+ * the ctx poll list, so they can be found for polling + reaping.
  */
-static void io_iopoll_kiocb_issued(struct io_kiocb *kiocb)
+static void io_flush_state_reqs(struct io_ring_ctx *ctx,
+				 struct io_submit_state *state)
 {
+	spin_lock(&ctx->poll_lock);
+	list_splice_tail_init(&state->req_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+	state->req_count = 0;
+}
+
+static void io_iopoll_iocb_add_list(struct io_kiocb *kiocb)
+{
+	const int front = test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags);
+	struct io_ring_ctx *ctx = kiocb->ki_ctx;
+
 	/*
 	 * For fast devices, IO may have already completed. If it has, add
 	 * it to the front so we find it first. We can't add to the poll_done
 	 * list as that's unlocked from the completion side.
 	 */
-	const int front = test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags);
-	struct io_ring_ctx *ctx = kiocb->ki_ctx;
-
 	spin_lock(&ctx->poll_lock);
 	if (front)
 		list_add(&kiocb->ki_list, &ctx->poll_submitted);
@@ -503,6 +526,33 @@ static void io_iopoll_kiocb_issued(struct io_kiocb *kiocb)
 	spin_unlock(&ctx->poll_lock);
 }
 
+static void io_iopoll_iocb_add_state(struct io_submit_state *state,
+				     struct io_kiocb *kiocb)
+{
+	if (test_bit(KIOCB_F_IOPOLL_COMPLETED, &kiocb->ki_flags))
+		list_add(&kiocb->ki_list, &state->req_list);
+	else
+		list_add_tail(&kiocb->ki_list, &state->req_list);
+
+	if (++state->req_count >= IO_IOPOLL_BATCH)
+		io_flush_state_reqs(state->ctx, state);
+}
+
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void io_iopoll_kiocb_issued(struct io_submit_state *state,
+				   struct io_kiocb *kiocb)
+{
+	if (!state || !IS_ENABLED(CONFIG_BLOCK))
+		io_iopoll_iocb_add_list(kiocb);
+	else
+		io_iopoll_iocb_add_state(state, kiocb);
+}
+
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -624,7 +674,8 @@ static int io_fsync(struct io_kiocb *kiocb, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
+static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			 struct io_submit_state *state)
 {
 	const struct io_uring_sqe *sqe = s->sqe;
 	struct io_kiocb *req;
@@ -673,7 +724,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		io_iopoll_kiocb_issued(req);
+		io_iopoll_kiocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -681,6 +732,43 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return ret;
 }
 
+#ifdef CONFIG_BLOCK
+static void io_state_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct io_submit_state *state;
+
+	state = container_of(cb, struct io_submit_state, plug_cb);
+	if (!list_empty(&state->req_list))
+		io_flush_state_reqs(state->ctx, state);
+}
+#endif
+
+/*
+ * Batched submission is done, ensure local IO is flushed out.
+ */
+static void io_submit_state_end(struct io_submit_state *state)
+{
+	blk_finish_plug(&state->plug);
+	if (!list_empty(&state->req_list))
+		io_flush_state_reqs(state->ctx, state);
+}
+
+/*
+ * Start submission side cache.
+ */
+static void io_submit_state_start(struct io_submit_state *state,
+				  struct io_ring_ctx *ctx)
+{
+	state->ctx = ctx;
+	INIT_LIST_HEAD(&state->req_list);
+	state->req_count = 0;
+#ifdef CONFIG_BLOCK
+	state->plug_cb.callback = io_state_unplug;
+	blk_start_plug(&state->plug);
+	list_add(&state->plug_cb.list, &state->plug.cb_list);
+#endif
+}
+
 static void io_inc_sqring(struct io_ring_ctx *ctx)
 {
 	struct io_sq_ring *ring = ctx->sq_ring;
@@ -715,11 +803,13 @@ static bool io_peek_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
+	struct io_submit_state state, *statep = NULL;
 	int i, ret = 0, submit = 0;
-	struct blk_plug plug;
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+	if (to_submit > IO_PLUG_THRESHOLD) {
+		io_submit_state_start(&state, ctx);
+		statep = &state;
+	}
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
@@ -727,7 +817,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!io_peek_sqring(ctx, &s))
 			break;
 
-		ret = io_submit_sqe(ctx, &s);
+		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret)
 			break;
 
@@ -735,8 +825,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		io_inc_sqring(ctx);
 	}
 
-	if (to_submit > IO_PLUG_THRESHOLD)
-		blk_finish_plug(&plug);
+	if (statep)
+		io_submit_state_end(statep);
 
 	return submit ? submit : ret;
 }
-- 
2.17.1

