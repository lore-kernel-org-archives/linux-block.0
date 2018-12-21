Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669CDC43444
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A72192C
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lo/Po2u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391670AbeLUTW7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46495 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391664AbeLUTW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:57 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so4461979ios.13
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXpwguwLtnPUq+6+PIgSPGxoBI182prBZulAu0l53Tc=;
        b=lo/Po2u+AHqWA5LcJQvX/GaBtcxtWQMWaU3hhYsYu8Uv8mPEfy7YlRwftQRitYg+jI
         NgR1hrA0DAYjDyae7jAcZ6UDFiy6WMwdhYcrVIo++YpYMo7FLTVnd22QsRfDH+B3edLn
         ptY3N+SO3I6oJuroOgzDS12LbVcj/xC9NJS5mzqM8N7J+keZOIRW5Rx4Qbx+tlyL8kM1
         XAlcLd9NYJcfmg/hoD4WPUjZJGU/Tf+g7G2/JHt/ZZw6zOk6mbFjCTyfLM/9wf089K1R
         PbfG5CRP+j3WxpUTjlZacGZPwekEsTfLvNYfzaV5UpVYGAJRYRBeVwuDqeYJJye5Vr4X
         xJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXpwguwLtnPUq+6+PIgSPGxoBI182prBZulAu0l53Tc=;
        b=ZN5q/XtsGt/NzNLM94HVMQ9u1oGOJgtXSAumOj96uGig6z9pHVJd7CiWWBTBWaVndU
         Tf8g1CG5mZKO7e3lUdj5awHi07ptobC/qfYJA0fLzg+OTP6tgBhy4g+fUH2xANOmp/r5
         +XnwoqfbpnkwksehzJGYWD9QKnMwwyvbh6M1UZve0xWV1YUW9TCpABXWyWF2fzH7Jkp4
         UOHfjWo8k6GdfjItJjmxy5k/eM9duJ7AWcwj6PhFzMde/E4TKJwrmydylCsx0oZxkMcy
         gzra/vhCgCMFT92tfF7L9vKhKtpIY7ETyuDztcJo/wmspY0q+SC16i+iIT/xTsuYIwIm
         Ss4w==
X-Gm-Message-State: AJcUuketGpAsgIyJbtE0xERARvNp3VakZY9p+uRfgIq8N4O2tjXhPtk+
        UfMaCzZebg4KCN9aKRyy0wOveA==
X-Google-Smtp-Source: ALg8bN7dQPQaIxl1Bd3tOAZ6ToEf0eeHGu2lTKt8POOGbVxOE4/U+3En0UiRYB0/69ayB0ACdvJAIA==
X-Received: by 2002:a6b:bf41:: with SMTP id p62mr2656657iof.193.1545420174877;
        Fri, 21 Dec 2018 11:22:54 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/22] aio: add submission side request cache
Date:   Fri, 21 Dec 2018 12:22:23 -0700
Message-Id: <20181221192236.12866-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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
 fs/aio.c | 140 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 25 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f7992c7123bc..ac296139593f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -236,6 +236,21 @@ struct aio_kiocb {
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
@@ -1822,29 +1837,62 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 }
 
 /*
- * After the iocb has been issued, it's safe to be found on the poll list.
- * Adding the kiocb to the list AFTER submission ensures that we don't
- * find it from a io_getevents() thread before the issuer is done accessing
- * the kiocb cookie.
+ * Called either at the end of IO submission, or through a plug callback
+ * because we're going to schedule. Moves out local batch of requests to
+ * the ctx poll list, so they can be found for polling + reaping.
  */
-static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
+static void aio_flush_state_reqs(struct kioctx *ctx,
+				 struct aio_submit_state *state)
+{
+	spin_lock(&ctx->poll_lock);
+	list_splice_tail_init(&state->req_list, &ctx->poll_submitted);
+	spin_unlock(&ctx->poll_lock);
+	state->req_count = 0;
+}
+
+static void aio_iopoll_iocb_add_list(struct aio_kiocb *kiocb)
 {
+	struct kioctx *ctx = kiocb->ki_ctx;
+
 	/*
 	 * For fast devices, IO may have already completed. If it has, add
 	 * it to the front so we find it first. We can't add to the poll_done
 	 * list as that's unlocked from the completion side.
 	 */
-	const int front = test_bit(KIOCB_F_POLL_COMPLETED, &kiocb->ki_flags);
-	struct kioctx *ctx = kiocb->ki_ctx;
-
 	spin_lock(&ctx->poll_lock);
-	if (front)
+	if (test_bit(KIOCB_F_POLL_COMPLETED, &kiocb->ki_flags))
 		list_add(&kiocb->ki_list, &ctx->poll_submitted);
 	else
 		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
 	spin_unlock(&ctx->poll_lock);
 }
 
+static void aio_iopoll_iocb_add_state(struct aio_submit_state *state,
+				      struct aio_kiocb *kiocb)
+{
+	if (test_bit(KIOCB_F_POLL_COMPLETED, &kiocb->ki_flags))
+		list_add(&kiocb->ki_list, &state->req_list);
+	else
+		list_add_tail(&kiocb->ki_list, &state->req_list);
+
+	if (++state->req_count >= AIO_IOPOLL_BATCH)
+		aio_flush_state_reqs(state->ctx, state);
+}
+/*
+ * After the iocb has been issued, it's safe to be found on the poll list.
+ * Adding the kiocb to the list AFTER submission ensures that we don't
+ * find it from a io_getevents() thread before the issuer is done accessing
+ * the kiocb cookie.
+ */
+static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
+				   struct aio_kiocb *kiocb)
+{
+	if (!state || !IS_ENABLED(CONFIG_BLOCK))
+		aio_iopoll_iocb_add_list(kiocb);
+	else
+		aio_iopoll_iocb_add_state(state, kiocb);
+}
+
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
@@ -2138,7 +2186,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb,
+			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2241,7 +2290,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		aio_iopoll_iocb_issued(req);
+		aio_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -2255,14 +2304,51 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 }
 
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 bool compat)
+			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb;
 
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+	return __io_submit_one(ctx, &iocb, user_iocb, state, compat);
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
 
 /* sys_io_submit:
@@ -2280,10 +2366,10 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -2297,8 +2383,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
 
@@ -2307,12 +2395,12 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2322,10 +2410,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2339,8 +2427,10 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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
 
@@ -2349,12 +2439,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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

