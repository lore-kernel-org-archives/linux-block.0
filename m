Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77876C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A6A20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Wd4GUhAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A6A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeLMR5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55330 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeLMR5U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:20 -0500
Received: by mail-it1-f196.google.com with SMTP id o19so4960232itg.5
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GUCvbWUF6Qc+d/jnhNwti1Njr0Plm9kxIvawXXmUvck=;
        b=Wd4GUhApyvyd2v87HB7j4Cf635p7pDoK6WBn6bE5JJPELRSSuqOmNv23/iIPAmetXf
         7HFPxfa2F+ZjCuK89pk5vNu0alzmzJi3kOcMXODvEnhxQCi8GKHgtlW6lfzIGA4m7UCm
         TUkez554Digkp/RsybeqRQpdb32vyZ8T5THoqAzXfC2LOxryGV6wrRYWWg5CNoNwA9gN
         ZbkD5XLIzLEC/aRDnCY/Yr9tZ3OZn9BC9IIwm0xu1W4b2MFaMrTjtuV/B1Db/O+3QJEg
         yOlNd1u+dblNz2bXSE+2ntuyes+nHzPYG9Y/b8ACYaQ0kV1OItinaqa+OLwlkUq2HVkd
         KP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GUCvbWUF6Qc+d/jnhNwti1Njr0Plm9kxIvawXXmUvck=;
        b=BX8cs8OZZKJk9J/XXDIl4a3PaEL+BsmtlWYmQ2sCXQIsxSSTKjOtINz1K0TcOiwtTf
         Pb0An7uGQ2Dj4bJFNNcmfkGdgRQrlL6Poi2+5iBKzyXdoBkHP8I2cX4ZI+T2mGluAi4j
         9CAK1X2rO8pdzA5ZC2lVARm0Sb0h4VExmPl006VuHLYk99zp87OFWcUXqZestd/2WCjC
         7JSL+jMKMKSAog6GA+Fwz5wTFCvixzi8zk2JUaCkeYeDlk09HCdOCBjPyVttkkVM4w25
         EapeaZWWwuQEBDAZESIPJp9FtKI/r2GSn3zNAPaUhSvQDDvM7n7QllEZBRjqvrBfdhpX
         kc0Q==
X-Gm-Message-State: AA+aEWYILtOXCI70+M9EN5IccFtsYwhwidSEHUmOZZ1D1y0pIy+8aNR2
        LhTkUbjbVpQ5Yrr3En52z6YHhdF36Iwn+w==
X-Google-Smtp-Source: AFSGD/Wfvyl1vF9PNnPS5H1ilACQ2MCRd81e7pONz38zJMOuES5cKhBQhm6SJ66/s59PYWnJOC9Czw==
X-Received: by 2002:a24:b91d:: with SMTP id w29mr314010ite.138.1544723839087;
        Thu, 13 Dec 2018 09:57:19 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/26] aio: add submission side request cache
Date:   Thu, 13 Dec 2018 10:56:34 -0700
Message-Id: <20181213175645.22181-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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
index 0f48c288e5dd..abc0e4dc2aed 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -233,6 +233,21 @@ struct aio_kiocb {
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
@@ -247,6 +262,15 @@ static struct vfsmount *aio_mnt;
 static const struct file_operations aio_ring_fops;
 static const struct address_space_operations aio_ctx_aops;
 
+/*
+ * We rely on block level unplugs to flush pending requests, if we schedule
+ */
+#ifdef CONFIG_BLOCK
+static const bool aio_use_state_req_list = true;
+#else
+static const bool aio_use_state_req_list = false;
+#endif
+
 static void aio_iopoll_reap_events(struct kioctx *);
 
 static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
@@ -1823,13 +1847,28 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
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
@@ -1839,12 +1878,21 @@ static void aio_iopoll_iocb_issued(struct aio_kiocb *kiocb)
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
@@ -2140,7 +2188,8 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb,
+			   struct aio_submit_state *state, bool compat)
 {
 	struct aio_kiocb *req;
 	ssize_t ret;
@@ -2243,7 +2292,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			ret = -EAGAIN;
 			goto out_put_req;
 		}
-		aio_iopoll_iocb_issued(req);
+		aio_iopoll_iocb_issued(state, req);
 	}
 	return 0;
 out_put_req:
@@ -2257,14 +2306,51 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
@@ -2282,10 +2368,10 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -2299,8 +2385,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
 
@@ -2309,12 +2397,12 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2324,10 +2412,10 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
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
@@ -2341,8 +2429,10 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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
 
@@ -2351,12 +2441,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
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

