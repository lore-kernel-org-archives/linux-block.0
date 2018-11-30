Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51FC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FFA2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VUJyCylo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FFA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeLAEHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:01 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38802 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeLAEHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:00 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so10225963ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sgBueyD41WcD6YGB1PXXB7qHQZZJctD1Yvvmpvxoomc=;
        b=VUJyCyloFNtiuGHdaieLZBVq9oWFG3AjexunXFHjMJz4Z1kkKaTvjIFo/ZTws9HLnD
         ub7LpbkC5cjVRrNiBxkGFJRoHnZyO+4X1It9tePq3+TlXzjMaSabSPr11FUuwt4/Rurg
         YKhQXvedROn9CNsN0qzCVX6RskknmHL14OHtgSfic1FPXXRUnuo/uHhrGvacKMSHavB4
         MTvINDFPH+tz358m8YECIYzotbx+1XGTAgxN8diGvcTinIyLK99DUTYvGml4ylGnfMRp
         QtpMHhLD/LmQcKEg1Y8pfaYceQbZRknQ8rgmKUhm+iWZug0xb3CBMwNrq+H+ai+RuUd/
         yU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sgBueyD41WcD6YGB1PXXB7qHQZZJctD1Yvvmpvxoomc=;
        b=iE21xw73JSKKozx7hT2OJkm71UgQgIxgRZVhSrxl4vSfJqaA4rjmaENFwDA0xLLpv3
         PF8oTf6yvK4AoxBe0pGKkrK/orPHXIR6ZvuIFX0nbBFx+LcBUd0QksyOMEGCsq4+UWhV
         BJaeMYGxoVZ7ILd742nM8nZKKJVqwq/L5i8NvAJJ2kSkrUgxfdP5V/4ttJ/R8B6EFumC
         IBW50mYrZc96d5pph6x23+DnR1J0lWGVUi1AKJp48fW/UzXtozy6LAekNSasjzWmebi3
         klpSxTyLcfqoojd/ZbLHbu2ODKerXh2VoA5cHoy4oqcicEZK+fKxsbVy7GUU7+IIx3pp
         qxyQ==
X-Gm-Message-State: AA+aEWabnIvVWKzMhlM83itIP1CB+O1numRnqqkRkNQnen5TyxWeiISN
        03E9vgp3ktKGtHdT47imgOAsg3KR7t0=
X-Google-Smtp-Source: AFSGD/U2j1I6gomwXxzKd2EnHHF2mRzBx7Zqkrh6GYhl02JkQ58WvawhzLfLEaQKCtnAMxsrq4fqlg==
X-Received: by 2002:a24:7c58:: with SMTP id a85mr6013497itd.9.1543597024348;
        Fri, 30 Nov 2018 08:57:04 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/27] aio: separate out ring reservation from req allocation
Date:   Fri, 30 Nov 2018 09:56:28 -0700
Message-Id: <20181130165646.27341-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for certain types of IO not needing a ring
reserveration.

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

