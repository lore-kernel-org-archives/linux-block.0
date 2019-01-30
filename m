Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C4C282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C562920857
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x0dazv2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfA3XAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:00:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54956 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730796AbfA3XAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:00:33 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so971309ita.4
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+OVBgJ8suaXkGGFFS4x8Gx80JN3W1lcFolux49osow=;
        b=x0dazv2uQfdipCUHpin3LCQaTZ+kbApim/Co+f+Gd1x3CUsImP4Ntz5OUJ9jlwLHGa
         tN9CG8+JQT6XJxJoVZDq/xce8wKYoYbskTX6Z1r3qwDypJu38Ftm4kzzh/5voIFVtR0f
         Acye5LdU8W+x5WXI9G9qV9BVhikAp1ayd2697HrJ3HSSPAoFFmEgIt4TAfZkrX0ezQzR
         W5GNqXd4rSoicwJJA+Na6bCF0GR6OO+uU5+l4wWgNc1nnCvfoxbUzXV4h9Ye5EoPHUpY
         1ffsPiphYtiYUkGI9rd9Q/aj8spbIk2jk8BrIeXlRpSvBnII3DTfYMZK3OWDbjOH5MTd
         rrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+OVBgJ8suaXkGGFFS4x8Gx80JN3W1lcFolux49osow=;
        b=oSdbIk107P4O3Wa+Rx8cy/SA6IoxXSdjsiBNjtk3Exz93nYHXnxftgq/bzqsj5CFgs
         dbg6OE/2a4tnxpJ73E0TGQA3kmMRU8bpCfUJ/RfcDvhfLMOudXSQnxVXDXMDd8x7HswZ
         ZLqGHTvLaESVVeAMi3hMbGF1OdWrVfzAYCYA2Q/UfW+TY1WHCNkpTQ85xD7L0z/OoReL
         fLZZwP3orRyqWc7vajIaqHLfJ+gX/if2AdWUOl4o+yheQinA0dt8wf6Idbrew0DW/zf3
         L2fihxK+31Ii9hdnji4H++6uh+EGHa6WFLhOk++Zl0FJ9Jg8WTBHoojsEaflmUzjeVdH
         zlqw==
X-Gm-Message-State: AJcUukduy+K+fnupvb7zgegk84UESRgmlP27e20MGHm9SqXFVngLmumx
        nO5kwsxqedlVvi3Pm5bdvE5YSA==
X-Google-Smtp-Source: ALg8bN7P8+IvCbvQP51Tomfwl7uxanrAhPsoFOiWJPDNZxlGG/U2tc+BTPuNxq+ZonlE4k2+D19bSw==
X-Received: by 2002:a05:660c:4c5:: with SMTP id v5mr17927223itk.104.1548885362496;
        Wed, 30 Jan 2019 13:56:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:56:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Wed, 30 Jan 2019 14:55:32 -0700
Message-Id: <20190130215540.20871-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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
index 488c57a968af..3cd3d0720961 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -141,6 +141,13 @@ struct io_kiocb {
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
@@ -258,20 +265,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -910,7 +937,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -934,6 +961,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -943,6 +973,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

