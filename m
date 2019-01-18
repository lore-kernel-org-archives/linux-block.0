Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C67C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D2D20850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OgZ2nF9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfARQM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38425 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfARQM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so6550537plb.5
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eSRoBWEYatYiUOfFsoUKfPfK8ZgE8idbL4z9lJ2pW/A=;
        b=OgZ2nF9N5lOkJoaoGeKmSfl/dGF76lnXTz4BmTXwvmsIe3dDSJ8/rNqBDQ/F459ZWy
         57XuGDOPfF2wcAG0d8hSHd7hOSV97VqaXbVJWSxMjeF264amaFgvktYYm7G0xpCFQW1R
         4bWaIASito8lCr+Ty6QSg0xNNRXHV0rHNfq8o03yQhZbP+Oc/9jVRWYQuGxdekg4CJ9l
         +qzz1z7rtE4IW9J5eHDmi4edOvrcOvxxRj/OopvCv1tG/YCvJBV63TDWaDO/LUb15cws
         DBu0Ju+Dk8PAS/qkYC3wPFdPnBm9rTjDgATm1O5TKfXfkz+vvSl9EkzfwU/KnWrWhetT
         jITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eSRoBWEYatYiUOfFsoUKfPfK8ZgE8idbL4z9lJ2pW/A=;
        b=r1uPEcjW8ged5YjNtVyhlTWii5UpIxNJBmEdNdvXpvGPlOt8N9Ve+yUUirqyHeXTP2
         3J7Qr5kiSiZpXKPf/2Aq36/qCLP4OSJJJzAY0GinSGp+6qCg34SK0G2EvewoPVcPHwy7
         AhY9sbegwoDQb/4yxJ8Ubx3X3ZJKHXgAfD1737CIS/Ftfb/abRnOm76kwjWMELMnyRHV
         TC7akecLF5DyVQu3HB7euYULzdzVe5ZONO53/BSAD9eFkMu1dISs7R8NGay535VLQpQT
         46UZ72sWeimTAQZwvDEh01Tvtzrb0fMGvhJaH/CwFhQAS5SJWuSvsiuT6QotUGNO7dEG
         8dIg==
X-Gm-Message-State: AJcUukfbQCIx+FeklAQ7MxnWGQzjB5ek2FSKiU+rnCXsrbyBpiUt55hY
        8sb7d/VV+euOj23jTByxKM0iFA==
X-Google-Smtp-Source: ALg8bN6CmGOl4Nf2+on7FWN/sh41gbuhgkly7v4BPf35H+1oR9BSVHAzZTNnyN2n9Y0fegnzz83aWg==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr20123933pll.265.1547827976250;
        Fri, 18 Jan 2019 08:12:56 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/17] io_uring: batch io_kiocb allocation
Date:   Fri, 18 Jan 2019 09:12:18 -0700
Message-Id: <20190118161225.4545-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 668043c87ddb..666f4cee1a5b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -135,6 +135,13 @@ struct io_kiocb {
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
@@ -258,20 +265,42 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 		wake_up(&ctx->wait);
 }
 
-static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
+static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
+				   struct io_submit_state *state)
 {
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
 	struct io_kiocb *req;
 
 	/* safe to use the non tryget, as we're inside ring ref already */
 	percpu_ref_get(&ctx->refs);
 
-	req = kmem_cache_alloc(req_cachep, GFP_ATOMIC | __GFP_NOWARN);
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
+
 	if (req) {
 		req->ctx = ctx;
 		req->flags = 0;
 		return req;
 	}
 
+out:
 	io_ring_drop_ctx_refs(ctx, 1);
 	return NULL;
 }
@@ -881,7 +910,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -905,6 +934,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -914,6 +946,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

