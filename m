Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E17C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BEA2086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0w8wREmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BEA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeLKAQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45398 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeLKAQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so6020756plm.12
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=or2tcedhS0QBXtP0bJsBjGzM2Gx/ZvQJgz+HrITSXEk=;
        b=0w8wREmdymZE6dEvrjt8F4+LKaKXrXkJHTwsEXDivCS3LDALrhIO/Cv3Beu4Qo1RVt
         i8t7Jsjdc1j/stigrBKgciUYQVZOD3Tw1FoyQdQVtZY5LcZldl14sV3ESKDoPtNN/9Zg
         /punhjrEqcF1LV6YpYZUR596XUrjBvHBlXSXFRoH0c7cJuUlFPIfB93vSaXd2/uA0dmn
         NUXeGl0V6TxyWdqXuzOcRrKe9A++5wb46G9XzlUBIAiRctTPN1eM9ESt+Yr4eACc2JBv
         se2GpNXOsRqjXkde1S7DrLFqfUFnQlGBD6VRoYi9xNTtL9pz6x9VasuN5PRZ+oy/3DM9
         IFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=or2tcedhS0QBXtP0bJsBjGzM2Gx/ZvQJgz+HrITSXEk=;
        b=WXm01XkzR4KBnY9RYgShebEy6qLBf6uPLOCyklisUBufJ4mqDZBV6WVJXJ2zPkwqmt
         GkFA56xjcez0jzq4okXsCMjC+lD2CSfMaRrTQfmhSAB3/7TAmBUyOm1ZtEaiCU1T7mJ1
         Fswnm2bI7UsedBisrOEE9eqqdYhdc2Gl8tlaPbiHBmJyAGWqIRhg7ANPDYHOeeNWRCgW
         5WIeXzYPNhiReUH3QJUjFDabT6jNZTsm6xdenEs+CyVRO6jA/2gY8JufK++0Sw3u+kr0
         1IKW7he4srU91K3Ltqnt4G7w3ZcDIsmGMQDNZvKR3M1OX7M1DpksNub4ekY/0I035o4y
         YU0g==
X-Gm-Message-State: AA+aEWb5hdobSfOjkbem55dwQjMKWp6djBfw7DeauPa7TuXK/g3EN1SE
        EXJzTMgutbhjeVmqd/kk1GhW78kyh3hWtA==
X-Google-Smtp-Source: AFSGD/VR09KJFndJAsUZ1tbSDbTZEhPNsNbmvT8qpY5cBrHbiUaIO7nW6IbOaUfmvroD1x4QJoOWSg==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr13960418pld.240.1544487388896;
        Mon, 10 Dec 2018 16:16:28 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/27] aio: add submission side request cache
Date:   Mon, 10 Dec 2018 17:15:38 -0700
Message-Id: <20181211001549.30085-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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
index c4dbd5e1c350..2e8cde976cb4 100644
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
 
@@ -1901,13 +1925,28 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
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
@@ -1917,12 +1956,21 @@ static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
 	const int front = test_bit(KIOCB_F_POLL_COMPLETED, &kiocb->ki_flags);
 	struct kioctx *ctx = kiocb->ki_ctx;
 
-	spin_lock(&ctx->poll_lock);
-	if (front)
-		list_add(&kiocb->ki_list, &ctx->poll_submitted);
-	else
-		list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
-	spin_unlock(&ctx->poll_lock);
+	if (!state || !aio_use_state_req_list) {
+		spin_lock(&ctx->poll_lock);
+		if (front)
+			list_add(&kiocb->ki_list, &ctx->poll_submitted);
+		else
+			list_add_tail(&kiocb->ki_list, &ctx->poll_submitted);
+		spin_unlock(&ctx->poll_lock);
+	} else {
+		if (front)
+			list_add(&kiocb->ki_list, &state->req_list);
+		else
+			list_add_tail(&kiocb->ki_list, &state->req_list);
+		if (++state->req_count >= AIO_IOPOLL_BATCH)
+			aio_flush_state_reqs(ctx, state);
+	}
 }
 
 static ssize_t aio_read(struct aio_kiocb *kiocb, const struct iocb *iocb,
@@ -2218,7 +2266,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb,
+			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2322,7 +2371,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		aio_iopoll_iocb_issued(req);
+		aio_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -2336,7 +2385,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 }
 
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
-			 bool compat)
+			 struct aio_submit_state *state, bool compat)
 {
 	struct iocb iocb, *iocbp;
 
@@ -2353,7 +2402,44 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -2371,10 +2457,10 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -2388,8 +2474,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
 
@@ -2398,12 +2486,12 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2413,10 +2501,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2430,8 +2518,10 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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
 
@@ -2440,12 +2530,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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

