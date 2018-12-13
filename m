Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B0C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1002E20870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="goOGTZ3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1002E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbeLMR5I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33506 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeLMR5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:05 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so16925407itk.0
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=goOGTZ3S2bIPtcVEyAIvwmS+N+HRhYtZ6GRBJ6m6CXJgf/OcgDVA7dTJtEpJhfHWwl
         L/fwf2ReSe1w71CFwyW4r7fk40YPbQzFEg/3YZ0dW6CNDP1UnJH/MIqhXbNJuBF6MZKE
         wyod2DPH5oiRSRLdTXpNQbQ2BwSV8k89seWYuPo/ntyQX9VbdWT0rh6UNGmPKS18VyH8
         +csvJWMDK/q61P47Ctj3F7//178AaK1LUeNw8UWPUwDTUEJEOYSEMBEFb/9+wqUTbo4g
         3JNe+VOoBLHdt/9veQPnQvH0gJG9NXe1O3ubC7UOt4HgZsgc8cYHGfi23DNpHd1xaJAX
         uaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=XQ+/S7G4suSLBWc13gE2+dSFDFFpnx+vQ67wIYF2E9cd/mYZi+q2KaoMuZjhPY27Km
         UO7fJ9XFRyvsLGG168kzOZ/De4gmG17YakjanM4eN0IpC69jet9LhtVc/hoI67tkSLLZ
         Bmp5Shp1VjVXAYsH7C1/ArzTVDI4rFJ9oA3/t5W4sRlBcveZkQ67amVkH+z5+N020gqF
         O1Vzn/3YJktY6Fc+zuFc5ILVkkQISXTw+t5Cx1HuhIHMfZ/QObsV2P9HkPB+8vXHbvYG
         6Gwn5/VnK7mmbeAzNSzrb3+yE9Es4XDXxsbtlE28wMJlfTrKYCiQ8sKM45Of5EHWr666
         VrIQ==
X-Gm-Message-State: AA+aEWZpPpTbYqgUNvqsPPEMQuC8nTrLd+YbcJd7qqUQNQ6YYFqIqEhg
        Nl1171lLPwMEQk0wsSWGEiKV/mxn5umvZg==
X-Google-Smtp-Source: AFSGD/UGUt/ieaGY/xOrXeJHi8t1gAYSSDyTPADAahpvxgzXyMsjM4uyEfmBYSZNz72jt9HDkbSmug==
X-Received: by 2002:a05:660c:648:: with SMTP id y8mr316990itk.48.1544723823981;
        Thu, 13 Dec 2018 09:57:03 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/26] aio: separate out ring reservation from req allocation
Date:   Thu, 13 Dec 2018 10:56:26 -0700
Message-Id: <20181213175645.22181-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

