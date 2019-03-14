Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD90BC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3A20854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JBpRAYhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfCNUon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:43 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53191 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfCNUom (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:42 -0400
Received: by mail-it1-f196.google.com with SMTP id g17so6937672ita.2
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBY/WCiVRIxbJHK0kuOFwZ092MB3IurzrK4hVX4OtTY=;
        b=JBpRAYhxAe886ZlTGumenA/bmp0aXfOIQRv7lYKKicY+m4mpSvszGd2WXd8whaex/7
         J1C4bnT4YmPQhYQd2YofGQ5OkpMx1mJRMKbGyO/pigiTf5FyIUDSkQSgMr+Qzn8ax8+k
         tYzk9mrnSp3DfgTSA7CH8QreWOzJ0dKNiQBZ0Vs57ywQLEQK9153lKkHFnxlm6amY6U1
         i+n3BuQddvNyBMqLMHB5V+zoNQgYJyoCG2DcPhp1aDlkr4vCYT2C+t07YxRgWjwUeF9p
         KhbFISCHUOvYQvV7cOtqPQLTOgJzJxwLZk62cILjC+2PmbbOXY+8dtYfNoyoT4cEsDrm
         dcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBY/WCiVRIxbJHK0kuOFwZ092MB3IurzrK4hVX4OtTY=;
        b=W29AJuuRhQTr0iat/Tp9jizxJpBihCasvC50+xAUDheXvopQQ756KI7oJcu0eBwwmP
         h6WCxuh/jqnLaXMVWnPcK1Q6KynykDPuQybnlEL/+V/b+RcTomf37xNzTSOn4kB8HeBg
         7QWCQ9iDkI5COPRBARz/iciCBFyUO6Y7Mx7zaBRPYdeGGGLpu3vdQV+YPT2t/bhxMs5s
         RpEU1YFKLoc3a+2mg3g8H0kEmYhY7aEcsWybGPznRJlAqGSJ9BSJ1U2sUkiLBn9cXsQf
         H6vWBIPROk2jM5ZAD73AaU+saG+Ez5LBELgHsQgLX3oo/69vL2EwYd1exPYubXS1odaJ
         3NZQ==
X-Gm-Message-State: APjAAAU9jsQUVNdrxNYtnM0gVctoBYXLzytfSH4LrRkHlD6vZTHtzrxW
        Dt/0F8P4f+B1qVkxYJ7tjGET6w==
X-Google-Smtp-Source: APXvYqz19xrvsclOb7WZ+9n2HEubMwEqy2CZApJhX7+Iikb3e6RLK6cgj0IJz3vB5eoEJitWzMdKSQ==
X-Received: by 2002:a02:4084:: with SMTP id n126mr150388jaa.78.1552596281319;
        Thu, 14 Mar 2019 13:44:41 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/8] io_uring: use regular request ref counts
Date:   Thu, 14 Mar 2019 14:44:28 -0600
Message-Id: <20190314204435.7692-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the special casing of "normal" requests not having
any references to the io_kiocb. We initialize the ref count to 2,
one for the submission side, and one or the completion side.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5d99376d2369..c54af70c72fd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -411,7 +411,8 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
-	refcount_set(&req->refs, 0);
+	/* one is dropped after submission, the other at completion */
+	refcount_set(&req->refs, 2);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -429,10 +430,14 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
 static void io_free_req(struct io_kiocb *req)
 {
-	if (!refcount_read(&req->refs) || refcount_dec_and_test(&req->refs)) {
-		io_ring_drop_ctx_refs(req->ctx, 1);
-		kmem_cache_free(req_cachep, req);
-	}
+	io_ring_drop_ctx_refs(req->ctx, 1);
+	kmem_cache_free(req_cachep, req);
+}
+
+static void io_put_req(struct io_kiocb *req)
+{
+	if (refcount_dec_and_test(&req->refs))
+		io_free_req(req);
 }
 
 /*
@@ -453,7 +458,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 
 		io_cqring_fill_event(ctx, req->user_data, req->error, 0);
 
-		reqs[to_free++] = req;
+		if (refcount_dec_and_test(&req->refs))
+			reqs[to_free++] = req;
 		(*nr_events)++;
 
 		/*
@@ -616,7 +622,7 @@ static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 
 	io_fput(req);
 	io_cqring_add_event(req->ctx, req->user_data, res, 0);
-	io_free_req(req);
+	io_put_req(req);
 }
 
 static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
@@ -1083,7 +1089,7 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 		io_fput(req);
 	}
 	io_cqring_add_event(ctx, user_data, err, 0);
-	io_free_req(req);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1146,7 +1152,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	io_fput(req);
 	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
-	io_free_req(req);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1204,7 +1210,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
-	io_free_req(req);
+	io_put_req(req);
 	return 0;
 }
 
@@ -1212,7 +1218,7 @@ static void io_poll_complete(struct io_kiocb *req, __poll_t mask)
 {
 	io_cqring_add_event(req->ctx, req->user_data, mangle_poll(mask), 0);
 	io_fput(req);
-	io_free_req(req);
+	io_put_req(req);
 }
 
 static void io_poll_complete_work(struct work_struct *work)
@@ -1346,9 +1352,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	INIT_LIST_HEAD(&poll->wait.entry);
 	init_waitqueue_func_entry(&poll->wait, io_poll_wake);
 
-	/* one for removal from waitqueue, one for this function */
-	refcount_set(&req->refs, 2);
-
 	mask = vfs_poll(poll->file, &ipt.pt) & poll->events;
 	if (unlikely(!poll->head)) {
 		/* we did not manage to set up a waitqueue, done */
@@ -1380,13 +1383,12 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		 * Drop one of our refs to this req, __io_submit_sqe() will
 		 * drop the other one since we're returning an error.
 		 */
-		io_free_req(req);
+		io_put_req(req);
 		return ipt.error;
 	}
 
 	if (mask)
 		io_poll_complete(req, mask);
-	io_free_req(req);
 	return 0;
 }
 
@@ -1524,10 +1526,13 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 					break;
 				cond_resched();
 			} while (1);
+
+			/* drop submission reference */
+			io_put_req(req);
 		}
 		if (ret) {
 			io_cqring_add_event(ctx, sqe->user_data, ret, 0);
-			io_free_req(req);
+			io_put_req(req);
 		}
 
 		/* async context always use a copy of the sqe */
@@ -1617,6 +1622,7 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 			 struct io_submit_state *state)
 {
+	bool did_submit = true;
 	struct io_kiocb *req;
 	ssize_t ret;
 
@@ -1650,10 +1656,16 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 				queue_work(ctx->sqo_wq, &req->work);
 			}
 			ret = 0;
+			did_submit = false;
 		}
 	}
+
+	/* drop submission reference, if we did the submit */
+	if (did_submit)
+		io_put_req(req);
+
 	if (ret)
-		io_free_req(req);
+		io_put_req(req);
 
 	return ret;
 }
-- 
2.17.1

