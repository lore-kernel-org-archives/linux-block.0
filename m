Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D7EC282C2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D7921855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GcM1yFjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfAWPgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40246 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAWPgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so1229018pgp.7
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/29xv9MKNrYw8oRTTdcHsr+TPxTDF2QTlrPdVsY7oaY=;
        b=GcM1yFjG/FIdj83AekHOjpXQQgLd1V1ZwRhaLZCm7CwxIpHCsIMikY8yBCypQekvbd
         nv1AN8MZ65KXfI+zDU+U8YfNowwAtrOze1Q9C+eTHuIlogIGULk1NJb9OJ4fD4xR8V3Q
         cPjRW9sGr1FsOVglwsNfRFYLlcyLqNu3BRgs11anTHQPqoXvWCHffp2UoVWJ1mv+Ge+N
         f09EO+hMu0r4QAqKlYfOrOyih4/OLceTQQuly3ggLti69NOBv0kJwnFL0Y5+9n3t2IUQ
         TOAte96arcV9J7RCPlHqQz8P6umhIP6CbHeHlEm4SZwQbu33IJySvvazeOra42Ez6Zc5
         Q88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/29xv9MKNrYw8oRTTdcHsr+TPxTDF2QTlrPdVsY7oaY=;
        b=sS2ZGSts5RgGIkE4xthGRPLYy5z+Wu17rPjBVzpMG5dxkznPb6w6dV/saO7ISPIkz/
         X+q0aRlN/VTr2LJ9fUa6baQOEuWQfW0mxfbeJjZzsAudiHH9FaYdWxH9DD/8uSSFbDKu
         Oc7WMQzYJdwrM/CFbV0IxrHYi1ySnDhYKUfvWcvI1AMqZABtJHp3vw6eoDwy/SIbnjnN
         kxwImjiN2Mw7Ue0DvW9qD/3heG0zvLvo/EWYvQvWiBrhoNNDigir4I2eRCntWKyrd9/t
         qTW7p2yV1jstXshqmyY78T/Bhr0U+B415MParoiio1yv69o7L1bV7AGXMt0E1mxr/SAb
         wuTA==
X-Gm-Message-State: AJcUukeuX2CeSyzoIKNK2SKC67Vakx6cr/iw4JQqwSC37eEHYJ7qnoUa
        aw7Hdo/+tBSJ0D7/NSncaTzsog==
X-Google-Smtp-Source: ALg8bN5+ndNZ7qxZPvM446Y6TkGpiNOsAJkrNh7dEbS7BBBkPWxlyBOULJcdkWI044JI4muYGrNlug==
X-Received: by 2002:a63:4819:: with SMTP id v25mr2342701pga.308.1548257769273;
        Wed, 23 Jan 2019 07:36:09 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:36:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Wed, 23 Jan 2019 08:35:25 -0700
Message-Id: <20190123153536.7081-15-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
index e9c237d471ae..497bea0f29c5 100644
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

