Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C0C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DEF20850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wTHxxqSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DEF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeLDXiQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:38:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33812 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeLDXiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:38:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so8111099pgg.1
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FMBq4Ko2X8hOWlZDiRYYO1SvxX1cU99rIKE1Z/Iwshw=;
        b=wTHxxqSqaLdRtaUCpkk7nREaquaoNMqtcc34mO4mFLCI5UgEZgZjR9yKNK7jqDpC2d
         rxagvmejex7KsLz4wVew7Kn306YDXdesZyvLsS967SsDlK1va/L81nXcrabzV39+Zw1h
         Jse2RLq6GxzAYOav1AOKbC3I1KXMOmvPklHje/uNp8qMkRaWK78c8O6wCzAN/FJsMM0t
         4w81zFj/b41ffkz0QtyPVXkxmpxJtGEaGzbeBS4eWNGbiHf7OLuOAH3l3hObXhA/qiTi
         ddXP9l1pshhOXwsjovmI6pjPFBjjQlQUzDOzH6ud9ww71+dIBG9z130heQ9Gj06a/ZMJ
         NdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FMBq4Ko2X8hOWlZDiRYYO1SvxX1cU99rIKE1Z/Iwshw=;
        b=mWu8KUlEJ1GFvOqyOyR1zyRmEPXToiEKAu/X8FKOQGYH3xwRzlQUoC1G4PN8KOm6uS
         jE7o4pp+IIkjFYK1BCfdzxoNf7yYYH/b/8Fl1nBraLsVALLJfrGifYlVclULhptqJfpn
         eURCKu/cl/Nyq9YNKO2CNdNlUi0E5sZlYWSMEF4HZAwUg7oEaEfkpP5WEh4CUIXL2ZtM
         D4+aS/yBSe20tF5kNj5y0U7qeEb/VEuTZHUEAP0TQxkjgSiNjdnW+2hMMd2GcBkDNXTi
         Shr1crMClO9N8HBfsmtHghIAW8KN2VWLRp+5i/r8767ReXUuGu7uY61RPA3pEpXV1Wuq
         Ll1Q==
X-Gm-Message-State: AA+aEWZXn1RnulmrBof9goiL9SkaTGWqx1V6MPFJUwMxa9rjIorPOKJ7
        ezkQxlhTJ5Ypp7xnMB80oWdC1uE8Y3I=
X-Google-Smtp-Source: AFSGD/XzWyAzMRPXdGtpwR3vCNt5S2qndhUzVY+Gtpe5nm3NuRVgK08erryBwK16RZRrhm1YMUh7IA==
X-Received: by 2002:a65:530c:: with SMTP id m12mr17949829pgq.224.1543966694537;
        Tue, 04 Dec 2018 15:38:14 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:38:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/26] aio: add submission side request cache
Date:   Tue,  4 Dec 2018 16:37:19 -0700
Message-Id: <20181204233729.26776-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index 5d34317c2929..ae0805dc814c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -240,6 +240,21 @@ struct aio_kiocb {
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
@@ -257,6 +272,15 @@ static const struct address_space_operations aio_ctx_aops;
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
 static void aio_useriocb_unmap(struct kioctx *);
 static void aio_iopoll_reap_events(struct kioctx *);
 
@@ -1887,13 +1911,28 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
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
@@ -1903,12 +1942,21 @@ static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
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
@@ -2204,7 +2252,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb,
+			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2308,7 +2357,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		aio_iopoll_iocb_issued(req);
+		aio_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -2322,7 +2371,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 }
 
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 bool compat)
+			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb, *iocbp;
 
@@ -2339,7 +2388,44 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
 
 /* sys_io_submit:
@@ -2357,10 +2443,10 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -2374,8 +2460,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
 
@@ -2384,12 +2472,12 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2399,10 +2487,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2416,8 +2504,10 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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
 
@@ -2426,12 +2516,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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

