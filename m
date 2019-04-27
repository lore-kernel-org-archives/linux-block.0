Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADB0C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 18:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A9A2087C
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="rTA/QYx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfD0SeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:34:22 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:35224 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0SeV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 14:34:21 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id DA195C026CE;
        Sat, 27 Apr 2019 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556390060;
        bh=IT64ugDpk+pFdP05DEv/1yWTOO2CvJ5+twY5z2jk7+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rTA/QYx2SXZHmWDrkdKufohyqe/Cs5vL/p2oYKXeZb6mwhrjSHmahdE0LIR4ZZzrZ
         hIkTTsZxljz52g0QjF8CUoqd5yywT1BJiynCQlVDDS8vOWnDKLAZKYTee6lOIpy2vD
         H3FO+18Whef3f53j04XSlQzcpqHRaQef4VCl7rxw=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] [io_uring] fix handling SQEs requesting NOWAIT
Date:   Sat, 27 Apr 2019 20:34:19 +0200
Message-Id: <20190427183419.5971-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7bcb0eb3-46d1-70e4-1108-dfd9a348bb7c@stbuehler.de>
References: <7bcb0eb3-46d1-70e4-1108-dfd9a348bb7c@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not all request types set REQ_F_FORCE_NONBLOCK when they needed async
punting; reverse logic instead and set REQ_F_NOWAIT if request mustn't
be punted.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 25632e399a78..77b247b5d10b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -322,7 +322,7 @@ struct io_kiocb {
 	struct list_head	list;
 	unsigned int		flags;
 	refcount_t		refs;
-#define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
+#define REQ_F_NOWAIT		1	/* must not punt to workers */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
@@ -872,11 +872,14 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
 	if (unlikely(ret))
 		return ret;
-	/* only force async punt if the sqe didn't ask for NOWAIT */
-	if (force_nonblock && !(kiocb->ki_flags & IOCB_NOWAIT)) {
+
+	/* don't allow async punt if RWF_NOWAIT was requested */
+	if (kiocb->ki_flags & IOCB_NOWAIT)
+		req->flags |= REQ_F_NOWAIT;
+
+	if (force_nonblock)
 		kiocb->ki_flags |= IOCB_NOWAIT;
-		req->flags |= REQ_F_FORCE_NONBLOCK;
-	}
+
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
 		if (!(kiocb->ki_flags & IOCB_DIRECT) ||
 		    !kiocb->ki_filp->f_op->iopoll)
@@ -1535,8 +1538,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		struct sqe_submit *s = &req->submit;
 		const struct io_uring_sqe *sqe = s->sqe;
 
-		/* Ensure we clear previously set forced non-block flag */
-		req->flags &= ~REQ_F_FORCE_NONBLOCK;
+		/* Ensure we clear previously set non-block flag */
 		req->rw.ki_flags &= ~IOCB_NOWAIT;
 
 		ret = 0;
@@ -1722,7 +1724,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		goto out;
 
 	ret = __io_submit_sqe(ctx, req, s, true);
-	if (ret == -EAGAIN && (req->flags & REQ_F_FORCE_NONBLOCK)) {
+	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
-- 
2.20.1

