Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4069BC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DDE2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iRhG9Bxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DDE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeLAEHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38872 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeLAEHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:15 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so10227275ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0+NngYCEwZmyaHCfliqIZzKXf8tREdBkDh7BHlIPjoY=;
        b=iRhG9Bxi7d/+z3JHkw2TCh8ZTUuFNTxCilzedQ0/Vaq83CVsYJeAnHvZoBNXgyzI0h
         wHCttmqLsVKFfpGYWwBwr6MAkPdninwktf+B7SzuPaDPOlOC9vn/XJmK5mo1+V8p0gF3
         kY8UDLJH7cFyAEId8SFuo4TtAw6LIe4ueARgbHmTRJomZv9u4aOl9PIo3VcPx7pDb2oi
         w/R4FhNcCqOYhrECk9rbKwCyD/oXvP1zO1UGNEdVqtfvtjRLaJK2To7w8xJtOAW9XGKg
         fUGjo3vAUvXy5cLDR1yJ34+OCiW51BlTI0azLOBy2gFw1VHx3LUT9aQGjgSPQu2t6R/Y
         C/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+NngYCEwZmyaHCfliqIZzKXf8tREdBkDh7BHlIPjoY=;
        b=KhbId4cuJX0BENbH99hrquOSb+SxSPqP34WLlHrIwJqratbvLNFey9lgDtP3D1aHcI
         dnZGcqaFDw0K3lcoEpV43NFHYhl3maUd08pWG2l1hXyTelCLuW+uimr51YJbWvHF7XCj
         NKI2DGnZRHsQPuskZ+4MxyY8rMxpgbEQR4GhOuFDup+tUbRy1NeuyfyUS+eVlqqDfjZ1
         Xwf6G9sYHt1JYTtQGUhmYHgy6I33dkrsoqyCrR+Y2tNjzRWgAlccS+dqO3EPH+V/BLAR
         nxIeo0vc5ht7NP9PbVprJp8kq/g4DPRTuCGE0SUCOppREAbna1hb+APavj4n0AxuclFu
         sqpA==
X-Gm-Message-State: AA+aEWb8gOcNffiVCK6330jh+su/t5xVLuu6Kz37QLtxjkqtDB4tkZIA
        V0FDREvCgUvnNmGdfc+ktcCPmu4LZ0c=
X-Google-Smtp-Source: AFSGD/Ua1hyabcOerfXkHkPm/gFjbPS8SrzDWZlZ9S2gEdEmDKfvEyAf2K5HRUmf/oz0K/9YOJB41g==
X-Received: by 2002:a02:1a0a:: with SMTP id 10mr5649788jai.50.1543597038740;
        Fri, 30 Nov 2018 08:57:18 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/27] aio: add submission side request cache
Date:   Fri, 30 Nov 2018 09:56:37 -0700
Message-Id: <20181130165646.27341-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have to add each submitted polled request to the io_context
poll_submitted list, which means we have to grab the poll_lock. We
already use the block plug to batch submissions if we're doing a batch
of IO submissions, extend that to cover the poll requests internally as
well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 136 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 113 insertions(+), 23 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f7a49abc7694..182e2fc6ec82 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -230,6 +230,21 @@ struct aio_kiocb {
 	};
 };
 
+struct aio_submit_state {
+	struct kioctx *ctx;
+
+	struct blk_plug plug;
+#ifdef CONFIG_BLOCK
+	struct blk_plug_cb plug_cb;
+#endif
+
+	/*
+	 * Polled iocbs that have been submitted, but not added to the ctx yet
+	 */
+	struct list_head req_list;
+	unsigned int req_count;
+};
+
 /*------ sysctl variables----*/
 static DEFINE_SPINLOCK(aio_nr_lock);
 unsigned long aio_nr;		/* current system wide number of aio requests */
@@ -247,6 +262,15 @@ static const struct address_space_operations aio_ctx_aops;
 static const unsigned int iocb_page_shift =
 				ilog2(PAGE_SIZE / sizeof(struct iocb));
 
