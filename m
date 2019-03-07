Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC40C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CE420851
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 21:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="lWXsI3oY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGVhW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:37:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40511 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCGVhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 16:37:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id f11so1723451qti.7
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 13:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=QaYf4njPKYtJrc8Zr1cNLw2v0aY4HTW+7R7KVcwn/Zs=;
        b=lWXsI3oYYGXBXlCYzW8TUUqa9ktPkXWJGrqjm3yMyOp/8epdAq8cOkaszlkUlO4TfA
         8J8UgxxutJRvi8xV2hdtTz1LT66T+xHhpG7iR3OhOqd4V40VsxisYugegMAtCfKd7cns
         lrMw88Imje4TKfGvKQ8gnQL8RUX7f7sY218zBSpLHBCy0LBGmWbk4Go9WZYp4sex3d/x
         J/opl8o/wB/ULtmavDsxXJvZGRiuDGfPACaV9KRVQ5oDZAoIwfMnTkuZIdW7wDHyQgbB
         CpeA+8EIAemvKelCxzQ3dXOJ4y9SZOkuHem84eGDweLc7SNEUudIIRQ+YVohW4HQH/ym
         LDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=QaYf4njPKYtJrc8Zr1cNLw2v0aY4HTW+7R7KVcwn/Zs=;
        b=ErDWG/24TfLc5R5o4XJGunlinebpsFkIEZ/exaNtVikffO3GTyfVyJ3YW+WgUuWEkz
         M+YfKnMpoE22Thd5Y2BvPB2RqXw9b02dt32XTH4kCdnlYi7JPoynTETf1XDKCaDM5gxr
         dUWhzHb1g9ve0fjUinLr3gecXSrdv0cnzfW3Hg3opGJvYiHOXDI/74Rjjihj2lU3MkZV
         X9Hbl+QNNhVFmglhG9HC8tqe4GMej5aqIXj4PtkrF6Ovt1THQ6osCyPh0IGNGr9SWBEO
         Axa7zB8ubMzfr5yKdm7U24TIahI76W32U9gCfvsqQVrz1oD9kplWpkt1UZ1Fnaeo/ftx
         kCxA==
X-Gm-Message-State: APjAAAWAhg5tRcNk2Ym+xhisUa7voIPLBHyQJtlzNBK/Q0wttzlNvUCo
        1JhmLdTdGD4D17PckQYyUJMrCg==
X-Google-Smtp-Source: APXvYqwc1lh9WygeljHpqCqnPcIHaFYN2T8d9CCBkA7m71qGdkoji0QETniVwWH0vXo1Uqsut6/2yA==
X-Received: by 2002:ac8:4418:: with SMTP id j24mr538297qtn.197.1551994640915;
        Thu, 07 Mar 2019 13:37:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z126sm3953180qkz.8.2019.03.07.13.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 13:37:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH] block: init flush rq ref count to 1
Date:   Thu,  7 Mar 2019 16:37:18 -0500
Message-Id: <20190307213718.28017-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We discovered a problem in newer kernels where a disconnect of a NBD
device while the flush request was pending would result in a hang.  This
is because the blk mq timeout handler does

        if (!refcount_inc_not_zero(&rq->ref))
                return true;

to determine if it's ok to run the timeout handler for the request.
Flush_rq's don't have a ref count set, so we'd skip running the timeout
handler for this request and it would just sit there in limbo forever.

Fix this by always setting the refcount of any request going through
blk_init_rq() to 1.  I tested this with a nbd-server that dropped flush
requests to verify that it hung, and then tested with this patch to
verify I got the timeout as expected and the error handling kicked in.
Thanks,

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6b78ec56a4f2..6107b27c14fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,6 +116,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
+	refcount_set(&rq->ref, 1);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
-- 
2.14.3

