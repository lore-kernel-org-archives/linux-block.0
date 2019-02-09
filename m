Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC260C282CC
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A775C2083B
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IVO/WOfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBIVOM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfBIVOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so2068402pfi.9
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JSVEJ2tIzhyOtRmTwa8QrgR+dpO88fkDdNIm04DsyHA=;
        b=IVO/WOfp/Ta+csTwwe8cDFJly3bbJ8iJXfNUUOV7ESUKtSKAuZN0QncSW0cnJwqt5g
         zJ6+Q9sR1SMzkRtjZhTaXRiCv2lGZdIcxYqNisNmoEGvc9+s+A+/kgnskKLX+Ii+kmrl
         FC3zAKDgaa2uyY+N0wNs8PzYhE9iLJYr9PNqfy/wzWTzkjFdBeZ9MhxL7eJGPVC7/U82
         x85jgZDV3QFL3/DGKkIDwXMUYVdrPcQN5t+cyFnSLtBU5XkLGK06/cIGB72QjixlYJm/
         65WTXjK4K9QnpsErOwqiY8jiODucotpTxYf4vSJLXenYzDUK0QRwDAOBFj6jFXN59vvz
         GtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSVEJ2tIzhyOtRmTwa8QrgR+dpO88fkDdNIm04DsyHA=;
        b=BpDK2GUEkqP55V+bPvutZC0XAF0XaLLpXXxiQwcNsLpvNazN8M96MOkq96p8DOzXdN
         n01YT+nUHMtZndc+gBm8v7Kdwujzff8dIpxF93olH0OI1TLsCtqIe1Ol3zV/vrV859vJ
         OT3exAIRF5MW4aAiqCZJrHSdIu7C1wVCwef+1JlYzJYaMWqA6L9FmGD0BQxoq+odzYPn
         JHLc3rP3w8r4vzr/KxlRoFAa2j5p+n26mE0ChXYpVcCe4cIg957V4YI06CgMNzpNsQPm
         1BDEhAFrcMT4YLw0SdU1c6hj56rXSRbJpPL0IYZMgSYCg50pmqeV3fbnzCXJ1wZJvYjZ
         6Shw==
X-Gm-Message-State: AHQUAub5zfM6kK55emyLJdIGP5UmvzuA2o3r/R1odNFZ+xBz238vQ9Vb
        shWJH6eiMdvywvtZbZvfzEz5og==
X-Google-Smtp-Source: AHgI3IYD6atbG3GnTyc7IlAxkgMbR841j/Lit+KJkb7PvBXGaqWEftA2UJn98u+U6Sb0InBoH6dqpA==
X-Received: by 2002:a62:8add:: with SMTP id o90mr29035625pfk.210.1549746851199;
        Sat, 09 Feb 2019 13:14:11 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/19] io_uring: batch io_kiocb allocation
Date:   Sat,  9 Feb 2019 14:13:37 -0700
Message-Id: <20190209211346.26060-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to how we use the state->ios_left to know how many references
to get to a file, we can use it to allocate the io_kiocb's we need in
bulk.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index faf329e81570..d9f7e90766c8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -148,6 +148,13 @@ struct io_kiocb {
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
@@ -281,20 +288,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -980,7 +1007,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -1006,6 +1033,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -1015,6 +1045,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

