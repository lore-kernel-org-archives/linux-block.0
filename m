Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CA9C3DA7D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjACTxp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjACTxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 14:53:44 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4582AE7
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 11:53:43 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso36873567pjp.4
        for <linux-block@vger.kernel.org>; Tue, 03 Jan 2023 11:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BHvEwsIUDSOXL2nRTGcof7iVUQxFIYiSWpUHM5vlow=;
        b=NoRXDtSVKOzvaeQ3NpPgasubbrVZzqrD4QcQCNRuCkjvLISG4/vJiTbfrDuxJOpLP5
         EDh//HeTZwtfHIlA9/A5kwHC7LOzTdylV2uCRITSddfNBq9oWUfcUxyv4s4diW8xFKrs
         UyzqRRhiMHhFXXY0vqx735IX2FgDQhL+29DJIn6LII474LXp73inBPZPtF547sDX7xRE
         /69iFw8gjq02AMBOj28Pg77IH77rKP0Qz5RzevyTdsoupuL0cjv2wdr/QYfYtLvu3upT
         ju1d4aDA0SdIs9qFtOE3SSFgHd/XaWl3zdjJvP7Z/eH0vUOz0L7Yun8SbZI3W0TBovrJ
         Odcw==
X-Gm-Message-State: AFqh2kpGn5lhUN+LSoSuINi4JG2I7omHSld0CQiLGEok1h4OXFsrba5s
        AXiCSJArYwVicZCNuFDE7KE=
X-Google-Smtp-Source: AMrXdXstVx/CBPUkhzaKMLNmyCF5E812qTjwEFwzQ1p89WOB6HSKSRyCJuhc5WOARIblx3/XsWIEbw==
X-Received: by 2002:a17:902:8c8b:b0:189:c536:c745 with SMTP id t11-20020a1709028c8b00b00189c536c745mr48931208plo.2.1672775622595;
        Tue, 03 Jan 2023 11:53:42 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:7da8:fef9:8c31:bf89])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172fad607b3sm22673667plf.207.2023.01.03.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 11:53:41 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v2] block: Improve shared tag set performance
Date:   Tue,  3 Jan 2023 11:53:37 -0800
Message-Id: <20230103195337.158625-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
Changes compared to v1: restored the tags->active_queues variable and thereby
  fixed the "uninitialized variable" warning reported by the kernel test robot.

 block/blk-mq-tag.c |  4 ----
 block/blk-mq.c     |  3 ---
 block/blk-mq.h     | 40 ----------------------------------------
 3 files changed, 47 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31..20d37d98ccb9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -98,10 +98,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
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
index c5cf0dbca1db..d0e07d83c23d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1768,9 +1768,6 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
 
 	tag = __sbitmap_queue_get(bt);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ef59fee62780..7b27d1d1bf51 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -334,46 +334,6 @@ static inline void blk_mq_free_requests(struct list_head *list)
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
-	users = atomic_read(&hctx->tags->active_queues);
-
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
