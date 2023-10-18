Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3434CCDB484
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjJRSBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJRSBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 14:01:11 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848C4124
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 11:01:08 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6be840283ceso1662724b3a.3
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 11:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652068; x=1698256868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRaL2PKynQQ41b+XasnGZIvmBGl1jMeCoUNljfhbZ/g=;
        b=sW/tBQj1WzKRB9gDkOyxIq53eefJXRcVTorKWyB09pDkG+iZt80HESdE8z2tHG+zCy
         mX/wquZIX5cGeNlvhYYkC2Zpo4WJoYC3Z2uS38LhOIwHMTAl3EOlqYMFlhJEesInjdo4
         pegBWbF/qQg7aehghE098K9NEWjDE39G17rU2hmpXyJfHCARQTqSU30OUW9DUMI5AAIx
         HTLLJJP4gmT8eD0FKG2lkeCUcSSK4ngr86E9QQlbtY+kGSdmXpXhyYQImMRVtoqihggc
         B6579333O+ixNDlFQPS1G6JqPbaV4i7wMoDJfWFZmA8QgkXDn4CboQyLNw3SgNB6jcLE
         XJiA==
X-Gm-Message-State: AOJu0YwCV/f1PzYtxPuw6YQljvo8Cg8j4M88Y+iL8e2U3HLoawAe8R3i
        Xh/sK0sjBZL3OiFA5Lj/Tjw=
X-Google-Smtp-Source: AGHT+IHf7LiqNK/cq7NpOYJHnU3xlTkWVtS8ROdYsEXTRB0+VrCLDBMVia/w6uNNOiHc9r7dxbj/fw==
X-Received: by 2002:a05:6a00:1a50:b0:68f:dd50:aef8 with SMTP id h16-20020a056a001a5000b0068fdd50aef8mr6268140pfv.4.1697652067679;
        Wed, 18 Oct 2023 11:01:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79414000000b0068fc48fcaa8sm3624698pfo.155.2023.10.18.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:01:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH] block: Improve shared tag set performance
Date:   Wed, 18 Oct 2023 11:00:56 -0700
Message-ID: <20231018180056.2151711-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the code for fair tag sharing because it significantly hurts
performance for UFS devices. Removing this code is safe because the
legacy block layer worked fine without any equivalent fairness
algorithm.

This algorithm hurts performance for UFS devices because UFS devices
have multiple logical units. One of these logical units (WLUN) is used
to submit control commands, e.g. START STOP UNIT. If any request is
submitted to the WLUN, the queue depth is reduced from 31 to 15 or
lower for data LUNs.

See also https://lore.kernel.org/linux-scsi/20221229030645.11558-1-ed.tsai@mediatek.com/

Note: it has been attempted to rework this algorithm. See also "[PATCH
RFC 0/7] blk-mq: improve tag fair sharing"
(https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
Given the complexity of that patch series, I do not expect that patch
series to be merged.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-tag.c |  4 ----
 block/blk-mq.c     |  3 ---
 block/blk-mq.h     | 39 ---------------------------------------
 3 files changed, 46 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..25334bfcabf8 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -105,10 +105,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
-			!hctx_may_queue(data->hctx, bt))
-		return BLK_MQ_NO_TAG;
-
 	if (data->shallow_depth)
 		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..502dafa76716 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1760,9 +1760,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
 
 	tag = __sbitmap_queue_get(bt);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..14a22f6d3fdf 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -407,45 +407,6 @@ static inline void blk_mq_free_requests(struct list_head *list)
 	}
 }
 
-/*
- * For shared tag users, we track the number of currently active users
- * and attempt to provide a fair share of the tag depth for each of them.
- */
-static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
-				  struct sbitmap_queue *bt)
-{
-	unsigned int depth, users;
-
-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
-		return true;
-
-	/*
-	 * Don't try dividing an ant
-	 */
-	if (bt->sb.depth == 1)
-		return true;
-
-	if (blk_mq_is_shared_tags(hctx->flags)) {
-		struct request_queue *q = hctx->queue;
-
-		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
-			return true;
-	} else {
-		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
-			return true;
-	}
-
-	users = READ_ONCE(hctx->tags->active_queues);
-	if (!users)
-		return true;
-
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return __blk_mq_active_requests(hctx) < depth;
-}
-
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