+/*
+ * We rely on block level unplugs to flush pending requests, if we schedule
+ */
+#ifdef CONFIG_BLOCK
+static const bool aio_use_state_req_list = true;
+#else
+static const bool aio_use_state_req_list = false;
+#endif
+
 static void aio_useriocb_free(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 
@@ -1851,13 +1875,28 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+/*
+ * Called either at the end of IO submission, or through a plug callback
+ * because we're going to schedule. Moves out local batch of requests to
+ * the ctx poll list, so they can be found for polling + reaping.
+ */
+static void aio_flush_state_reqs(struct kioctx *ctx,
+				 struct aio_submit_state *state)
+{
+	spin_lock(&ctx->poll_lock);
+	list_splice_tail_init(&state->req_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+	state->req_count = 0;
+}
+
 /*
  * After the iocb has been issued, it's safe to be found on the poll list.
  * Adding the kiocb to the list AFTER submission ensures that we don't
  * find it from a io_getevents() thread before the issuer is done accessing
  * the kiocb cookie.
  */
-static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
+static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
+				   struct aio_kiocb *kiocb)
 {
 	/*
 	 * For fast devices, IO may have already completed. If it has, add
@@ -1867,12 +1906,21 @@ static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
 	const int front_add = test_bit(IOCB_POLL_COMPLETED, &kiocb->ki_flags);
 	struct kioctx *ctx = kiocb->ki_ctx;
 
-	spin_lock(&ctx->poll_lock);
-	if (front_add)
-		list_add(&kiocb->ki_list, &ctx->poll_submitted);
-	else
-		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
-	spin_unlock(&ctx->poll_lock);
+	if (!state || !aio_use_state_req_list) {
+		spin_lock(&ctx->poll_lock);
+		if (front_add)
+			list_add(&kiocb->ki_list, &ctx->poll_submitted);
+		else
+			list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
+		spin_unlock(&ctx->poll_lock);
+	} else {
+		if (front_add)
+			list_add(&kiocb->ki_list, &state->req_list);
+		else
+			list_add_tail(&kiocb->ki_list, &state->req_list);
+		if (++state->req_count >= AIO_IOPOLL_BATCH)
+			aio_flush_state_reqs(ctx, state);
+	}
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
@@ -2168,7 +2216,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb,
+			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2272,7 +2321,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		aio_iopoll_iocb_issued(req);
+		aio_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -2286,7 +2335,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 }
 
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 bool compat)
+			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb, *iocbp;
 
@@ -2303,7 +2352,44 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		iocbp = &iocb;
 	}
 
-	return __io_submit_one(ctx, iocbp, user_iocb, compat);
+	return __io_submit_one(ctx, iocbp, user_iocb, state, compat);
+}
+
+#ifdef CONFIG_BLOCK
+static void aio_state_unplug(struct blk_plug_cb *cb, bool from_schedule)
+{
+	struct aio_submit_state *state;
+
+	state = container_of(cb, struct aio_submit_state, plug_cb);
+	if (!list_empty(&state->req_list))
+		aio_flush_state_reqs(state->ctx, state);
+}
+#endif
+
+/*
+ * Batched submission is done, ensure local IO is flushed out.
+ */
+static void aio_submit_state_end(struct aio_submit_state *state)
+{
+	blk_finish_plug(&state->plug);
+	if (!list_empty(&state->req_list))
+		aio_flush_state_reqs(state->ctx, state);
+}
+
+/*
+ * Start submission side cache.
+ */
+static void aio_submit_state_start(struct aio_submit_state *state,
+				   struct kioctx *ctx)
+{
+	state->ctx = ctx;
+	INIT_LIST_HEAD(&state->req_list);
+	state->req_count = 0;
+#ifdef CONFIG_BLOCK
+	state->plug_cb.callback = aio_state_unplug;
+	blk_start_plug(&state->plug);
+	list_add(&state->plug_cb.list, &state->plug.cb_list);
+#endif
 }
 
 /*
@@ -2327,10 +2413,10 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		struct iocb __user * __user *, iocbpp)
 {
+	struct aio_submit_state state, *statep = NULL;
 	struct kioctx *ctx;
 	long ret = 0;
 	int i = 0;
-	struct blk_plug plug;
 
 	if (unlikely(nr < 0))
 		return -EINVAL;
@@ -2344,8 +2430,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	if (nr > AIO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD) {
+		aio_submit_state_start(&state, ctx);
+		statep = &state;
+	}
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
@@ -2354,12 +2442,12 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 			break;
 		}
 
-		ret = io_submit_one(ctx, user_iocb, false);
+		ret = io_submit_one(ctx, user_iocb, statep, false);
 		if (ret)
 			break;
 	}
-	if (nr > AIO_PLUG_THRESHOLD)
-		blk_finish_plug(&plug);
+	if (statep)
+		aio_submit_state_end(statep);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
@@ -2369,10 +2457,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		       int, nr, compat_uptr_t __user *, iocbpp)
 {
+	struct aio_submit_state state, *statep = NULL;
 	struct kioctx *ctx;
 	long ret = 0;
 	int i = 0;
-	struct blk_plug plug;
 
 	if (unlikely(nr < 0))
 		return -EINVAL;
@@ -2386,8 +2474,10 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	if (nr > AIO_PLUG_THRESHOLD)
-		blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD) {
+		aio_submit_state_start(&state, ctx);
+		statep = &state;
+	}
 	for (i = 0; i < nr; i++) {
 		compat_uptr_t user_iocb;
 
@@ -2396,12 +2486,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 			break;
 		}
 
-		ret = io_submit_one(ctx, compat_ptr(user_iocb), true);
+		ret = io_submit_one(ctx, compat_ptr(user_iocb), statep, true);
 		if (ret)
 			break;
 	}
-	if (nr > AIO_PLUG_THRESHOLD)
-		blk_finish_plug(&plug);
+	if (statep)
+		aio_submit_state_end(statep);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
-- 
2.17.1

