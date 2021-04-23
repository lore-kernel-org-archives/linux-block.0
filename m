Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A892DC433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFD6144A
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhDWUBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:01:54 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33752 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhDWUBx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 16:01:53 -0400
Received: by mail-pf1-f180.google.com with SMTP id h11so3725557pfn.0
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 13:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=65ztGkUjmMwJn+e+QOQva4w/D+JwPNVGsneM6eljFAI=;
        b=KP19ek7mhSMJ6sd+7v+yU1CH30z1CaGt9VXCjxMFrGIfbrouHZUIhNvLeSx6Ky2107
         aNvyEdkYMiyTrXj3ohg5THdkU0LIskWskaBtHbWf6QsIwQ6tFPOakvI+2UiLAAfdqrBa
         sd1nAHbitWYdrnSo5O4trKROlOtalMFu11dqfG4VlP0Z1LZOz2ETzesnUDz3QsuMEGTg
         g0FyXTzChNKOBWxG60sWgiTVwfbxURKqInpp1c27GC6o7kVVv8wMdTSjLDIZ1GQPDKoO
         ODl9pSUdmFqSm404JDA9Vvt88kyLkRNvRkeBPSom9UJ4ifYZNs5MxtBI5Zd7dgmqO34S
         c0Iw==
X-Gm-Message-State: AOAM530OmJHgQ52eshwXP4TjxCFm3D7NFEe6QCxihp4cq5v8di6pqpag
        gJfLKEGCzRT4Tkb8ondX9p86qhNOWtU=
X-Google-Smtp-Source: ABdhPJy8cG5EfKGeIZwM6SKIfiPS5CAUi9EKzRv6HJOIx3gj+jeImxckpmmvvu7gkRbbTM3qyO6VRA==
X-Received: by 2002:aa7:88c6:0:b029:250:bf78:a4a3 with SMTP id k6-20020aa788c60000b0290250bf78a4a3mr5270599pff.70.1619208076485;
        Fri, 23 Apr 2021 13:01:16 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:a976:f332:ee26:584f])
        by smtp.gmail.com with ESMTPSA id m7sm5502129pfd.52.2021.04.23.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 13:01:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] blk-mq: Fix two racy hctx->tags->rqs[] assignments
Date:   Fri, 23 Apr 2021 13:01:09 -0700
Message-Id: <20210423200109.18430-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hctx->tags->rqs[] must be cleared before releasing a request tag because
otherwise clearing that pointer races with the following assignment in
blk_mq_get_driver_tag():

	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);

Reported-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 2 +-
 block/blk-mq.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 06d204796c43..1ffaab7c9b11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -501,8 +501,8 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
 	if (rq->tag != BLK_MQ_NO_TAG) {
-		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
+		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	}
 	if (sched_tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ccb1818303b..f73cd659eb81 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -225,8 +225,8 @@ static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
 {
-	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
+	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 	rq->tag = BLK_MQ_NO_TAG;
 
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
