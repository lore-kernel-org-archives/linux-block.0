Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F24C10F14
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 01:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B020859
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 01:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfJIBUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:20:20 -0400
Received: from smtpbg703.qq.com ([203.205.195.89]:43693 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729700AbfJIBUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 21:20:19 -0400
X-QQ-mid: bizesmtp27t1570584004tqzg8s3v
Received: from Macbook.pro (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 09 Oct 2019 09:20:03 +0800 (CST)
X-QQ-SSF: 01400000002000S0ZT90B00A0000000
X-QQ-FEAT: oPf+tCeE8zHHdldPQV0vtMQwNHGgRK5BLpSPD6FbQqwzt5qgYaD/zZnxw3g9w
        ZxFb7RDxMxNDv7FUaCZOkEI6ZBeMqdpKmaHPfU3NsqGPBgU3xCLqk3C+5vKY8th6S9auhdk
        SUnSxP+XRO1TLT57NQ96cdipKJt4Jlg+SG/DGYGSIJXVKT6Y4CYmMCccJsuAR93Z96lcWBh
        Xi/jzz5g9PNGVXdnwoVMaQ3pTd7/Cmgeh99/oQB9g966qvxlHNNEJrKY4SycDMJ6HVhHjl2
        79FcnubukZZ3nCjdqu11PPIwjjnsRY4FfzfPiPOkvlZqM2t3rEfsD5XRMpSovFTnysabrhl
        g4ypIV4
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] io_uring: replace s->needs_lock with s->in_async
Date:   Wed,  9 Oct 2019 09:19:59 +0800
Message-Id: <20191009011959.2203-2-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009011959.2203-1-liuyun01@kylinos.cn>
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no function change, just to clean up the code, use s->in_async
to make the code know where it is.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8ec2443eb019..3bb638b26cb7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -268,7 +268,7 @@ struct sqe_submit {
 	unsigned short			index;
 	u32				sequence;
 	bool				has_user;
-	bool				needs_lock;
+	bool				in_async;
 	bool				needs_fixed_file;
 };
 
@@ -1390,11 +1390,7 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
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
@@ -1432,8 +1428,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 
 	ret = -EAGAIN;
 	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
-		/* If ->needs_lock is true, we're already in async context. */
-		if (!s->needs_lock)
+		if (!s->in_async)
 			io_async_list_note(WRITE, req, iov_count);
 		goto out_free;
 	}
@@ -1464,11 +1459,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
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
@@ -2029,10 +2020,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
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
 
@@ -2096,7 +2087,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		if (!ret) {
 			s->has_user = cur_mm != NULL;
-			s->needs_lock = true;
+			s->in_async = true;
 			do {
 				ret = __io_submit_sqe(ctx, req, s, false);
 				/*
@@ -2552,7 +2543,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 						-EFAULT);
 		} else {
 			sqes[i].has_user = has_user;
-			sqes[i].needs_lock = true;
+			sqes[i].in_async = true;
 			sqes[i].needs_fixed_file = true;
 			io_submit_sqe(ctx, &sqes[i], statep, &link, true);
 			submitted++;
@@ -2738,7 +2729,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 
 out:
 		s.has_user = true;
-		s.needs_lock = false;
+		s.in_async = false;
 		s.needs_fixed_file = false;
 		submit++;
 
-- 
2.23.0



