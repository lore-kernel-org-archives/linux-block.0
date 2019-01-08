Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D4AC43612
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6502183F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PCmJo9Yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfAHQ5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39488 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfAHQ5G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:06 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so6927930itl.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u26EGdJD+JR7lvJxPBNP6VWIt303xqioYXa90ZvBUdA=;
        b=PCmJo9YpzYTov01ZDphUrTNdlRewGcZiZF+8Bqrk+HsqiuKD/rXBQCNbu81KBYQTLH
         TzZLP+ZXd6BO8yBUvKQqk5IeqnB/9An2wv3WfykSSg5ZwaQSZqSeBCF3x58d/A0bmguP
         ucDBXe4DhYmxpaSMI556aj/n5Y3uZpF1zW52iUDRk3ZZhY95maICZxfwqd9asEmirmBo
         ClgpJzlPZ3cjuVbpImxPoMEJbGP7Kt1I0ZPCn0du6QMmhNOlx4sX6RY+OHMkmohsmZep
         BK5p2a5ePXRYB39JPs/esRioJMpuGhSLb7RZmrKx1WXR3J3ne4T4WiryTdk+sMtzuc2R
         lbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u26EGdJD+JR7lvJxPBNP6VWIt303xqioYXa90ZvBUdA=;
        b=gi3cm9tOY5kif+WYE2y/gHTJQGBAadMKMwK4OpvOxFnTbE7tSgL+SQf/TZ84RqJrlU
         h0JtPh1CM6W4d2y1GIQzmWO4zADa4ZFeiLdoBINBXK4hiBDK3Q0tbBi/wHEqyDDJ3ZCl
         xrnUgssOcQzSzdNyGxzN/26pkuv53e55X8N8nz76IgcBO2h72dE4ZWysucoAASQIJSie
         hYl99v+6weX+2+BPKgeiC0E03oycOYCw8U+1co7Q/ZqMNCegekwzIud/26a6/nPmEmtX
         vOX8L6vW0wC477D8vFm70NQmj9YfYu79bOHoAE3mugoiTn0yl6Q0ZKOr/mU+cfijMsvf
         gu0w==
X-Gm-Message-State: AJcUukdKOTYI4Doz1/O0V0N9rxZ1thGT+q3vZhshqr8Nsjv10y4xh9vD
        kIvsN+iCcoK7PHyJQCChrqZEbA==
X-Google-Smtp-Source: ALg8bN6FEx9kjlndnlitAQLs/BnfTl2aafA6DQQ1pmrcl5ZeJwdSjhLcwRm92gk4YOU0GoVRc4+z3Q==
X-Received: by 2002:a02:4958:: with SMTP id z85mr1685910jaa.6.1546966625610;
        Tue, 08 Jan 2019 08:57:05 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] io_uring: add submission side request cache
Date:   Tue,  8 Jan 2019 09:56:36 -0700
Message-Id: <20190108165645.19311-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have to add each submitted polled request to the io_context
poll_submitted list, which means we have to grab the poll_lock. We
already use the block plug to batch submissions if we're doing a batch
of IO submissions, extend that to cover the poll requests internally as
well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 122 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 02eab2f42c63..9f36eb728208 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -121,6 +121,21 @@ struct io_kiocb {
 
 #define IO_IOPOLL_BATCH	8
 
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
 static struct kmem_cache *kiocb_cachep, *ioctx_cachep;
 
 static const struct file_operations io_scqring_fops;
@@ -494,21 +509,29 @@ static inline void io_rw_done(struct kiocb *req, ssize_t ret)
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
-static void io_iopoll_iocb_issued(struct io_kiocb *kiocb)
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
@@ -517,6 +540,33 @@ static void io_iopoll_iocb_issued(struct io_kiocb *kiocb)
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
+static void io_iopoll_iocb_issued(struct io_submit_state *state,
+				  struct io_kiocb *kiocb)
+{
+	if (!state || !IS_ENABLED(CONFIG_BLOCK))
+		io_iopoll_iocb_add_list(kiocb);
+	else
+		io_iopoll_iocb_add_state(state, kiocb);
+}
+
 static ssize_t io_read(struct io_kiocb *kiocb, const struct io_uring_iocb *iocb)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
@@ -632,7 +682,8 @@ static int io_fsync(struct fsync_iocb *req, const struct io_uring_iocb *iocb,
 
 static int __io_submit_one(struct io_ring_ctx *ctx,
 			   const struct io_uring_iocb *iocb,
-			   unsigned long ki_index)
+			   unsigned long ki_index,
+			   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 	ssize_t ret;
@@ -684,7 +735,7 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		io_iopoll_iocb_issued(req);
+		io_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -692,6 +743,43 @@ static int __io_submit_one(struct io_ring_ctx *ctx,
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
 	struct io_sq_ring *ring = ctx->sq_ring.ring;
@@ -726,11 +814,13 @@ static const struct io_uring_iocb *io_peek_sqring(struct io_ring_ctx *ctx,
 
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
 		const struct io_uring_iocb *iocb;
@@ -740,7 +830,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		if (!iocb)
 			break;
 
-		ret = __io_submit_one(ctx, iocb, iocb_index);
+		ret = __io_submit_one(ctx, iocb, iocb_index, statep);
 		if (ret)
 			break;
 
@@ -748,8 +838,8 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
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

