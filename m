Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A2C3DA7A
	for <linux-block@archiver.kernel.org>; Mon,  2 Jan 2023 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjABRjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Jan 2023 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjABRjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Jan 2023 12:39:45 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC289626E
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 09:39:44 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso19112693pjc.2
        for <linux-block@vger.kernel.org>; Mon, 02 Jan 2023 09:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xTLqIpTV5mPi8bTrEds70LhKQ+M/Ia6yMuSdpNsFzo=;
        b=N8bRUjUfFzHbXCmcM1xJGKe4tgZrGfgDxoCs9qU4QLwwTZndz42AaqF940RqhfF9K+
         oLntVqwD0AxUNTCXX/5nDJlGzkCopAYkjItBrEY1FvkvHjpa9fO7XNdX3X9jaC15Ki+q
         3cDq7AqwS64OoMCnLOuA5HiaaZ8JhwAvbeEDMb9NKW7q7N1KedGDBN9LWtJdUvI4bbJC
         59aASE4QT95++SbWCrLRlBDDF/kHxmu16HNKcZwkC4ZxIrSsmhRGPIyukXzDKK+TvgSC
         bgJrNTl1Yp4wh0GW5vtu/i991euMWQf0YrFRCCVZbRyZtDzYl16UyvCJRl91DdwFjOIF
         wzuA==
X-Gm-Message-State: AFqh2krNPTW+/Zpo28zvI16oBZiI5LrV8QRyotZo+9YByomWLfkrpkOM
        qTb1ydHE5MKh+UqutAK0w+8=
X-Google-Smtp-Source: AMrXdXtbCMmgQ0ou05jJLVFPsCgQRbyx8uEjyU8jRrhC2b5AXkmC+8mYqzMzcRSSks/B0VlAFnxqgA==
X-Received: by 2002:a05:6a21:3393:b0:ab:fb31:be13 with SMTP id yy19-20020a056a21339300b000abfb31be13mr89038167pzb.37.1672681183863;
        Mon, 02 Jan 2023 09:39:43 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b00183c6784704sm20304510pln.291.2023.01.02.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 09:39:42 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH] block: Improve shared tag set performance
Date:   Mon,  2 Jan 2023 09:39:26 -0800
Message-Id: <20230102173926.29132-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0
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
 block/blk-mq-debugfs.c |  2 --
 block/blk-mq-tag.c     |  8 --------
 block/blk-mq.c         |  3 ---
 block/blk-mq.h         | 40 ----------------------------------------
 4 files changed, 53 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index bd942341b638..00af8d2c8816 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -426,8 +426,6 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 {
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
-	seq_printf(m, "active_queues=%d\n",
-		   atomic_read(&tags->active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31..e9243cae41c7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -53,8 +53,6 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
-	users = atomic_inc_return(&hctx->tags->active_queues);
-
 	blk_mq_update_wake_batch(hctx->tags, users);
 }
 
@@ -88,8 +86,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	users = atomic_dec_return(&tags->active_queues);
-
 	blk_mq_update_wake_batch(tags, users);
 
 	blk_mq_tag_wakeup_all(tags, false);
@@ -98,10 +94,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
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
index 4a7805390cf8..c570f134850a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1698,9 +1698,6 @@ static bool __blk_mq_alloc_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = &rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
-	} else {
-		if (!hctx_may_queue(rq->mq_hctx, bt))
-			return false;
 	}
 
 	tag = __sbitmap_queue_get(bt);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0b2870839cdd..908f830931f0 100644
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
