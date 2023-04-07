Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC9C77B71
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjDGARV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDGARU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 20:17:20 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97138A6E
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 17:17:19 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id ix20so38890028plb.3
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 17:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826639; x=1683418639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMqZoVLH7diA5Sdp1MnvjtadI8hHVn6QGoRCcrnE5Pg=;
        b=cslK2ouNSRqBMh8rXgVaon8P6fL53F76ml1qYGIKBXA8/D19PQ229jLroB3SykguYz
         51IXD+geQo8aX+wxLFMH7uFXqQvCI7XLdKA1lDJVGSFjo3ED0wMCMrk2r3Hyx0CUE6gs
         C4BvYfzcBCOOQAZ53lT/O8GUoYjmWIcPEKSn7yLE9umaS2zGY8qgg8Kht8TWIjHtzTmY
         tWgKLfmDUl5QrzmgTenMNMfwYDFA5D+MNyLDYTw5OHFQIzCrIA6dgudYTr0pa//yhife
         PJz4QcG+w1KAXiC+B08iW/qot6Ok4ez1q77ouTmbyV7pvJ/hbaek5cM77+M2M3dFesrg
         m/LA==
X-Gm-Message-State: AAQBX9dqhYpYNgCFSHDRLcSBOcllhmvt6wEp49j70+KsYHH5sVAGSZmq
        PovShVmrjS321zfJv71zgKyp/VcGflE=
X-Google-Smtp-Source: AKy350YCeKZvjmze6EHftvlPUww03iQTSCleXC/Hhn6iPVXinzvNGCU6HSS6Q9I/DrFzbCOscCp+XA==
X-Received: by 2002:a17:902:c94d:b0:1a0:53b3:ee87 with SMTP id i13-20020a170902c94d00b001a053b3ee87mr1029512pla.62.1680826639181;
        Thu, 06 Apr 2023 17:17:19 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709028ec900b0019a773419a6sm1873676plo.170.2023.04.06.17.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:17:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/12] block: Send requeued requests to the I/O scheduler
Date:   Thu,  6 Apr 2023 17:17:01 -0700
Message-Id: <20230407001710.104169-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407001710.104169-1-bvanassche@acm.org>
References: <20230407001710.104169-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let the I/O scheduler control which requests are dispatched.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 22 ++++++++++------------
 include/linux/blk-mq.h |  5 +++--
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 250556546bbf..f6ffa76bc159 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1426,15 +1426,7 @@ static void blk_mq_requeue_work(struct work_struct *work)
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		/*
-		 * If RQF_DONTPREP, rq has contained some driver specific
-		 * data, so insert it to hctx dispatch list to avoid any
-		 * merge.
-		 */
-		if (rq->rq_flags & RQF_DONTPREP)
-			blk_mq_request_bypass_insert(rq, false, false);
-		else
-			blk_mq_sched_insert_request(rq, true, false, false);
+		blk_mq_sched_insert_request(rq, /*at_head=*/true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
@@ -2065,9 +2057,15 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		if (nr_budgets)
 			blk_mq_release_budgets(q, list);
 
-		spin_lock(&hctx->lock);
-		list_splice_tail_init(list, &hctx->dispatch);
-		spin_unlock(&hctx->lock);
+		if (!q->elevator) {
+			spin_lock(&hctx->lock);
+			list_splice_tail_init(list, &hctx->dispatch);
+			spin_unlock(&hctx->lock);
+		} else {
+			q->elevator->type->ops.insert_requests(
+				hctx, list,
+				/*at_head=*/true);
+		}
 
 		/*
 		 * Order adding requests to hctx->dispatch and checking
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5e6c79ad83d2..3a3bee9085e3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -64,8 +64,9 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_RESV			((__force req_flags_t)(1 << 23))
 
 /* flags that prevent us from merging requests: */
-#define RQF_NOMERGE_FLAGS \
-	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
+#define RQF_NOMERGE_FLAGS                                               \
+	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_DONTPREP | \
+	 RQF_SPECIAL_PAYLOAD)
 
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
