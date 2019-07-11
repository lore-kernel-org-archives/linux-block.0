Return-Path: <SRS0=DuRR=VI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B997EC74A36
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 01:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C620844
	for <linux-block@archiver.kernel.org>; Thu, 11 Jul 2019 01:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh9LTxSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGKBHx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:07:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37338 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfGKBHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 21:07:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so4345862wrr.4;
        Wed, 10 Jul 2019 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNJs4cZP2IYYOVTOv3cYnGNQZXWMmSCFchAcLMC32HE=;
        b=Eh9LTxStpzWayPSf90Si8Gs/8D+/mGF72kpLyPGICx9SKTUXEcgSIIHbTPmHAV5oWo
         Mb+rRIw/t6WNZUkJQG/m2stvZi4+8JHmK6/CszWJ98vVuAjlQGZZVIAE/7tkERfY8dWh
         GJtydEzLYzWgy5+tavpttKQ21UvtTOVzvIwz+PTHrRysvbAYN2fJqJpjl6utGjIghjAm
         qor+X23g+4CX3IA0JqKsx/R8zB/ZRG93pEnJMbTAlUXvkwDk7Tig45AF+uEjc9Xp56Q5
         J3miYt9rjZ4fg3tBneR0HfDtwlwh4wU8WBPCshqJ+q4GZ2Fx/vixvSgkFEL3q0rHv0TD
         jHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNJs4cZP2IYYOVTOv3cYnGNQZXWMmSCFchAcLMC32HE=;
        b=Lk2P3pgZM2fH4QcaJ0sU1DiM5YQxcK+5qis3roQrVF1zA8WhYWSxj9kMEuVQ6yGqlv
         ReoRbBeSCxofdN87EYaD+qrzUL3oL49wGJL6FSntsYxd/X82KlFsy/RhlPn/1a3Z+III
         y42n2kMZmlhe3RH+TQZL0/WvAJep/kTFO7HcczuoLZILEnjbEVIQs30s5VqsBwBVVu6u
         iet+VeZYm5GLyJZAb2ptzQ6rfRZM8a4XnEUD5qvegov4BjBYK9CC7rGgv1bJb1ucu3+4
         oL/LtExDQ+Ei1F9DfRq2DVqRd7B2xvu9lN+AcmyZ1OR6Y0odmxkORGOM2VjL67hJFVby
         d65w==
X-Gm-Message-State: APjAAAWMWrljO3HTdoow9cYG79wWcq7YRJLz4hh9k0qNIujnulXKLqjY
        ivQfdAQno2f9HClGFO2Z6hw=
X-Google-Smtp-Source: APXvYqypYK+Tf2AO+YSS+d27zke6iaUEkWPLSWP6KZmZG3mBOAMjQHKN5GGI8GJjxx9Eg20mbszGYA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr478993wrm.55.1562807270742;
        Wed, 10 Jul 2019 18:07:50 -0700 (PDT)
Received: from localhost.localdomain ([109.126.142.165])
        by smtp.gmail.com with ESMTPSA id r123sm3894102wme.7.2019.07.10.18.07.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 18:07:49 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC][PATCH] io_uring: Incapsulate conditional mem accounting
Date:   Thu, 11 Jul 2019 04:07:31 +0300
Message-Id: <ba9abac35d74b11a0e338b478e472107064b738d.1562807210.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

It's quite tedious and error-prone to manually check before each call
to io_{,un}account_mem() whether we need memory accounting. Instead,
the functions can work directly with struct io_ring_ctx and handle
checks themselves. In any case, they're perfectly inlined.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 59 ++++++++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3fd884b4e0be..f47f7abe19eb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2704,14 +2704,19 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	return ret;
 }
 
-static void io_unaccount_mem(struct user_struct *user, unsigned long nr_pages)
+static void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
 {
-	atomic_long_sub(nr_pages, &user->locked_vm);
+	if (ctx->account_mem)
+		atomic_long_sub(nr_pages, &ctx->user->locked_vm);
 }
 
