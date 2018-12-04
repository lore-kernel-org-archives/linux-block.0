Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F4C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D941206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dE8WS+kU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D941206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLDXhy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37862 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLDXhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so8092784pge.4
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=dE8WS+kUC7yZA4W/psiXS2ohAuqeprvpmbU6SBBH2j//376jO5T895dTIRaKHvHs4i
         4LXsmnPEopGbxesEKPAAIpWzOguX+nEM1KE1AK9UzjaITvaiFXrJ4Rl+R8a3rDJXvhxO
         ipcpJh/omuzdnmyroasy9amsPxS4Y3+7AlMqGAMiPc2SHBnp7D72Ych4lcIcJ3FDnwCd
         wUglliba9O8OjMMh9jsjoV2iCckthmeKav0NjAXJh83GTSQkekOwmSYKFXSlkyxAMuOl
         7FPOL7nSsRy+NFEC115kEWA1EfeJkQZAvw4WNaZn31cLedsLxDyW7kg5vGFl+wCCFAfo
         UgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=K/nc5pA6bHIDu8D2qc5+xFfZ3bozqePKrwnbVvCoqxoeF5dEZ5MTWXqNrVtLdqkXdz
         bY+vkjLAqGoOBN8VFggadDVqGXfz9GABVN3hC5xGennEZZIj6YL9WwJxbJFHCvyhW5Zt
         YJEVnHaQdTtXsSuvAu8xVEd+JdD1mpK7BaEm9m3uLV81e5xZYTmgu+kN2DqMewvximeO
         JscxMw3Du2XRCfTMQqabQK8MIdNGzIdJ6heOcDRH8Ss/AY/I2+2LO+mMBCVmqwxJNSiv
         8WMhFZj6gCIeHE/9VdKPKGZ7IJ24U2T4RZwtdaDh/fLOkHMWU/eGP7Ou1fH6MgFUe3D2
         eQvA==
X-Gm-Message-State: AA+aEWbv7bz4QsIyZ7gCbQ5qYfWqq20V62iQOREJZNmtBZtLe7ulk526
        L2LMIKena3p/rHAjcKw67NXFfqqcKU4=
X-Google-Smtp-Source: AFSGD/UVaMY5FzeFtJ9H4penb1h/+C7kMxs1mWyVILtRTdEOYh5ylEJTTUtloBU3PRxVG3ELb2mc7w==
X-Received: by 2002:a63:63c3:: with SMTP id x186mr18526940pgb.330.1543966672509;
        Tue, 04 Dec 2018 15:37:52 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/26] aio: separate out ring reservation from req allocation
Date:   Tue,  4 Dec 2018 16:37:10 -0700
Message-Id: <20181204233729.26776-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

