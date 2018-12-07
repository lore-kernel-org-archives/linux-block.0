Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B6C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209E72083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cZ31jsPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209E72083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGWUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45029 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLGWUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so2420197pls.11
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=cZ31jsPf/wcI5Gsyf6/QNeyUeTJWhxquFNELyzhvHoOlRBu8Lyv7d90GskhogG2yy7
         HJdSx8/Shm+8v9L5ppPntu0zK+7A4i4nlRJ/Anuf0mvmWNp+UKw6rcTVKrP+/vXceZVU
         UKiitHRrksj4Ia5DwbjbXAJhbK211RZlXCekhMMDVTlRzMuLGS1BhPJEEaJUnICvqGm2
         N6jgUrn9Nkqh4Aj6SxgEYJ1CKW7otH78Az9bRTw67HOYMLBF5qPI3Y5toO5nMIn5aTC5
         RO8oP1z+a2F2NTypoSNmLjPiAnqEww1Ev1SyBrFTjhOFmHW6Q/LEw+msQRAy1yW99APv
         kctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5thebUgmjkZJznWx9PghrfmA/cZ8t8Zs5+DcD2OHEI=;
        b=FzAR0bv2AFT9JEZa346Exm2NObVmV406aJHxBPVPgSQvtoYnm3Y3lbMlWfRE7yCezk
         ehXhlp6YF6KDtV91pk7zAZUOKuJrsxECzjgzqEfTz6zlHKfvEjqGaN/hTRUtA9Wkcic9
         AqW1Yw8rePv3k9/PwebF9wYjFb7RImaosBTrj0gDwSPt9laex49JMfU3OEySK7KzshiQ
         cEoHQjI4fxih5UVIyEuTzwP3Fs+uJDgPWO9UuL1T7fr8ZpfdIr61nBnDJNWxPZNZNd/f
         7y9WAlf9bPqH1Nx3I5mt2iDhvVHUPcw1rbzTKCNKelCep0em74GcH0NnEfZgIO1SfMc7
         erHg==
X-Gm-Message-State: AA+aEWYUD2NDN6959eWsOlAZsjIpXQUsqdqTZpNRV3c7SHHuqvCjuSG4
        joRoiw5gjHuA3kiPBTMzz/BOChWEZac=
X-Google-Smtp-Source: AFSGD/XDoYI+wbdKPa1hxYv4fTm9aWFKWDAo5fyTPIeEgmISTIpXTGcQYajxY2GYwyaKKQZ+g4LczA==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr3921332plb.330.1544221236443;
        Fri, 07 Dec 2018 14:20:36 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/26] aio: separate out ring reservation from req allocation
Date:   Fri,  7 Dec 2018 15:19:57 -0700
Message-Id: <20181207222016.29387-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

