Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09328C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE92218AC
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XuQuD/WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfBHRez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35764 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfBHRez (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:55 -0500
Received: by mail-it1-f195.google.com with SMTP id r6so10903041itk.0
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7BkZNOifqhgGEIp41oofCitN79E/ADlyvZO4sWrK9f8=;
        b=XuQuD/WNeUGN6uwQPuqYpUuOgROI6/4EV3NKdeAwuXC8DVtRs4hJhSvx86jtJ0TFjE
         albgPfe3BmJgm0blMXM6cPWhE110RVNv6BQ8KM7ir85A2hcH0ARxi09hCU4B/7sY3MY3
         q08Dvl6vTGtBlNeEulORGtQX31xjL9oBe9MflTUpRlwZ+3KsmsSjMShuxZSow1udgii0
         /BOlzsXRIpSY5nGuOSjV0U1u5xnBmPj8iEXuj7jKUQisoCTx2oi1s0V+XXH/Bbdgd78B
         Dz6Wvnm1RnVzfqCRHgzJh/gMTRNvF9fJUM/U8sBk8ZCf8NsSPrQyWbPA4xhNcdM5Box9
         Plcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7BkZNOifqhgGEIp41oofCitN79E/ADlyvZO4sWrK9f8=;
        b=jgFjot9VVkKs+a8qoMkoFtkLyrl2H8HWY4cLmNpQQU0VxWojfK65fY5KIW/NQwbkEg
         3un6wHM7h0fyZwqKoL64a4mU+F8G3LkrqnjtIN+WXuzXCEpqoNge+2FM19YpQY/LB1yK
         OCmyBHRRErLhYuECpiZg49+v4YR9Mw3HrKW/yx8wHYOe3Rl2s4y4jRiN/1It/3ggSNxw
         ySkZeecG4TkgMLzTAJKOV1thzhtBOKmMGHbwGvZOBiOwt6X8bMSxW0BLnKUOXyPQkc4Z
         S0zG3oQ0RS3Q6NGRnhhDY7AVUGZo9G8BgP7MXp7WP0Yrw7eavonCRi/jRNuDjM1h3qK/
         xfYQ==
X-Gm-Message-State: AHQUAub/jidGNkHQTPkfceSa6voo/UYoruibKBTpe2NY5gLPhvnEfdtC
        4xiqdq62z8ItyPayft92L2AfMA==
X-Google-Smtp-Source: AHgI3IbBW3QGsRNReBYCbyq9tOLDBwqvaOCyzuhzWNYVfs808+w7nSXps2olSS3Nh4CaalUv9sGKwg==
X-Received: by 2002:a6b:b408:: with SMTP id d8mr10622190iof.138.1549647293956;
        Fri, 08 Feb 2019 09:34:53 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/19] io_uring: batch io_kiocb allocation
Date:   Fri,  8 Feb 2019 10:34:14 -0700
Message-Id: <20190208173423.27014-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
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
index b7b8e9dd0c7a..a1e764515f2b 100644
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
@@ -277,20 +284,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -951,7 +978,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -977,6 +1004,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -986,6 +1016,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

