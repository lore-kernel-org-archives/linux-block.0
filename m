Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4CC4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A39218AF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfIIMvM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:51:12 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:36875 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfIIMvM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Sep 2019 08:51:12 -0400
X-QQ-mid: bizesmtp11t1568033453tf4qhb1h
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 09 Sep 2019 20:50:53 +0800 (CST)
X-QQ-SSF: 01400000002000R0YS90000A0000000
X-QQ-FEAT: gDbwoeOnDAEuwlpPa1umbkYuO1HekZrCNkyN/Ro43B4CgwBXBW493VH6JKLWt
        e1ZRBc7KFXOX9xGNFBlFyvw6amd54Kw7qFOWXqvY4n2adcK49srp4/zKpTr8QvLlidMIs8w
        Ixq8n3d70mWAnLHOlCSNGCBrTaTC1RavvKJ5673xpyGCu/RVo/TWFIUgb1e5Rdj1ISS6Vip
        L0VF2F/SgtmbTuWIhmT3x8dYwg5dlYI7tz5uqatDjtwMaOZ3r5qWvYPSC1cwh3x0+U7Dubj
        yhEU3GyUUrk7AgdS/2glCHTSqYFVb+izwgOvX2eHirnjd2wm6ZSQ3xpIQtrG9++H+fjJo3v
        gSJW8cVZ5pk4JwpFSrgoE+lOAgtNQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 2/2] io_uring: add support for link with drain
Date:   Mon,  9 Sep 2019 20:50:40 +0800
Message-Id: <20190909125040.7119-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909125040.7119-1-liuyun01@kylinos.cn>
References: <20190909125040.7119-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To support the link with drain, we need to do two parts.

There is an sqes:

    0     1     2     3     4     5     6
 +-----+-----+-----+-----+-----+-----+-----+
 |  N  |  L  |  L  | L+D |  N  |  N  |  N  |
 +-----+-----+-----+-----+-----+-----+-----+

First, we need to ensure that the io before the link is completed,
there is a easy way is set drain flag to the link list's head, so
all subsequent io will be inserted into the defer_list.

	+-----+
    (0) |  N  |
	+-----+
           |          (2)         (3)         (4)
	+-----+     +-----+     +-----+     +-----+
    (1) | L+D | --> |  L  | --> | L+D | --> |  N  |
	+-----+     +-----+     +-----+     +-----+
           |
	+-----+
    (5) |  N  |
	+-----+
           |
	+-----+
    (6) |  N  |
	+-----+

Second, ensure that the following IO will not be completed first,
an easy way is to create a mirror of drain io and insert it into
defer_list, in this way, as long as drain io is not processed, the
following io in the defer_list will not be actively process.

	+-----+
    (0) |  N  |
	+-----+
           |          (2)         (3)         (4)
	+-----+     +-----+     +-----+     +-----+
    (1) | L+D | --> |  L  | --> | L+D | --> |  N  |
	+-----+     +-----+     +-----+     +-----+
           |
	+-----+
   ('3) |  D  |   <== This is a shadow of (3)
	+-----+
           |
	+-----+
    (5) |  N  |
	+-----+
           |
	+-----+
    (6) |  N  |
	+-----+

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 114 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 06d048341fa4..b03630ced9ae 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -336,6 +336,7 @@ struct io_kiocb {
 #define REQ_F_LINK		64	/* linked sqes */
 #define REQ_F_LINK_DONE		128	/* linked sqes done */
 #define REQ_F_FAIL_LINK		256	/* fail rest of links */
+#define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -367,6 +368,7 @@ struct io_submit_state {
 };
 
 static void io_sq_wq_submit_work(struct work_struct *work);
+static void __io_free_req(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -472,6 +474,11 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 	__io_commit_cqring(ctx);
 
 	while ((req = io_get_deferred_req(ctx)) != NULL) {
+		if (req->flags & REQ_F_SHADOW_DRAIN) {
+			/* Just for drain, free it. */
+			__io_free_req(req);
+			continue;
+		}
 		req->flags |= REQ_F_IO_DRAINED;
 		queue_work(ctx->sqo_wq, &req->work);
 	}
@@ -2039,10 +2046,14 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	flags = READ_ONCE(s->sqe->flags);
 	fd = READ_ONCE(s->sqe->fd);
 
-	if (flags & IOSQE_IO_DRAIN) {
+	if (flags & IOSQE_IO_DRAIN)
 		req->flags |= REQ_F_IO_DRAIN;
-		req->sequence = s->sequence;
-	}
+	/*
+	 * All io need record the previous position, if LINK vs DARIN,
+	 * it can be used to mark the position of the first IO in the
+	 * link list.
+	 */
+	req->sequence = s->sequence;
 
 	if (!io_op_needs_file(s->sqe))
 		return 0;
@@ -2064,20 +2075,11 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	return 0;
 }
 
-static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			struct sqe_submit *s)
 {
 	int ret;
 
-	ret = io_req_defer(ctx, req, s->sqe);
-	if (ret) {
-		if (ret != -EIOCBQUEUED) {
-			io_free_req(req);
-			io_cqring_add_event(ctx, s->sqe->user_data, ret);
-		}
-		return 0;
-	}
-
 	ret = __io_submit_sqe(ctx, req, s, true);
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
@@ -2120,6 +2122,64 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	return ret;
 }
 
