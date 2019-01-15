Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD3C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25D20656
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LJg8fvyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfAOC4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:56:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35035 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfAOC4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:56:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so593210pfi.2
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VoYrPtRXJ9nQQpUfIFiP2jxPJWS+L1ggj48G/VBnDmk=;
        b=LJg8fvyMx9ZXqRNN/UyOrzI0pPVIGoGv0PyE8ldZ3O4gDwqsPTiYAJdWNqsrv0owRo
         jN8w4t/LxaTfiijA1Q9MVmJUp3+SZfoJ6Ko8WN7G0NqmmfSlRKX/bi9BOn9UJ2VmpKcM
         gRlyoxaFmycrSsKPaupXvmQQ4IP4eAyXQxppTggkfeX1w9Ft8PQ26ZkbqcVNRya+qeQ9
         URmZJVZyeEUUAGCeOL3THCPvLoyuw6++/4v/PKun2x8W6GPj/a+mriv7fP5Vsxou1vhQ
         rzCAimXqIDqZUnczSfWwVNQU3HADo5UAHtzbnZqigdv1q7PqNig8TgEbNR3DuClKiXgc
         9Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VoYrPtRXJ9nQQpUfIFiP2jxPJWS+L1ggj48G/VBnDmk=;
        b=II7Lv2Q8TXoB2Y8i9BeQufMPar3Qz5mjFnroimDSlgV25KpTjcFL0CHAzeevW0iz+C
         uNVyi1bowYp4spVe44zre/m8M+aRfqxkEa1Oa2uhQAbeeRSfg91A5uglBDL7UKtuuYMa
         Mo+7ilxbg6adl16a+lu8ft77Q8bQZQsRFWm0niO9I8xUx+oGB6vNDMfKTdCShgFBeJ/G
         Sz86XGpJqBC0iLmoDJhfIyCDBXmwdTq2c5oxrYu2lkWUZoLcxDSapZD2FEo1HIfFyb9J
         R+s9eEOhZwgZKqDnNYjyiRiY5k/zMlmeyFgN8qe7Mcl7Nc3P4AbcYMRTYC9g8X8gPR5N
         D9SQ==
X-Gm-Message-State: AJcUukfwU9iD3cMASPBdCHTLBHMTAQtF4g/4lCwZxX+xvIjd6ePArMUz
        Ln4H6SBol9A0D/x+3MKZWQFvuQ==
X-Google-Smtp-Source: ALg8bN4TQmvTcn37kaEb7ABZtiuctisdY9ll5iS2uXAugW1QYZ2AnC5clRriS+99sJpufM0IGLwsHg==
X-Received: by 2002:a62:d206:: with SMTP id c6mr572884pfg.245.1547520959286;
        Mon, 14 Jan 2019 18:55:59 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] io_uring: batch io_kiocb allocation
Date:   Mon, 14 Jan 2019 19:55:26 -0700
Message-Id: <20190115025531.13985-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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
index 0d7c44a2d424..d0e4e37592fe 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -140,6 +140,13 @@ struct io_submit_state {
 	struct list_multi req_list;
 	unsigned int req_count;
 
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
@@ -244,29 +251,52 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
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
@@ -910,7 +940,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	struct io_kiocb *req;
 	ssize_t ret;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -947,6 +977,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list.list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -958,6 +991,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list.list);
 	state->req_count = 0;
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

