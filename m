Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE807C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A002320870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y8RZ5Ur9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A002320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeLKAQN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44379 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeLKAQM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so6016161pls.11
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=Y8RZ5Ur9i0aZET3QVVgpoDA3T8VsL+WAmQERmAWAMjTGcJYgpdQ6AgKZRrmW3tQ+cm
         J+iDnztoUFua/4Eq/jNUSmkbFYBT8ziWagQ13bNcHJ9/e/3SVDYR6azkXSV8Q5WwyfjM
         /vQfSgQ+iDD7NOw/6lSxLSXbswGXCBV6Sknz6Medl+kPrf0jZHBX6eqSzpwuuTnc/9QQ
         kRHjrEsHJuhSgkZEykxaYsFbM/DVAqrb7aZEF2avywPvTvIpcBnxNFfkyQSDjJcrMFKe
         l/XkkayC8X9PxEOK5gr597j8BiGMGC+8+DQaDMBEB0LfL0JHoeTaS/LRu4DI1GEOxgVh
         rTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=grUS+xAjsKeD6bs+xnYTFQt1rlK0EJvab9w/wOVE+KK3D3H+Ts9sb+gCKGU/gVjKoM
         4ss/9J2ABCSwYr9wenW5hjRrbH54uclgAXjkCt9OzBFGR00i54+X2hOnvIqnFUP18hG1
         8xbiq0GnurdHKErotzN1ZtXh9bNrB2pNUxqmA/gIeeVAg0Z10ZYikIX8WcX2sElC7JDz
         kNwAqB2bRj2uaWaABCRkNcuRuC7BIHxUJHcM3WB6KAClLpC4cEE/XXTf4cRUEJOqx6i/
         mddlb+VH9jqCH/Vm9FbBM6Z2HJSo7FgTbOPG1GhbH2YhEkC8CnywzYLolpH+vI6IGUCI
         +U1Q==
X-Gm-Message-State: AA+aEWbyxt4Mw9ex0QftQA2TK1Xwz9e/sUfOdfAI5UajfbXepUK87NFw
        pucyNNNe8gNjIQigyTwkqIoAikYhpChHYQ==
X-Google-Smtp-Source: AFSGD/UNL5A2FJv46NFEkODQ1eZ5LGYMNs8Xz5eg3td075YCtKLIYXBYmkmi6olOCSFm66TuqrnVZw==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr14009686pld.236.1544487371294;
        Mon, 10 Dec 2018 16:16:11 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/27] aio: separate out ring reservation from req allocation
Date:   Mon, 10 Dec 2018 17:15:29 -0700
Message-Id: <20181211001549.30085-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This is in preparation for certain types of IO not needing a ring
reserveration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index cf0de61743e8..eaceb40e6cf5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -901,7 +901,7 @@ static void put_reqs_available(struct kioctx *ctx, unsigned nr)
 	local_irq_restore(flags);
 }
 
-static bool get_reqs_available(struct kioctx *ctx)
+static bool __get_reqs_available(struct kioctx *ctx)
 {
 	struct kioctx_cpu *kcpu;
 	bool ret = false;
@@ -993,6 +993,14 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
+static bool get_reqs_available(struct kioctx *ctx)
+{
+	if (__get_reqs_available(ctx))
+		return true;
+	user_refill_reqs_available(ctx);
+	return __get_reqs_available(ctx);
+}
+
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
@@ -1001,24 +1009,15 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	if (!get_reqs_available(ctx)) {
-		user_refill_reqs_available(ctx);
-		if (!get_reqs_available(ctx))
-			return NULL;
-	}
-
 	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
 	if (unlikely(!req))
-		goto out_put;
+		return NULL;
 
 	percpu_ref_get(&ctx->reqs);
 	INIT_LIST_HEAD(&req->ki_list);
 	refcount_set(&req->ki_refcnt, 0);
 	req->ki_ctx = ctx;
 	return req;
-out_put:
-	put_reqs_available(ctx, 1);
-	return NULL;
 }
 
 static struct kioctx *lookup_ioctx(unsigned long ctx_id)
@@ -1805,9 +1804,13 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		return -EINVAL;
 	}
 
+	if (!get_reqs_available(ctx))
+		return -EAGAIN;
+
+	ret = -EAGAIN;
 	req = aio_get_req(ctx);
 	if (unlikely(!req))
-		return -EAGAIN;
+		goto out_put_reqs_available;
 
 	if (iocb.aio_flags & IOCB_FLAG_RESFD) {
 		/*
@@ -1870,11 +1873,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	return 0;
 out_put_req:
-	put_reqs_available(ctx, 1);
 	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
 	kmem_cache_free(kiocb_cachep, req);
+out_put_reqs_available:
+	put_reqs_available(ctx, 1);
 	return ret;
 }
 
-- 
2.17.1

