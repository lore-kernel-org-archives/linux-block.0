Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0895CC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03202175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p47Kzs3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfA2T1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37198 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfA2T1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:25 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so6421941iti.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwNeU35VK3DgUu1WyTd3f3cYzyQ0l75ArO64qSgueU4=;
        b=p47Kzs3gzSA2XogJfGlXxIsnQtT2FwpEDeswLpm/YhJCgWoPmEqleYAHSr4QR1Npd2
         MjDmSd0tOowSJeleAvMLSgi9B3Fc4I5plavQQ010yJZr15JZX+N7en38u/vVyJl+bCIM
         BRFJpvH+wd+SP3hvd4PKM+X6sOHpXAWIiIyG1kU6ATsaM9n8VhEn7JSMubdwrvtdEDhN
         tq6hD35rJL413VkoWAkQ7UtyEgcC3E1kMXaIQIw3tU+qTJmaOGl5I6a+jnM++5ozZHsb
         /7TsQgKvqRvBTbjDtFGRsRrOVwyk0dF/rPsROHrUaNpujD4ZQbvuOU3kw6Urk1t/NMi6
         SEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwNeU35VK3DgUu1WyTd3f3cYzyQ0l75ArO64qSgueU4=;
        b=aD6s8kAhMYOmdn4h0776eFzED+Q5h5274AlBTa0wniJsxFuFJwXveq21cPnLmf5x5U
         ExRwyWt1m1H6xdg5ak7HrScS0Vii+7myZu0eu1pFq8gJ8eOvVcggxrj1URHe3mMI3+Uv
         zK27bUh58A+6deOvoaUrZC0gZpAJZ2PbW64AMuPMrq/8YTMyM+2N6uw1WA7SZMGvFmr6
         VpL2MoxPoeaOneQ/R2GCLjJMtCn4Y1I1cnOdss2/h1+V4LOenOIeH+8FoTvD9yFSVmoS
         zyk6u1gN1vrkoeLS61KXqi0axXFKIxF0tzj2OsWWjZsJV5d9lVZiX+uVgEnmPtaOeAZl
         Pybw==
X-Gm-Message-State: AHQUAuZXc7Oqgabdbtw3lN677vcC1fLol96AGCirhLy4LT3OdpJCbH/u
        j2CTuDlXNND+AOYgJrCkkcZ7hg==
X-Google-Smtp-Source: ALg8bN4A4H3F3coKC+YoBWRsCm5jNky0RLzUGsaLGFC0XS0H1okAg49Do6f1585ZBOZH4qBszm6Qqg==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr15912424itb.93.1548790044350;
        Tue, 29 Jan 2019 11:27:24 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/18] io_uring: batch io_kiocb allocation
Date:   Tue, 29 Jan 2019 12:26:54 -0700
Message-Id: <20190129192702.3605-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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
index a4c3c91abc76..eb7deca41cf7 100644
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
@@ -252,20 +259,40 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
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
@@ -888,7 +915,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	if (unlikely(s->sqe->flags))
 		return -EINVAL;
 
-	req = io_get_req(ctx);
+	req = io_get_req(ctx, state);
 	if (unlikely(!req))
 		return -EAGAIN;
 
@@ -912,6 +939,9 @@ static void io_submit_state_end(struct io_submit_state *state)
 {
 	blk_finish_plug(&state->plug);
 	io_file_put(state, NULL);
+	if (state->free_reqs)
+		kmem_cache_free_bulk(req_cachep, state->free_reqs,
+					&state->reqs[state->cur_req]);
 }
 
 /*
@@ -921,6 +951,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 				  struct io_ring_ctx *ctx, unsigned max_ios)
 {
 	blk_start_plug(&state->plug);
+	state->free_reqs = 0;
 	state->file = NULL;
 	state->ios_left = max_ios;
 }
-- 
2.17.1

