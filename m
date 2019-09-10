Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06729C49ED9
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3282081B
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VDN6Wot5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436804AbfIJQmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:42:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39721 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 12:42:53 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so39060353iob.6
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erDlxDys0t8WpBq+zqMKzIRo/C474YAPos4V7tw1nok=;
        b=VDN6Wot53pGyvNMxd1NuXkR9O8fyGB9EUkaBerb4Q/iNg+GA3BuGgzfCWIA1e3J0PM
         CbHMGl3Y6LRTqWeHVwFWIJwQlk0o+g5/iy3KPATyvgj/KuwhkrvXpypzdRd5k8iktAHb
         BZIhFBocSTUI8Q+4w3fwhzRnsdRI3Scqzrnrtrm4EkOtCPED6qioNVhw35kXAr+ct/a8
         ST1oq8CerNFT5hpjAgNDy+oO9oMz5192s9aLE26SyvN+iXapnLK1IFG4POg6RD9O6C4H
         0nh1uX0l2Mcz9AN1ScbOvDZCqwZ7gAxF3VXQR8eQI/zvWIdhEeaxLPvX9Mgv7h4ljNGY
         cYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erDlxDys0t8WpBq+zqMKzIRo/C474YAPos4V7tw1nok=;
        b=V5qvE9Oa2m7Xsh8ittzKOwydMBb5WTGlAOtldWrj/YxI8eJtTtkRi8ZhEzfrNf5X6r
         dmhPIe77hajLfg7lX6eJ6OoWaF3vcIwzmn588Nys2lTkYdrIGA9Hr5bax0FGZDx4/c/J
         BCqgocIARGa0XvkfTwFLkbWm6O+9bghW7PeOkGmKafVKzIGtVUW9ALClPPMVeQfnWCbf
         6iBVvDsj32oqeiwxlIALAa3r5G1SMcKwWeFJyKzUws4abKURwsGyRGThFdb4dswiCJ/h
         sTAp21WMmQRxbZZhVa18AxZCAA6jMscGo0gBTcKq1AwPZ/R9S6HXsIf6V4U4r9Zc/I8R
         GiXg==
X-Gm-Message-State: APjAAAVfAhICm2ppo+xCA3WZhnVloQbhugNlzZVhyaj08e3fdr4Aej1d
        PMMrMIklji3E83vrZEVBQ4RqWks2rKz+aA==
X-Google-Smtp-Source: APXvYqy+jfJivtQbeeWtbVTLldAGg3gzzSeKvq8bOWI9t+rfsdlGTtenjHHhnvjF3xbFzgPAL7My2Q==
X-Received: by 2002:a6b:b593:: with SMTP id e141mr1456112iof.233.1568133770406;
        Tue, 10 Sep 2019 09:42:50 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm16849797iod.78.2019.09.10.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 09:42:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: add io_queue_async_work() helper
Date:   Tue, 10 Sep 2019 10:42:44 -0600
Message-Id: <20190910164245.14625-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910164245.14625-1-axboe@kernel.dk>
References: <20190910164245.14625-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper for queueing a request for async execution, in preparation
for optimizing it.

No functional change in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b2f88c2dc2fd..41840bf26d3b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -443,6 +443,12 @@ static void __io_commit_cqring(struct io_ring_ctx *ctx)
 	}
 }
 
+static inline void io_queue_async_work(struct io_ring_ctx *ctx,
+				       struct io_kiocb *req)
+{
+	queue_work(ctx->sqo_wq, &req->work);
+}
+
 static void io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -456,7 +462,7 @@ static void io_commit_cqring(struct io_ring_ctx *ctx)
 			continue;
 		}
 		req->flags |= REQ_F_IO_DRAINED;
-		queue_work(ctx->sqo_wq, &req->work);
+		io_queue_async_work(ctx, req);
 	}
 }
 
@@ -619,7 +625,7 @@ static void io_req_link_next(struct io_kiocb *req)
 
 		nxt->flags |= REQ_F_LINK_DONE;
 		INIT_WORK(&nxt->work, io_sq_wq_submit_work);
-		queue_work(req->ctx->sqo_wq, &nxt->work);
+		io_queue_async_work(req->ctx, nxt);
 	}
 }
 
@@ -1519,7 +1525,7 @@ static void io_poll_remove_one(struct io_kiocb *req)
 	WRITE_ONCE(poll->canceled, true);
 	if (!list_empty(&poll->wait.entry)) {
 		list_del_init(&poll->wait.entry);
-		queue_work(req->ctx->sqo_wq, &req->work);
+		io_queue_async_work(req->ctx, req);
 	}
 	spin_unlock(&poll->head->lock);
 
@@ -1633,7 +1639,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		io_cqring_ev_posted(ctx);
 		io_put_req(req);
 	} else {
-		queue_work(ctx->sqo_wq, &req->work);
+		io_queue_async_work(ctx, req);
 	}
 
 	return 1;
@@ -2073,7 +2079,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 				if (list)
 					atomic_inc(&list->cnt);
 				INIT_WORK(&req->work, io_sq_wq_submit_work);
-				queue_work(ctx->sqo_wq, &req->work);
+				io_queue_async_work(ctx, req);
 			}
 
 			/*
-- 
2.17.1

