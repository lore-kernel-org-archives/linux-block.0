Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2AEC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276FE21908
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RwpS11dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfBGT4S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52560 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfBGT4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:18 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so2963052itf.2
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mr9uhblvrQ5aKZU3A/I21BrR3XZRNiX/ZkYG9diopjM=;
        b=RwpS11dMjZKEETRzG3FSzXkk/Kahd9OAAgnqzCwTmmgbgltJc+1UoJ0Z2aG4wfw3lP
         y52vY+En/1cGVL9Yifuz0AyEbaa6MWEWRdgx7YW9nQv3hm5sagzMxyoTzz6bcXTT+Uw8
         ouK2uflN0H1kpn3HddjeSLGSoiE3RfNdKcfB+fER7Cze1qdR+1/LwituuezDnE4c9XNt
         KxxN6PcZ5a2z5C+AyWgiSaqVO4dr+u7ZpYD6II5PRFmElxhJi+RaxhbiQ1lh1Gr8XVu+
         yKorFpmDnNBgiCo9CetCCu3wy4BVO5Rp8Un3PAaw+Vr+vSVuqfaEWlTG2tBICzUyRxgN
         UbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mr9uhblvrQ5aKZU3A/I21BrR3XZRNiX/ZkYG9diopjM=;
        b=X/ZmwjFE/ILiQyVeOGUftGXXrn+Hpi+wZ/QVhmSPs+pmdEAoVO5jq/bEbQsT9RJO7q
         2Pa6AJ23tBin7qnYa3NeCtODVI7yWA8nFPx6QY9eZUbn79gcl2n4JlBeBtQSatFZNWwF
         iqb2mIL2yWlnPKHEXYbOugNkcp9t9W+zjVt6StGM+XYDcKxO6iX+iHHRlKkqRmZTteHx
         Q0twKPYSGPX0GupowDgUR3NJi+TmUFU2HHSRIX6tGhlAQaXSqMJxzmFpYaSQt9ADOFt1
         fmIjraW8DylK0xb0BFrtFs4899F5YPf5fAbI4fpYcndeziiRBdCFur1YtRjHeOoWpWvn
         LXOQ==
X-Gm-Message-State: AHQUAuahDkAWr6CHwI1gbVIf4XH34TRu/ZCcfx0Uy8qtBb4kEJbebvno
        41xN7Ctf1gQjMSB9jzXenCq8aw==
X-Google-Smtp-Source: AHgI3IYH+hrkzdMIp1stNUaUbesWzNQ0Tx91UgjdDmMwXisp8GRbJ33T7vVxqtqcy1l1SnR8KlZPgg==
X-Received: by 2002:a6b:da10:: with SMTP id x16mr9311544iob.101.1549569377085;
        Thu, 07 Feb 2019 11:56:17 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Thu,  7 Feb 2019 12:55:44 -0700
Message-Id: <20190207195552.22770-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e23e639a4ff0..1369cb95e1b5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -147,6 +147,13 @@ struct io_kiocb {
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
@@ -276,20 +283,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 		wake_up(&ctx->wait);
 }
 
-static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	req = kmem_cache_alloc(req_cachep, __GFP_NOWARN);
-	if (req) {
-		req->ctx = ctx;
-		req->flags = 0;
-		return req;
+	if (!state) {
+		req = kmem_cache_alloc(req_cachep, __GFP_NOWARN);
+		if (unlikely(!req))
+			goto out;
+	} else if (!state->free_reqs) {
+		size_t sz;
+		int ret;
+
+		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
+		ret = kmem_cache_alloc_bulk(req_cachep, __GFP_NOWARN, sz,
+						state->reqs);
+		if (unlikely(ret <= 0))
+			goto out;
+		state->free_reqs = ret - 1;
+		state->cur_req = 1;
+		req = state->reqs[0];
+	} else {
+		req = state->reqs[state->cur_req];
+		state->free_reqs--;
+		state->cur_req++;
 	}
 
+	req->ctx = ctx;
+	req->flags = 0;
+	return req;
+out:
 	io_ring_drop_ctx_refs(ctx, 1);
 	return NULL;
 }
@@ -950,7 +977,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -976,6 +1003,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -985,6 +1015,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

