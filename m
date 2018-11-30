Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B9C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF122145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sz6VUAyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF122145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeLAEHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39314 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeLAEHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:05 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so10218242itl.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hPqsRSp/t/J4Haujgv9+B43f7+1jV9cXsozT1ugKjo=;
        b=Sz6VUAyvjCgyg/BgD9Rh8Dp3owrIvg6sysqFF7ip2j3Ssexon4xfM/7+iY6MUDmzh7
         Ml7shDAlm4wGOUjRXhtwzF7Tpu0Z2QlwMSazKgfbPoag08AClX2aRokriLYyHZWaH3jl
         rOJtIKJOlQhYmJYYzQ7VZx4fgm0rwSQyBtvrwqfBm7DtbbfIi9jCxc4CZqcgDxDSciTi
         OPVZyF2GJs1TlTQRbAtlSR4Lw13sORgIdnhtZtYNW6rWJzbP8GPtpBQayu6Q6T0ulu29
         zecSXkGIS328ENcoWi1VF1LXZCbzcMs9TWBPOA3RgZeRlNoXmHbDn0kOrT6wUZnwm8jj
         6y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hPqsRSp/t/J4Haujgv9+B43f7+1jV9cXsozT1ugKjo=;
        b=PYcsqZ+7RaqSMrx9zM3jL6J3f7h/TCXPic2VjxUqgEwNFKzErymyUjKvbMABgoJfx1
         k89xoXq7HQmpzhQNaEbZb1eOpzHOVWyX5BCz2W2H+Km9mllJmkgnqzCk3yhSqnmGAWg4
         d5Ys0ENlZqNnUN9t5+3TF+/rGjoPmw+C0Msxn7BA5Ig66wvMADXAD0pLewG7rbWszT6m
         U9A7nkRBUe9H4NIQY8UHqXQvcLBl/fWBkj4kCgIa8h269Gu5/fSwRQssXThCsUBWyVS+
         Z55Bnal7laiAGLNLfJNmOBKRcfr/ZxXfusQ0ufo7OD6KUUs2p0dTTJ/J8koQuIGcFnE9
         2LMQ==
X-Gm-Message-State: AA+aEWY8UEiz1MLemQsgGNfYd8c1+SVAvIGPYQOoTJlUWwmOpzEs2Wch
        g2twFJw2EOJ+nKNYY01QEf10A45p/Lc=
X-Google-Smtp-Source: AFSGD/X4FBxX9pIBYP27LYasJrY9Clxt4rqZX5Wzptp2+bfMExF5sW53WDLQGfvkFQe+MErJXm+7Dw==
X-Received: by 2002:a02:b719:: with SMTP id g25mr5496992jam.46.1543597028934;
        Fri, 30 Nov 2018 08:57:08 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/27] aio: use iocb_put() instead of open coding it
Date:   Fri, 30 Nov 2018 09:56:31 -0700
Message-Id: <20181130165646.27341-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the percpu_ref_put() + kmem_cache_free() with a call to
iocb_put() instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 533cb7b1112f..e8457f9486e3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1878,10 +1878,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	return 0;
 out_put_req:
-	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
-	kmem_cache_free(kiocb_cachep, req);
+	iocb_put(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
-- 
2.17.1