+static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			struct sqe_submit *s)
+{
+	int ret;
+
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret) {
+		if (ret != -EIOCBQUEUED) {
+			io_free_req(req);
+			io_cqring_add_event(ctx, s->sqe->user_data, ret);
+		}
+		return 0;
+	}
+
+	return __io_queue_sqe(ctx, req, s);
+}
+
+static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			      struct sqe_submit *s, struct io_kiocb *shadow)
+{
+	int ret;
+	int need_submit = false;
+
+	if (!shadow)
+		return io_queue_sqe(ctx, req, s);
+
+	/*
+	 * Mark the first IO in link list as DRAIN, let all the following
+	 * IOs enter the defer list. all IO needs to be completed before link
+	 * list.
+	 */
+	req->flags |= REQ_F_IO_DRAIN;
+	ret = io_req_defer(ctx, req, s->sqe);
+	if (ret) {
+		if (ret != -EIOCBQUEUED) {
+			io_free_req(req);
+			io_cqring_add_event(ctx, s->sqe->user_data, ret);
+			return 0;
+		}
+	} else {
+		/*
+		 * If ret == 0 means that all IOs in front of link io are
+		 * running done. let's queue link head.
+		 */
+		need_submit = true;
+	}
+
+	/* Insert shadow req to defer_list, blocking next IOs */
+	spin_lock_irq(&ctx->completion_lock);
+	list_add_tail(&shadow->list, &ctx->defer_list);
+	spin_unlock_irq(&ctx->completion_lock);
+
+	if (need_submit)
+		return __io_queue_sqe(ctx, req, s);
+
+	return 0;
+}
+
 #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK)
 
 static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
@@ -2264,6 +2324,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
+	struct io_kiocb *shadow_req = NULL;
 	bool prev_was_link = false;
 	int i, submitted = 0;
 
@@ -2278,11 +2339,20 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!prev_was_link && link) {
-			io_queue_sqe(ctx, link, &link->submit);
+			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
 		}
 		prev_was_link = (sqes[i].sqe->flags & IOSQE_IO_LINK) != 0;
 
+		if (link && (sqes[i].sqe->flags & IOSQE_IO_DRAIN)) {
+			if (!shadow_req) {
+				shadow_req = io_get_req(ctx, NULL);
+				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
+				refcount_dec(&shadow_req->refs);
+			}
+			shadow_req->sequence = sqes[i].sequence;
+		}
+
 		if (unlikely(mm_fault)) {
 			io_cqring_add_event(ctx, sqes[i].sqe->user_data,
 						-EFAULT);
@@ -2296,7 +2366,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 	}
 
 	if (link)
-		io_queue_sqe(ctx, link, &link->submit);
+		io_queue_link_head(ctx, link, &link->submit, shadow_req);
 	if (statep)
 		io_submit_state_end(&state);
 
@@ -2432,6 +2502,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
 	struct io_kiocb *link = NULL;
+	struct io_kiocb *shadow_req = NULL;
 	bool prev_was_link = false;
 	int i, submit = 0;
 
@@ -2451,11 +2522,20 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		 * that's the end of the chain. Submit the previous link.
 		 */
 		if (!prev_was_link && link) {
-			io_queue_sqe(ctx, link, &link->submit);
+			io_queue_link_head(ctx, link, &link->submit, shadow_req);
 			link = NULL;
 		}
 		prev_was_link = (s.sqe->flags & IOSQE_IO_LINK) != 0;
 
+		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
+			if (!shadow_req) {
+				shadow_req = io_get_req(ctx, NULL);
+				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
+				refcount_dec(&shadow_req->refs);
+			}
+			shadow_req->sequence = s.sequence;
+		}
+
 		s.has_user = true;
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
@@ -2465,7 +2545,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	io_commit_sqring(ctx);
 
 	if (link)
-		io_queue_sqe(ctx, link, &link->submit);
+		io_queue_link_head(ctx, link, &link->submit, shadow_req);
 	if (statep)
 		io_submit_state_end(statep);
 
-- 
2.23.0



