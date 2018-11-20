Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BFCC41536
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCF221104
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hBM2lZ3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCF221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKUDux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39199 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbeKUDuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:22 -0500
Received: by mail-io1-f65.google.com with SMTP id j18-v6so1946961iog.6
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SzRyk7JKC2mFK9FAb48i6ycj+96baAFMRnokOMy9t/A=;
        b=hBM2lZ3JbKjtScoijUqwB7qYOwknjgLdksItdazOwqKCGS+PcoeW7YEl5JAdYU8z4D
         dOEK7KJemA5Ra3tgW3CiE3ZoSmEU9LOa8lwgGnaxTaB+nTOU+RIOnJelr9n5uRS95bWz
         CyYLZNZjU5cRHdtgGXJPYB3UoC8h+vkoEdaxFHNxS5MplYgwC3RDiEBiYCobkaZFkOaM
         /mX6QeFBdhTwe+ZtjsIwfDdkkKzYFF8h1WwS9n9Kuo3vQimBTqTKtzgwu1SSqo1T6G/B
         2zUj9iylx3S/kTZJqTGCne17F2qW4qQqDunOvH2T0l8tyhAPOskUP8KdONG1DiA1AERq
         C13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SzRyk7JKC2mFK9FAb48i6ycj+96baAFMRnokOMy9t/A=;
        b=MX1/F3aZhb9D4A4xUH6YDAbbJBpoY0Id+ik2blU/QNi1PAaiSS68HLPNFBFKmgNr2n
         tR85Ot+nTXrBUFMSw63vgx7bNRfZ/JzbkAeSnXIQmVxAOL4dfdMO7BMXl6HABQfju6cG
         gjFQ5OB6YtSipVpbN5eNp7S2iikH8jRUwFFhWdVB/EQ+F6g2gCdmtMXXtwhXgHZLj1i/
         UxEwc3O/xv3EHtDoxbSHmJmfV/9ZqdffoBtW+VnCmq2tTOE9PS10Tze2LgQfqrXoTopX
         j0sjbAUZVj5eFfrW6hbBol8B3B2goeIgLIQwURx+DwaW90rchcoGocZCehy/S1XKt4QJ
         iT1Q==
X-Gm-Message-State: AA+aEWZFjZJ8y8hH3l5xYBER9mw9KsPRUp95R39dTxT27zk5HetkhPJd
        jHXjlfZf45UPCEuKzlFyp7STe+ozaE4=
X-Google-Smtp-Source: AFSGD/WMBIT4wEUJW9TOJqv+md8DeEb1MF6BFadnNBDdXnvfa8PsnqqALQcb46KYqLGhxWFCiAiSHA==
X-Received: by 2002:a6b:7019:: with SMTP id l25mr2299637ioc.145.1542734408390;
        Tue, 20 Nov 2018 09:20:08 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:20:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] aio: separate out ring reservation from req allocation
Date:   Tue, 20 Nov 2018 10:19:52 -0700
Message-Id: <20181120171953.1258-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
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
index 8453bb849c32..8bbb0b77d9c4 100644
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
@@ -1821,9 +1820,13 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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
@@ -1886,11 +1889,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
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

