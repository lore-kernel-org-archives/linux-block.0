Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904BC43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E202086C
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IpRkiSRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfALVam (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfALVal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so8565475pfi.5
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7UBRv/xk8WPda5LpOZd/9AGkNsfnfzZylGeuJHJ/2Lw=;
        b=IpRkiSRAYfJaFeo+BgCuen33D9kCf6oLALTk5F5Jgho98iD6FxqH8chICxe9IBzixS
         bcXcxmhfh8DSqpYo6EE/WVK2CRPdf9Tde5tWtenTKD2rq+cVjY80yCJSM+nanvftOtYL
         pZ1MyrNV0SCHKwffCVsLOOFharBAL+1jSy6p9Rg08nbzP2AiYcvqins1qGu3Bzp+Kt+u
         5IJMvEMd6PwmkKvKBmt+0K8t2gEklyGj+XrcpkF3/52J9vgumHvxlVS1I8594A20PFg+
         TDR+WXZ7SeYGy5VqbNofcA17rSqRSBPLtZG3dB65uCnPWv40INPa8kzDIITU/x9yEluo
         pUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7UBRv/xk8WPda5LpOZd/9AGkNsfnfzZylGeuJHJ/2Lw=;
        b=oqLiIKT+rdUHRp9MIQMq31JpFieZscnyS08DVZPiW/MrwFN9luARhIIQkCCTn68c/Z
         Jg7guVgzXggqfRQ4AMH8KGGtOPnuCzhFsRCMyh+G0zLFqpfbath0+5DcFJY8RD26CAMD
         NwF7n2rZOaffh7V8gjhLxNLVoJdf/9DeMak+csSjhZi3/9RE+39yuo9M9nBAgJDLtdVC
         bqnBWibBk7gd2B5GF5AzSXF2to6wqlb6IbjVFkE0dgk6GW2ez7Px6WWhjbEBXGsSe+jO
         YhAffWtFl0D/UKXTBi78Xm9tm4Z8TeW68SpT0WfVbrdKfe+8Aehb+vOpbv/mDTnNivfa
         45IQ==
X-Gm-Message-State: AJcUukclh29lhsJ1271sOfeTJDuJdVN1eB6gq7CDkL4ypNrWl4mhfCnb
        aEcWS1cvn1BYC9S0SJoEyUw82w==
X-Google-Smtp-Source: ALg8bN6PvdT1Dm0KL20etIiyRs9ndmJdUvZaRnA+76AmB0sx3/kQMeIexVKa6ursW3YNJ1bDhIbGAg==
X-Received: by 2002:a62:6ac8:: with SMTP id f191mr19520989pfc.13.1547328640267;
        Sat, 12 Jan 2019 13:30:40 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/16] io_uring: batch io_kiocb allocation
Date:   Sat, 12 Jan 2019 14:30:06 -0700
Message-Id: <20190112213011.1439-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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
index 443988474b83..3867a93d485f 100644
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
@@ -209,29 +216,52 @@ static struct io_uring_cqe *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->cqes[tail & ctx->cq_mask];
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
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
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
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -915,7 +945,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	struct io_kiocb *req;
 	ssize_t ret;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -952,6 +982,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 	if (!list_empty(&state->req_list.list))
 		io_flush_state_reqs(state->ctx, state);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -963,6 +996,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 	state->ctx = ctx;
 	INIT_LIST_HEAD(&state->req_list.list);
 	state->req_count = 0;
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 #ifdef CONFIG_BLOCK
-- 
2.17.1

