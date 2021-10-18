Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C35C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF02E61077
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhJRRx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhJRRxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86020C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n7so17352427iod.0
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRo+0Nv/5yTlZsp5PnfL7gTFHW11KoE6fwo/PS73/zs=;
        b=HibWV3m6ESAwvkPj/RgK2oFibmOMs4F+q8KgbZuCmfRM7+N90UfAl1fKB2GM3Ozoti
         8SaoUU4Zu/fX1H6rx1SaU07DHlgriZhlwvAbue/vI6n3YRS59Npn805l5Y+Tg2iCIXSc
         ewK7rnPD1lE0vFS5SWxaWRXWjYwhubPynpl6MXYbQWSDzgPTBesEy5FRsEeh7Lr5OOfE
         JmUYZweea6o0fj/HFR0HYOOn9/g4XzcMkkGSTQu25a4WjYWAD0mjiPNrEspVQp018IL6
         /gjU13HJqFl+L3GnA6agb35/RHBBrbZ5H4KpG+K3rGJw7YFL3n7cI90X8PwOa5CFtZxe
         AQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRo+0Nv/5yTlZsp5PnfL7gTFHW11KoE6fwo/PS73/zs=;
        b=5UbiN2HI9e9Ra6jpWywhFvPtxUoaB5WLfGMiK4DkvKjyb1rgy/rbXZHru3AQ9BMPkC
         Rm9VH889MyuRnYoiWCuDv9J/fEOGGxiTNzPjhcdLHXY0eGJMTzLxaEtuwYR4sCmdRWxk
         LGfKoDVejWtzfX+zkUm7sT9SekIfkHsqrUNECYJ9GB/kRWND2cXI0najqcSJeqTghcH+
         Cd1vIo/Q2dfPfrLB3sEzee0fqmrzSYtWxbbyXyMAtC215iFB8jLlLKixSU2BwugNgtBl
         KaVJRVoQKTXRsh4BZNjGTngJmwQqWpa/Wxk9lEkq3wPmlXEtfd0Zx10cgAXUDAWVuG6z
         KLVg==
X-Gm-Message-State: AOAM532R9INSxu9QTQVPlmtHppSOoMRUJYSQSRDfQIsetuAyb3PQzXWH
        MZRH8X9GclvKV4d+yTZei5crKWsKri50CQ==
X-Google-Smtp-Source: ABdhPJxI8vnh38YET74M68PBh5L1tmD3cm+0adazAppsZChoHR/6+JLC7i90tCJP1cK/DMx+jwdGfw==
X-Received: by 2002:a05:6602:2f0a:: with SMTP id q10mr15759272iow.76.1634579473787;
        Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] block: get rid of plug list sorting
Date:   Mon, 18 Oct 2021 11:51:06 -0600
Message-Id: <20211018175109.401292-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even if we have multiple queues in the plug list, chances that they
are very interspersed is minimal. Don't bother spending CPU cycles
sorting the list.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d957b6812a98..58774267dd95 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -19,7 +19,6 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/llist.h>
-#include <linux/list_sort.h>
 #include <linux/cpu.h>
 #include <linux/cache.h>
 #include <linux/sched/sysctl.h>
@@ -2151,20 +2150,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	spin_unlock(&ctx->lock);
 }
 
-static int plug_rq_cmp(void *priv, const struct list_head *a,
-		       const struct list_head *b)
-{
-	struct request *rqa = container_of(a, struct request, queuelist);
-	struct request *rqb = container_of(b, struct request, queuelist);
-
-	if (rqa->mq_ctx != rqb->mq_ctx)
-		return rqa->mq_ctx > rqb->mq_ctx;
-	if (rqa->mq_hctx != rqb->mq_hctx)
-		return rqa->mq_hctx > rqb->mq_hctx;
-
-	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
-}
-
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
 	LIST_HEAD(list);
@@ -2172,10 +2157,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	if (list_empty(&plug->mq_list))
 		return;
 	list_splice_init(&plug->mq_list, &list);
-
-	if (plug->rq_count > 2 && plug->multiple_queues)
-		list_sort(NULL, &list, plug_rq_cmp);
-
 	plug->rq_count = 0;
 
 	do {
-- 
2.33.1

