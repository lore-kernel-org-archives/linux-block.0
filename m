Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5EC282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1100E21B25
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HYMj2KKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbfBKTBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50649 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733279AbfBKTBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:14 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so939963iti.0
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PY8RWKukBN2u0p+dEsi32MAnSMEKxmoGYnYSupUWRtU=;
        b=HYMj2KKgaFKgYAhrQ78X0Myg6BqE4un54XjULR41q8JOd5ZGKUj9i8VtizQ6sVL/CC
         XI85nZxDaekeerkPLonaxt77dem+ysu90bzf17iNHZB3zFD0n7CBmqcWyEnxEW5ZLYQD
         OgUWEe18xy5lTlz4703v+sxyPRtW07GQxZLemC2DMXC/ohjko9Zh51QkSJ/95nN+ywcq
         8OXOTFb/N+5cwfthrFoJhRjTs0Jint5WCuLgXDOEBCDyKvZZXos3136iTPjcvYWEcqFd
         EGnI7nYZjtp+B1bH+4xtb7z4cdMSeJK/2rMqwphMLOlSgVm7O6A3HmsBlr5+ghoGwtXW
         YN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PY8RWKukBN2u0p+dEsi32MAnSMEKxmoGYnYSupUWRtU=;
        b=cugzi4GTV7S+OjU6YcKV71J0WhzOmucia0AMLde5gir2rirP8hwylIYNRcxulh1tRE
         eFeU9hGzWHFNVmDKvjDdzttfCAt2aOSFwqHRidlH6OO/iLV8Z90ZCXhTW9gDLNZ9G/L0
         emh2WBrtRyKfqAXpUspNzCKp+/Fs12Gw4gH1ns/7JDodTev2mNlJUme+RPR7U53K2qvo
         k4tZh45kP8jWW6g9Z3YeQvqczOoLa5pSwxTmKsHPJKabbgVQYiOIROZFotfXTdAhCRwm
         gJq1fYJltNDdZ1xx53ySxhY4Un9T98RBKwWiuTGIK+NN/IWiOLaRFDvrq6JGggycw8sT
         kHsA==
X-Gm-Message-State: AHQUAuYHr7htLfM+HJuf6TB7CaXnRgB1bZCcsj/wEqseP/7w1IcIlADe
        PM4AfTXJBuBD0ph7hmRzPZfbJQ==
X-Google-Smtp-Source: AHgI3IZib91eTczZrLFDS30wS419XHDkSTtBV/qHVU3XkERVV3S65whWZdCpTpQh+M3DnZU3gqQ4+Q==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr7375215iof.175.1549911673178;
        Mon, 11 Feb 2019 11:01:13 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/19] io_uring: batch io_kiocb allocation
Date:   Mon, 11 Feb 2019 12:00:40 -0700
Message-Id: <20190211190049.7888-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
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
index 7358dd1dbf3f..e330252dc5de 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -168,6 +168,13 @@ struct io_kiocb {
 struct io_submit_state {
 	struct blk_plug		plug;
 
+	/*
+	 * io_kiocb alloc cache
+	 */
+	void			*reqs[IO_IOPOLL_BATCH];
+	unsigned		int free_reqs;
+	unsigned		int cur_req;
+
 	/*
 	 * File reference cache
 	 */
@@ -305,20 +312,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -1007,7 +1034,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -1041,6 +1068,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -1050,6 +1080,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

