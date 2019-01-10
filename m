Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE2C43444
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160A21738
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YoeJSUYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfAJCoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37393 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAJCoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so4503368plr.4
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pIhU8eaLRf7z3l+B8J2n3fyMzAo9urqPpN7Nm7QZZV8=;
        b=YoeJSUYMkoHTdYD46jvivXBRx+ZRy6kirpF0c+sCukfhm+OyXMfjPQWHvaXngD/jQZ
         bPJD8dCk39AnBJZodShXRk7SXV04YwjyimD1/vV0aTQAZCqFsV7o9ICEVB9Mhf+uom+F
         ESqvu7FVNh3YcNDE3aiZCRRWOXQeRfo/onOqvVvEt3unBIqc7S5HGgNINUofxyuJcVOH
         tGsOwu4bKpP/zp1Ifkam18TG59swiZF23QyQg1HpFcENSvhLb0XgarCU6NszZ+zYycAx
         Xgp+HFEdDzVCbosu3FoDDqrbxmp5dRHtzm6583BHjvmIPhtaHAYam8XXFJBNspoF1k0k
         eHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pIhU8eaLRf7z3l+B8J2n3fyMzAo9urqPpN7Nm7QZZV8=;
        b=KHmOl715stzHpNc8t7IZNNaSMcaMdw0ODX/pC/zgNjkD9oxo82iljm1CmnyUL4LaT2
         /FPbpHk+/wJ7xk/xGtUaNd33SffKZtqts8+FU4U0TrwgpD2q65V1AXKzOXJXr8kkwIFo
         +yjeBjmYuyyBxPCfoVMH0Fc6vjjoD2rBQ74XPSrTMESuJzFGuzF4bq9Xo4+hIX8GS+ch
         KVvaYaLaB9OJU/FDQLhtYf1pZkBmdtNcBkX3NEHn2AMj0FF6//e5zbbINzCWWsZg3Ord
         nQbE4q8oMDErBPG6PQ9OiNUBd3D8deQxKOOxhQh3Ok/qis7ROuIGekB3ug63Vr0fQ3w3
         54lg==
X-Gm-Message-State: AJcUukdJK7n8z0kwy+JLaCGN26Afya9OQn+Yi+Nnn9GH1kegutleM1Vf
        +yVgrd0hS+9fIfwcclZ1dDUsBA==
X-Google-Smtp-Source: ALg8bN5Y/ZU0JQk4+nEbRBqJyXjMWKBNi8LzwpeimUqnMyVD/fuTvue8Q8znTZcOPX8P38tVb7oDfQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr8751782plp.34.1547088276902;
        Wed, 09 Jan 2019 18:44:36 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] io_uring: batch io_kiocb allocation
Date:   Wed,  9 Jan 2019 19:43:59 -0700
Message-Id: <20190110024404.25372-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 71 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cd2dfc153338..b5233786b5a8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -127,6 +127,13 @@ struct io_submit_state {
 	struct list_head req_list;
 	unsigned int req_count;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void *kiocbs[IO_IOPOLL_BATCH];
+	unsigned int free_kiocbs;
+	unsigned int cur_kiocb;
+
 	/*
 	 * File reference cache
 	 */
@@ -196,36 +203,58 @@ static struct io_uring_cqe *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->cqes[tail & ctx->cq_mask];
 }
 
-static struct io_kiocb *io_get_kiocb(struct io_ring_ctx *ctx)
+static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
+{
+	percpu_ref_put_many(&ctx->refs, refs);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+}
+
+static struct io_kiocb *io_get_kiocb(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
-	if (!req)
-		return NULL;
-
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	return req;
-}
+	if (!state)
+		req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	else if (!state->free_kiocbs) {
+		size_t sz;
+		int ret;
+
+		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->kiocbs));
+		ret = kmem_cache_alloc_bulk(kiocb_cachep, GFP_KERNEL, sz,
+						state->kiocbs);
+		if (ret <= 0)
+			goto out;
+		state->free_kiocbs = ret - 1;
+		state->cur_kiocb = 1;
+		req = state->kiocbs[0];
+	} else {
+		req = state->kiocbs[state->cur_kiocb];
+		state->free_kiocbs--;
+		state->cur_kiocb++;
+	}
 
-static void io_ring_drop_ctx_ref(struct io_ring_ctx *ctx, unsigned refs)
-{
-	percpu_ref_put_many(&ctx->refs, refs);
+	if (req) {
+		req->ki_ctx = ctx;
+		req->ki_flags = 0;
+		return req;
+	}
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+out:
+	io_ring_drop_ctx_refs(ctx, 1);
+	return NULL;
 }
 
 static void io_free_kiocb_many(struct io_ring_ctx *ctx, void **iocbs, int *nr)
 {
 	if (*nr) {
 		kmem_cache_free_bulk(kiocb_cachep, *nr, iocbs);
-		io_ring_drop_ctx_ref(ctx, *nr);
+		io_ring_drop_ctx_refs(ctx, *nr);
 		*nr = 0;
 	}
 }
@@ -233,7 +262,7 @@ static void io_free_kiocb_many(struct io_ring_ctx *ctx, void **iocbs, int *nr)
 static void io_free_kiocb(struct io_kiocb *iocb)
 {
 	kmem_cache_free(kiocb_cachep, iocb);
-	io_ring_drop_ctx_ref(iocb->ki_ctx, 1);
+	io_ring_drop_ctx_refs(iocb->ki_ctx, 1);
 }
 
 /*
@@ -761,7 +790,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(sqe->flags))
 		return -EINVAL;
 
-	req = io_get_kiocb(ctx);
+	req = io_get_kiocb(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -828,6 +857,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_kiocbs)
+		kmem_cache_free_bulk(kiocb_cachep, state->free_kiocbs,
+					&state->kiocbs[state->cur_kiocb]);
 }
 
 /*
@@ -839,6 +871,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list);
 	state->req_count = 0;
+	state->free_kiocbs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
@@ -1071,7 +1104,7 @@ SYSCALL_DEFINE4(io_uring_enter, unsigned int, fd, u32, to_submit,
 		ret = __io_uring_enter(ctx, to_submit, min_complete, flags);
 		mutex_unlock(&ctx->uring_lock);
 	}
-	io_ring_drop_ctx_ref(ctx, 1);
+	io_ring_drop_ctx_refs(ctx, 1);
 out_fput:
 	fdput(f);
 	return ret;
-- 
2.17.1

