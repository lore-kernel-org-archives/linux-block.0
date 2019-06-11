Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D4C4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C3208E3
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404420AbfFKJbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:31:50 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:50056 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfFKJbu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 05:31:50 -0400
X-QQ-mid: bizesmtp28t1560244170tbf8smbz
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 11 Jun 2019 17:09:29 +0800 (CST)
X-QQ-SSF: 01400000002000Q0WN60000A0000000
X-QQ-FEAT: +zKhtBiG+ybzDjhTRh0Krit0Lc54Bworhir1RDcgTVC3vFAqv+I3FRXmY4wBe
        7qdQxv+dR3Kw9HOhcK6vVLnjJRnf7j5smTJNmVuymaV3EejAVvh0LS8WiC7bwhWPGK0pFWK
        GnRarP9KDYLeQZ3jP/jyg1fxlg/DYJZBFwpuVw1zcjZ4gaX+xDLF8uTZKGKgQBRFALiTcaf
        9TGELvr2JSm5SiLPsYfkcjUeKKd9T9DbjCLYbvVeheZ+DNVMCy9aipvuoPPh225psKtKa2h
        dlWZQdKlzAnDA2VEjtJoGpL8gzGxDp/ZaqYH1yQqm7sT32c8PDcZgZapqD7qAHj8IAX7BCa
        e26l2SVXU2GXNKEQruLC7nFzJskuA==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: replace ->needs_lock to ->in_async
Date:   Tue, 11 Jun 2019 17:09:23 +0800
Message-Id: <1560244163-12908-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the current, ->needs_lock not only determines whether a lock is
needed, but also determines whether the process is in an async context.
using in_async to make it more clearly and avoid confusion.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0fbb486..3745fd7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -288,7 +288,7 @@ struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	unsigned short			index;
 	bool				has_user;
-	bool				needs_lock;
+	bool				in_async;
 	bool				needs_fixed_file;
 };
 
@@ -1115,11 +1115,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
 		} else {
-			/*
-			 * If ->needs_lock is true, we're already in async
-			 * context.
-			 */
-			if (!s->needs_lock)
+			if (!s->in_async)
 				io_async_list_note(READ, req, iov_count);
 			ret = -EAGAIN;
 		}
@@ -1156,8 +1152,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 
 	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
-		/* If ->needs_lock is true, we're already in async context. */
-		if (!s->needs_lock)
+		if (!s->in_async)
 			io_async_list_note(WRITE, req, iov_count);
 		goto out_free;
 	}
@@ -1185,11 +1180,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		if (!force_nonblock || ret2 != -EAGAIN) {
 			io_rw_done(kiocb, ret2);
 		} else {
-			/*
-			 * If ->needs_lock is true, we're already in async
-			 * context.
-			 */
-			if (!s->needs_lock)
+			if (!s->in_async)
 				io_async_list_note(WRITE, req, iov_count);
 			ret = -EAGAIN;
 		}
@@ -1601,10 +1592,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			return -EAGAIN;
 
 		/* workqueue context doesn't hold uring_lock, grab it now */
-		if (s->needs_lock)
+		if (s->in_async)
 			mutex_lock(&ctx->uring_lock);
 		io_iopoll_req_issued(req);
-		if (s->needs_lock)
+		if (s->in_async)
 			mutex_unlock(&ctx->uring_lock);
 	}
 
@@ -1667,7 +1658,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		if (!ret) {
 			s->has_user = cur_mm != NULL;
-			s->needs_lock = true;
+			s->in_async = true;
 			do {
 				ret = __io_submit_sqe(ctx, req, s, false);
 				/*
@@ -1982,7 +1973,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			ret = -EFAULT;
 		} else {
 			sqes[i].has_user = has_user;
-			sqes[i].needs_lock = true;
+			sqes[i].in_async = true;
 			sqes[i].needs_fixed_file = true;
 			ret = io_submit_sqe(ctx, &sqes[i], statep);
 		}
@@ -2149,7 +2140,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 			break;
 
 		s.has_user = true;
-		s.needs_lock = false;
+		s.in_async = false;
 		s.needs_fixed_file = false;
 		submit++;
 
-- 
2.7.4



