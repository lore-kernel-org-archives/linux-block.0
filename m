Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D133CC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E62921738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J7qGXugk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfA1VgD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:36:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40440 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfA1VgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:36:03 -0500
Received: by mail-io1-f68.google.com with SMTP id k2so14794475iog.7
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HU3YUukjSp4JEwN57tU8/YdI0w30Ti9AeqKKUuT4uao=;
        b=J7qGXugkV8Oka3Gb8gobLWl75+HThQW6pYU5ovzop9L9G013YPAmMQP0Ca8Z+t0hci
         f/fK/B89TpfqWn8K8KPTr6HomO5qaA+tVt5cQ/gqDXshgNOix2jfJPC4DjkI7RNSfFz6
         ay+p+kx/inD7D1PlbOJ63Qf3sJYwFfrW9d5cviCGFI1At+rctp8waH2SUxMV3WpbC14c
         5h4Wp2s5Q6dPOtSBoX3xuHDJdTjk+GL8emsKj0WbXijUousBySa1YW9pp6g4ncKqkWrh
         PpWhsufwtc6sW5w8A5nI3BdGgtIpe6DKI7NXlsb+igFj5L5HwLfqRvWSrVxxPRDmiwMC
         nsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HU3YUukjSp4JEwN57tU8/YdI0w30Ti9AeqKKUuT4uao=;
        b=oUpv/lhe2vFyMRuo6UGTVjiWLNmTmBJO/VNE11YvwXkvJCWHxRViWNuYlcJarcSlxa
         KAfoFfKe8YPtlzbX2QVpIg++1/kGp9D0ofTswyl+yPCZfVzF6DcFeaNp7z6Nltibsty3
         Wjgl7yr9YwCCorzUhijC/9lZrURpiNpa0E/Wlney2CqEY85s0/nVYx7xjwrF6i3Nj/N6
         tEBXytqWKI/YLLV+famqK5k9zIEIqsq9si+mlYoR+L0mCeXYsH3ul9SMO+zaUWpgachu
         erTrY3Tc971ZRk7fp1KqP32xvELed9xfzGKAIKKoQIx1bMpnuOrAwGjs3z2KT9skH3lY
         Zqag==
X-Gm-Message-State: AHQUAuZLSAqx3kenVuYEYhUjnXvXIT6+Tqgfdb1RJ3Lr3rqE6Dc8Y7T1
        RaVvIkPmaiEgEFpuF0EBrX2F+t2gJAE=
X-Google-Smtp-Source: ALg8bN6dLVRwd7ODeW2elJE3+3j/7/iydtIu8fWlTaeo9Zgp6fhX7SpIjaOC4IePt6SmUl56BSTgoA==
X-Received: by 2002:a6b:8f08:: with SMTP id r8mr14304077iod.56.1548711362487;
        Mon, 28 Jan 2019 13:36:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:36:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Mon, 28 Jan 2019 14:35:30 -0700
Message-Id: <20190128213538.13486-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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
index 25bdd719690d..a33f1b1709d0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -134,6 +134,13 @@ struct io_kiocb {
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
@@ -257,20 +264,42 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -883,7 +912,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -907,6 +936,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -916,6 +948,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

