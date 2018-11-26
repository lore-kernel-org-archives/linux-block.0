Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F1C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0653620855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fzMXQnJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0653620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK0Dkp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:45 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54570 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK0Dkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:45 -0500
Received: by mail-it1-f193.google.com with SMTP id m123-v6so5069799ita.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sgBueyD41WcD6YGB1PXXB7qHQZZJctD1Yvvmpvxoomc=;
        b=fzMXQnJBDQ12o1SCpVJ0wTAHz6XhLyu3SvL2bffUfqUh1V7cFkmYKtx+O8Nie0UUH8
         yEv39/xjpjR+UU0IqFdAE3I0TGU426cz8a/dWippznmaCnIUD8DRCyPUS8L7RiWd0PzL
         K9NNoPMG9glOb2KD97yBgYdQS6PHgPTYt7Fj26L/H6J3Lt4mtqtETTWcEpU2M7fnCgwi
         AVwi71pt1Mydwy+d6goLkZKrueJiZqOG2L8d94RcKKPAdhEx3qPAAUy2UvMMaOeFn0sn
         46u1ah82QLykjCaIo4B5Hjmjf2UjVB1PE8LSePGJmbWd2UtWq4LDqYMouG46GFAGfwRK
         JH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sgBueyD41WcD6YGB1PXXB7qHQZZJctD1Yvvmpvxoomc=;
        b=W+ClUFsCBUoLTWFp2q7+USKkN4GDRJFM1DOdkiG2lOwJ+TFOvtpNLZc2mndrijI+35
         E+Nu9WglCIGTvad3f7f1KnsXDormKR+sVyCRxG2LLlF6K/qZdICqXFMlnqmJh1FAvU78
         p81LI50QpasZzwOz+AeCsbwra537p1/gszuq0sKNnxnHy8gguRh8hTMA1fJiwl0lLfLw
         18Wuv227HEL1/vFbDSIyefGovkB+OOD7b8Eg+FXQBAdyVzlQ7s/Uc6R5FlbGeWRU7iYh
         wC/NWy0oEybTyuM1ne/EbyBeVcTeEuxqqrNXx1+v6jAPc63FRF4+SaGHJTjVTEcitklL
         wlrA==
X-Gm-Message-State: AA+aEWY91bVcURVXPH4EvZN/0++l+n2vJrkaKOP3A1wvQfg67jaqb7bM
        tNC3nIqx1qK8SXSDdSRz/kFyk9mc638=
X-Google-Smtp-Source: AFSGD/U0UjEjF6tNASkpLnca4/HGYyUBxqCAafb4XiHHQ1nvARl6VBgbi58+SEbIaCWGKvYffdVZ5A==
X-Received: by 2002:a24:89:: with SMTP id 131mr4630058ita.105.1543250765420;
        Mon, 26 Nov 2018 08:46:05 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/20] aio: separate out ring reservation from req allocation
Date:   Mon, 26 Nov 2018 09:45:33 -0700
Message-Id: <20181126164544.5699-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