-static int io_account_mem(struct user_struct *user, unsigned long nr_pages)
+static int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
+	struct user_struct *user = ctx->user;
+
+	if (!ctx->account_mem)
+		return 0;
 
 	/* Don't allow more pages than we can safely lock */
 	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -2773,8 +2778,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 		for (j = 0; j < imu->nr_bvecs; j++)
 			put_page(imu->bvec[j].bv_page);
 
-		if (ctx->account_mem)
-			io_unaccount_mem(ctx->user, imu->nr_bvecs);
+		io_unaccount_mem(ctx, imu->nr_bvecs);
 		kvfree(imu->bvec);
 		imu->nr_bvecs = 0;
 	}
@@ -2857,11 +2861,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		start = ubuf >> PAGE_SHIFT;
 		nr_pages = end - start;
 
-		if (ctx->account_mem) {
-			ret = io_account_mem(ctx->user, nr_pages);
-			if (ret)
-				goto err;
-		}
+		ret = io_account_mem(ctx, nr_pages);
+		if (ret)
+			goto err;
 
 		ret = 0;
 		if (!pages || nr_pages > got_pages) {
@@ -2874,8 +2876,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 					GFP_KERNEL);
 			if (!pages || !vmas) {
 				ret = -ENOMEM;
-				if (ctx->account_mem)
-					io_unaccount_mem(ctx->user, nr_pages);
+				io_unaccount_mem(ctx, nr_pages);
 				goto err;
 			}
 			got_pages = nr_pages;
@@ -2885,8 +2886,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 						GFP_KERNEL);
 		ret = -ENOMEM;
 		if (!imu->bvec) {
-			if (ctx->account_mem)
-				io_unaccount_mem(ctx->user, nr_pages);
+			io_unaccount_mem(ctx, nr_pages);
 			goto err;
 		}
 
@@ -2919,8 +2919,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 				for (j = 0; j < pret; j++)
 					put_page(pages[j]);
 			}
-			if (ctx->account_mem)
-				io_unaccount_mem(ctx->user, nr_pages);
+			io_unaccount_mem(ctx, nr_pages);
 			kvfree(imu->bvec);
 			goto err;
 		}
@@ -3009,9 +3008,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_mem_free(ctx->cq_ring);
 
 	percpu_ref_exit(&ctx->refs);
-	if (ctx->account_mem)
-		io_unaccount_mem(ctx->user,
-				ring_pages(ctx->sq_entries, ctx->cq_entries));
+	io_unaccount_mem(ctx, ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
 	kfree(ctx);
 }
@@ -3253,7 +3250,6 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 {
 	struct user_struct *user = NULL;
 	struct io_ring_ctx *ctx;
-	bool account_mem;
 	int ret;
 
 	if (!entries || entries > IORING_MAX_ENTRIES)
@@ -3269,29 +3265,24 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	p->cq_entries = 2 * p->sq_entries;
 
 	user = get_uid(current_user());
-	account_mem = !capable(CAP_IPC_LOCK);
-
-	if (account_mem) {
-		ret = io_account_mem(user,
-				ring_pages(p->sq_entries, p->cq_entries));
-		if (ret) {
-			free_uid(user);
-			return ret;
-		}
-	}
 
 	ctx = io_ring_ctx_alloc(p);
 	if (!ctx) {
-		if (account_mem)
-			io_unaccount_mem(user, ring_pages(p->sq_entries,
-								p->cq_entries));
 		free_uid(user);
 		return -ENOMEM;
 	}
+
 	ctx->compat = in_compat_syscall();
-	ctx->account_mem = account_mem;
+	ctx->account_mem = !capable(CAP_IPC_LOCK);
 	ctx->user = user;
 
+	ret = io_account_mem(ctx, ring_pages(p->sq_entries, p->cq_entries));
+	if (ret) {
+		free_uid(user);
+		kfree(ctx);
+		return ret;
+	}
+
 	ret = io_allocate_scq_urings(ctx, p);
 	if (ret)
 		goto err;
-- 
2.22.0

