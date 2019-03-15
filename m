Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ADCC4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858A218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PtuT3Z8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfCOOy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:54:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35537 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbfCOOy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:54:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id j5so6540763pfa.2
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMMrvenrcLVFXCMF4rg9hpdiO7zJtE9scP5M1jwx6b8=;
        b=PtuT3Z8TUppeq3xH3Z04/gx2P25PdU4MJoAaePhh+59uWj+9rO1/NAkiXk7aIuCQ71
         UGSez+3E2GAWwchKq2EKJE8c6sYhcdh6CHgtzGqdZr+R1D4+cKyHduvgQ+Seln9hVqX7
         QrbvvePmVNO9JOgzZSk3ZawHMXwyfCWJQysrOqUKGjhZONBuMSqaqDnB2jva52k3MTqN
         PRHoK66Y3AAm8tD6tL+odDrygb59wLY8ga3/zrUWkGNCtxM1dKGoP/VQ00sJ7ZT9pC2g
         QLjK+VJqab4pFVWHlx9TltT8Ru9T5mPicV5aMg9G//FLZx1GWR3t+G/jDzY5vGkegGuA
         vGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMMrvenrcLVFXCMF4rg9hpdiO7zJtE9scP5M1jwx6b8=;
        b=tJAIW67dvyxZcs5i5jtqw8LJy6gSB3o9ppFQQZynAbYI3LRTBvU6roNKlvYfqddMPu
         5T5+w62LZTkTSZHCAs0A4HYyxfbmO+HxTzZ0FMGpDmf4ttb7+udyhSjIAgg1uaL9GgBq
         6a0Z64hgJqRM5Gt0Jk34A0s1s0dPpmRiOmcRjEKYcVK/a9UOFBfM6lrFlmR5UvXFYyTm
         AbmOGIgaPjNMGpfwrNKQsrhJpmBEmxzBDenFEHpi+VNwcyvQwjOxIZvVBCNh6JHzgJ9H
         0urtyp09D420c+xh6vyCw090dTXYAFYs0Mq1YRMsOfbReqGpYzXN8bMtBEFcTjUzaZc5
         3JFw==
X-Gm-Message-State: APjAAAX7qhzbFA4A+hMjCMoR6lQz8WPLfFVsyeuz15vJGGtv4Po4pj//
        BORj+tm7HkXolspCOPuvUM4zrA==
X-Google-Smtp-Source: APXvYqz8WINpv+zU3JcKw7p9D3/Ms0Z5L073GBmQWAfySgTVQAH3Fc3bhnWRbsLvdE3bD6gxyrL//w==
X-Received: by 2002:a63:ee55:: with SMTP id n21mr3795224pgk.211.1552661698404;
        Fri, 15 Mar 2019 07:54:58 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] io_uring: retry bulk slab allocs as single allocs
Date:   Fri, 15 Mar 2019 08:54:41 -0600
Message-Id: <20190315145442.21127-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145442.21127-1-axboe@kernel.dk>
References: <20190315145442.21127-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've seen cases where bulk alloc fails, since the bulk alloc API
is all-or-nothing - either we get the number we ask for, or it
returns 0 as number of entries.

If we fail a batch bulk alloc, retry a "normal" kmem_cache_alloc()
and just use that instead of failing with -EAGAIN.

While in there, ensure we use GFP_KERNEL. That was an oversight in
the original code, when we switched away from GFP_ATOMIC.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 443ca5615554..5be6e4f99a9e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -399,13 +399,14 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
+	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
 	if (!state) {
-		req = kmem_cache_alloc(req_cachep, __GFP_NOWARN);
+		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto out;
 	} else if (!state->free_reqs) {
@@ -413,13 +414,22 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		int ret;
 
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
-		ret = kmem_cache_alloc_bulk(req_cachep, __GFP_NOWARN, sz,
-						state->reqs);
-		if (unlikely(ret <= 0))
-			goto out;
+		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
+
+		/*
+		 * Bulk alloc is all-or-nothing. If we fail to get a batch,
+		 * retry single alloc to be on the safe side.
+		 */
+		if (ret <= 0) {
+			req = kmem_cache_alloc(req_cachep, gfp);
+			if (unlikely(!req))
+				goto out;
+			ret = 1;
+		} else {
+			req = state->reqs[0];
+		}
 		state->free_reqs = ret - 1;
 		state->cur_req = 1;
-		req = state->reqs[0];
 	} else {
 		req = state->reqs[state->cur_req];
 		state->free_reqs--;
-- 
2.17.1

