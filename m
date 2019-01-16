Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C192C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB70206C2
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uMBoNS3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfAPRuc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:32 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38419 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbfAPRub (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:31 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so3904708ith.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwnwtLBTx3XJ/6zuan1qyzOLtztjb1YcffgBxyiHJY8=;
        b=uMBoNS3nkcZz9BGAMWkvSCzGulc6hpwhRFn8+657CfUryrDnmUF8fC5LHotxGkkFuF
         Dw2kTG/zckSMPN2O7X90TcZ9hvYYcN+nKKA9XtmOHcmXmTUv1oXTN58cUaMVomfnp/Cv
         Ai16DiRKC6YZRg8dovqPB0VNUf0BFp4C7fD4UUPSfNxiIzONvJh3u4TEprIsDbVE2Zqn
         B7+eUIvPqcZwPPKPH/bvjOBgoJ+ZNzZyVlixLBu4+TSJLUE7D+UBUveHT4GHUvVzVcMD
         PsqRcjKrZhkAY7LnPi71sVutwp/y8CLD6aNovbiG9RHz02jNx0cGQCFk2mEQYkNDKb62
         LiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwnwtLBTx3XJ/6zuan1qyzOLtztjb1YcffgBxyiHJY8=;
        b=NwQlLuW09W+Dp6XsLU5ztMWbPA0TC27+sHjdNrQW7JWDUb/3c4OrO6yrTtDzd65VxV
         Zr2ZYyZZpgCywTvTFS53ka71VeKcuVlgVcLyFkmiJ2VhavfLCoKiAPJpEeFz8TKs/Hv3
         ZZmcpk8aq33K5xXx09sY879seXZeJ3z0Y8Lv7gK2RVfRkHstT0iyntajo/TvI6Cx0rbg
         XGY3B+MP+Uzdl2I0RoamJA8HyR1gE/Cxhmj3YVLfN/XDMeUJd5dK2GGSvflPhk9cx3UW
         xl4pIT85+3xZlykDTTiwuSS5VfdKyx33EngzmgXHNeX9MWSUZlcf/uDAbLs1KC+IljSB
         en2Q==
X-Gm-Message-State: AJcUukc8qFxf1Anj+F29piXZC87mtmxRrdgdlBd2S4GXY9JLsn9XgTww
        rEairIfr5fC0dxHje1uJi2UNHw==
X-Google-Smtp-Source: ALg8bN6SZPfTNZREpYVvmeFwzJ36AookUGrOgFOdyGIxFF0kZ8S55iTRfY/+sSkkryZR3fSyfvPwBQ==
X-Received: by 2002:a05:660c:a45:: with SMTP id j5mr6194306itl.83.1547661030503;
        Wed, 16 Jan 2019 09:50:30 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] io_uring: batch io_kiocb allocation
Date:   Wed, 16 Jan 2019 10:49:58 -0700
Message-Id: <20190116175003.17880-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 66 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c0b61a25aaf6..b6e88a8f9d72 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -127,6 +127,13 @@ struct io_kiocb {
 struct io_submit_state {
 	struct blk_plug plug;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void *reqs[IO_IOPOLL_BATCH];
+	unsigned int free_reqs;
+	unsigned int cur_req;
+
 	/*
 	 * File reference cache
 	 */
@@ -242,29 +249,52 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		wake_up(&ctx->wait);
 }
 
-static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 {
+	percpu_ref_put_many(&ctx->refs, refs);
+
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+}
+
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	req = kmem_cache_alloc(req_cachep, GFP_ATOMIC | __GFP_NOWARN);
-	if (!req)
-		return NULL;
-
-	req->ctx = ctx;
-	INIT_LIST_HEAD(&req->list);
-	req->flags = 0;
-	return req;
-}
+	if (!state)
+		req = kmem_cache_alloc(req_cachep, gfp);
+	else if (!state->free_reqs) {
+		size_t sz;
+		int ret;
+
+		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
+		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz,
+						state->reqs);
+		if (ret <= 0)
+			goto out;
+		state->free_reqs = ret - 1;
+		state->cur_req = 1;
+		req = state->reqs[0];
+	} else {
+		req = state->reqs[state->cur_req];
+		state->free_reqs--;
+		state->cur_req++;
+	}
 
-static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
-{
-	percpu_ref_put_many(&ctx->refs, refs);
+	if (req) {
+		req->ctx = ctx;
+		req->flags = 0;
+		return req;
+	}
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+out:
+	io_ring_drop_ctx_refs(ctx, 1);
+	return NULL;
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -871,7 +901,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	struct io_kiocb *req;
 	ssize_t ret;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -895,6 +925,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -904,6 +937,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

