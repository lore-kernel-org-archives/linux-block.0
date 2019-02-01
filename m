Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA068C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A4F21872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qpufCAkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfBAPYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33235 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfBAPYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:38 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so6010661ioi.0
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+XDVCcUhimEfDIfj9vTsNNrT4pn+cfxtkOxCae8bdbA=;
        b=qpufCAkrNGOfNdi1g2D4605HwxeK/JZHEeTVh8qU0FvI0oqi8a4Upemo/vfR4f5ywR
         L9z2CSR8kUdP5n2GNDPWy3hefTUTdLKmJKO1UJ8ubN90Etq6GC73XiCxs4o2fNCFmAyp
         0tXF5sp4LTi60QKOBPOZ7EfmcR/9FAWY1CbhKdLJCb8G8E3c84Rm2/54uRe+RCa2Msxi
         VhYY5VN215WNHsZMQjyYcditaWKTLGAtxfZdE0rDgR/u5qpx0wRnpBWL2aq1WRYsDi1d
         7H2YDp6O8N5PXZFZKuGDj1cyn74dWs2hmH+G7mmzEG8HfnmXWxjg6lsR/UoMnxohXnt1
         W4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+XDVCcUhimEfDIfj9vTsNNrT4pn+cfxtkOxCae8bdbA=;
        b=QFKQXZR9kSrIgDO27e131BPBMUwniBeOh2Xg69GL6isaaJ37l7hQmxZaxWdGHQodat
         rhtY8fzegA9JVF9beDiB7OEzutGlgZdRq3TJYRTOQGy1SaE/n/xoCc7TJ69oYlEYXTod
         t2aIfGqwHzGL1SKDTyyRJkWUApoWMYwspW85PPrh4p/QZAIsFIWuJ5SS87ma79w3toQx
         SgRemn3PipqpYPWIjgyiF5X0aDjq34/KlpYNRmDWYFM7irwMVKKaoZgMseoynph66rj9
         kug/DR381WZbI6wifegSV3NEpNlVesmueGKAtZA1hL28CbcC3kTaNBRRude/f3YpIhn6
         7FfQ==
X-Gm-Message-State: AHQUAub6TKBkQndyKOduQqo4HJ4Rx7c3zzT2uDIVMc3B/Kimva+ghecC
        RSuZtEPuVlWT+dPg29JL7o5EuX1Pa78=
X-Google-Smtp-Source: AHgI3IaOFHvWgm37Q0drnWzsAvuAXGFT1/ULINxHkMGfLfCRQHeCU+rYoqpfty7aiDCMYjQNtzPdpA==
X-Received: by 2002:a6b:7402:: with SMTP id s2mr8034328iog.219.1549034677637;
        Fri, 01 Feb 2019 07:24:37 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Fri,  1 Feb 2019 08:24:06 -0700
Message-Id: <20190201152414.23296-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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
index 400ea8ffbc10..c30b416fc5ea 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -142,6 +142,13 @@ struct io_kiocb {
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
@@ -259,20 +266,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -919,7 +946,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -943,6 +970,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -952,6 +982,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

