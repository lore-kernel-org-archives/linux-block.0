Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5175C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E46A218B0
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QY5YqW+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfCOOyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:54:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44237 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfCOOyu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:54:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id h34so6622094pgh.11
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=975aIYGsayGhYwnFheH5tzZGlPlxWAP+69eiKl725fc=;
        b=QY5YqW+AVRpk0VH2egU18qARYZ1kuUI/1JRMjcRQh2zMEzeZefQzhlaTJ1jS6qStZn
         jEmPalCvQf+tIb8KGOtnbVYVFwlp4Hm3p82/WZQdS9R1GJjW9dvuvEWJx5cknp4J0bGs
         xVaH4KFZWhx4cBIcc77+du7YkdiU+eC0WX3IENhXMmE7V4NdOBbfmtraGkXY+5z1nboQ
         NY86FXCeO4brCurkTt95xRAkDnB/L0pGLpaDrCdHd5Hf3Hph3M2nQUH9h4LCuLujAcxx
         6oVsU58KVBNGum8S5tjYaEG382JtzamVvbtI+rfq0/6/wz5K9Ulk/zRIHggDzTKayqXn
         WeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=975aIYGsayGhYwnFheH5tzZGlPlxWAP+69eiKl725fc=;
        b=pdYES4JyJSf2me1s0Qjyf7X4CKTbUTE9f/JaXGSHbnPFF00rVgRMbQWylVXnmzoPKT
         //oIOLN5VQkK6LwX+kx+AAHEBq2VXOyaZDBJaMZIl/nTa5+xnuic8kreHnGXZ8R52Apa
         l4l/B6BjLxFFE4ZjFcZbgnHyQGj8G3dVJgpv5TEuNFI+W/5lizqWIgCaUOhrFot2Lpo+
         TuMKWT1js4Q2JGbqUNK0s1eRfqyEgTgoh2LXiyYpV7s1OA+Dm17WPc1pu0WmMxxEfcKm
         LQrHYGIyi0bbLgoCaPJ1rjoYYpuZAH2u+XCNDaRSfTwLzCSLA7kmDdjAUtbkVZHnwAy8
         mV6g==
X-Gm-Message-State: APjAAAUKelf8tfNGyafjlACPl/bA1HaXtTRjgcrw2og30W/1+uc3nN1O
        UVIbBoKU3nXA33H4D2JuL5bBJQ==
X-Google-Smtp-Source: APXvYqwb3VQdeu5FjHc3UYDajBCDdERyhsFpzgPZgtcmQlrP27xdSmLjRHCzryGcM4O3thJ7CxsUcA==
X-Received: by 2002:a17:902:24:: with SMTP id 33mr4678757pla.259.1552661689647;
        Fri, 15 Mar 2019 07:54:49 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/7] io_uring: use regular request ref counts
Date:   Fri, 15 Mar 2019 08:54:36 -0600
Message-Id: <20190315145442.21127-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145442.21127-1-axboe@kernel.dk>
References: <20190315145442.21127-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the special casing of "normal" requests not having
any references to the io_kiocb. We initialize the ref count to 2,
one for the submission side, and one or the completion side.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 54 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5d99376d2369..9071fca118a4 100644
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
@@ -1649,11 +1654,22 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 				INIT_WORK(&req->work, io_sq_wq_submit_work);
 				queue_work(ctx->sqo_wq, &req->work);
 			}
-			ret = 0;
+
+			/*
+			 * Queued up for async execution, worker will release
+			 * submit reference when the iocb is actually
+			 * submitted.
+			 */
+			return 0;
 		}
 	}
+
+	/* drop submission reference */
+	io_put_req(req);
+
+	/* and drop final reference, if we failed */
 	if (ret)
-		io_free_req(req);
+		io_put_req(req);
 
 	return ret;
 }
-- 
2.17.1

