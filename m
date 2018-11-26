Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613A5C43610
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2974720659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HPouFcMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2974720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeK0Dkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36117 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeK0Dku (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:50 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so28762749itj.1
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hPqsRSp/t/J4Haujgv9+B43f7+1jV9cXsozT1ugKjo=;
        b=HPouFcMTP40WuMbWDUBWUh6rXs04bRB6nLamLVJxWKLfSTgvZzOaSrUtsIOdytKHrP
         K4xhORduMw++7Ygd7bphWcbJnZx69stLlKsiKLEkIYw5WPFoAN78+Wshw3Ii7WPMcFYK
         zw2NqZwHBNBuvOONl8N6Q6lpjivwMws3SzbWdDRXM3q4RoaYaakHRTYjLUtm7rgU0Q/9
         Nyz0hXaEfqwjHUsF11AKoddp3HpMxwK+2/oClNMVROrDkr7B/YbWFugvv5jli9OQbOrL
         nF4lkz6Nwt2361RPtmy7L2MrnPJV7Q4nUb1ok45fDsmcj5zo0nKSK106efp1U4Gzg7cf
         Nspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hPqsRSp/t/J4Haujgv9+B43f7+1jV9cXsozT1ugKjo=;
        b=Gy3xxBSSGxcd4Nvx7C0Hr2XvrVqnAZOHxBrvvQGThwuOVLDvnOWtZKePU4NEYF3myf
         tQbwCe5IoRPv3+s4jxAMDrFTQh5Au5RrTTy1UMfc4eOr8NPfgNQYadkIe3VFnpt/8Mu1
         7LSjUKCQGNNU/V2mIOAezmHknKAfj/lriTOlBAmcyeF/a+FfdoxtOAk7e66VURxKUJPH
         GwvCMwQGkif4ElZGyiObJ7JCP241pAx+Kjhf+90KgmpELRGKUdWudD89aH7jAHt/OrwF
         IEwY2ee3Z5E3CPuZK7MXy8BbFsbAtC8CHA4/cieLeRaqOKKCjeoEqykINIwxi6egc7WP
         vEZw==
X-Gm-Message-State: AGRZ1gI+e9ZF46dpv5V0FgJME/PIo7w0xLmRC/pgM9yYUK8rdrdzyiWX
        XHbHKTUQ6eyWflANBmYWzIecRx5Nzlk=
X-Google-Smtp-Source: AJdET5cGqA2CUJoCQGn3U3Kxw/Tksqpsg3yIg40eoEUBb/6RTwmbgfp/nQH5XW7HD1TwaFA51GEBLA==
X-Received: by 2002:a24:3c43:: with SMTP id m64mr23062445ita.22.1543250770741;
        Mon, 26 Nov 2018 08:46:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/20] aio: use iocb_put() instead of open coding it
Date:   Mon, 26 Nov 2018 09:45:36 -0700
Message-Id: <20181126164544.5699-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
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

