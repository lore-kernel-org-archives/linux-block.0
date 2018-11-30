Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F36C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF102145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="No3gkT1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF102145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeLAEHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40599 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeLAEHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:02 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so10215771ita.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mh+baagw6TRyG7ZRVJ1uWljPK7oJpHidng0AtT9sC8g=;
        b=No3gkT1cBff8WIB0JKRLELIEuIBXuiFMK/q55F8ok1ZOSJh7obe2m3gXpWIPL+/Ac7
         KsLpKYPkkNv7cgIUYh9vTkZnGvEL1E9NA4lFiejLQTz85JT6FU086NZ3EbauqFxcXNru
         sJQQxQRLNXHkqGAjLhL9xWaUzthzrKZBLS4VeBHm5VV8PUraNEurPBrUd0b2x03r3H9I
         PkwTovmzFGYsaBbd8mboEIqd/AZzz2mVWnfk0hGug/j6zj/Hz2H7PExGes8LBssvO1ac
         t0a8x1OVFv5Ec69l4ipkpkQH1WACIKpC7zpY9IUzwmddFIDyxdfSrmk3SKx4NkfuOuqK
         MvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mh+baagw6TRyG7ZRVJ1uWljPK7oJpHidng0AtT9sC8g=;
        b=rUnQ3UeaIxMis3EZPBNxmLDjyLtvL8QlwIV2GCZ51Ftt5xwxtt2HPfJz7jQV6QDctl
         jfRE4eGAWmXuyvXoA3laEXT94aDUpB2U6fWzA+b869759XlKls0IpzxIA3qSq7bbHJi2
         yOgtufTCx9dkVlZHpQorgS5BpEiHGYtwc3SgUL/Jcn+mSDjudBAQOKT1teByHGRDMc23
         DBYQrY1Jr18FNsQh+wWt2XDW9+B0w/0UlUjGEeP93TivdSKAvw/2uAL9+fS2C5g65S61
         eDGxNWd6fveMDG4Q5YUT2mQnQ8dBrVXz6b0fFblJlr0ffpWvAgnk7d81wIJuLXetTpDV
         NfhQ==
X-Gm-Message-State: AA+aEWaMbUaNHr1DQEvb2MX+Iu37mqsMF4E+RrNnY6KB8Xjc7NPgXAuZ
        lt/VhbYFILEqyko2S/ORtBZYcxRUj3E=
X-Google-Smtp-Source: AFSGD/WcLQtsHHmAH2xItbMRnpRj0s2p04D04qlaY3Z7eEiybl1mtRHO/kG9CxSevAdJwGKbwj49PA==
X-Received: by 2002:a02:12c5:: with SMTP id 66mr5946928jap.54.1543597025649;
        Fri, 30 Nov 2018 08:57:05 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/27] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Fri, 30 Nov 2018 09:56:29 -0700
Message-Id: <20181130165646.27341-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's 192 bytes, fairly substantial. Most items don't need to be cleared,
especially not upfront. Clear the ones we do need to clear, and leave
the other ones for setup when the iocb is prepared and submitted.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index eaceb40e6cf5..681f2072f81b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1009,14 +1009,15 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
-	if (unlikely(!req))
-		return NULL;
+	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	if (req) {
+		percpu_ref_get(&ctx->reqs);
+		req->ki_ctx = ctx;
+		INIT_LIST_HEAD(&req->ki_list);
+		refcount_set(&req->ki_refcnt, 0);
+		req->ki_eventfd = NULL;
+	}
 
-	percpu_ref_get(&ctx->reqs);
-	INIT_LIST_HEAD(&req->ki_list);
-	refcount_set(&req->ki_refcnt, 0);
-	req->ki_ctx = ctx;
 	return req;
 }
 
@@ -1730,6 +1731,10 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
 	if (unlikely(!req->file))
 		return -EBADF;
 
+	req->head = NULL;
+	req->woken = false;
+	req->cancelled = false;
+
 	apt.pt._qproc = aio_poll_queue_proc;
 	apt.pt._key = req->events;
 	apt.iocb = aiocb;
-- 
2.17.1

