Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5BDC77B6E
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDGX6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDGX6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:45 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2519EFAA
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:44 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1a51ba7fdfcso2139735ad.3
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911924; x=1683503924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u40JsLzOyTXUUB/d1En8vLEh5k2DOI0+hCEG0pu8TkE=;
        b=1W/UoNA6pAVhu8RsLl94a49Tpo5i9C0j6HOQTPTVtowL65oehN9AwPfvHfncaUnMHv
         32HXhC21PVi3XV6cs+6pwZXKcrggyQrFH2HKlj8W2E2pVnK1dJcu6dYGY1suX88j6KyT
         tCI0VAj+4oMsHipz2pxqA+dHGiK+q+QUFFJ9O+P1Q+9mxG2kB20yBCYmAmgma512Ekwf
         LLIZ5dtJerzldj2QMg7F+V1CQcF7q4R2UplO4dicHGyaiR2j/lSLfwmZly5at3n+3Qxj
         pXuzNQkVW2GjvVzWg6ZoV/rNb057RqDRBOsWHyep+UJjinuyR8/Cam67VWBldroOhqfe
         99tA==
X-Gm-Message-State: AAQBX9ekyU822U6g6qCWIX7W9Z59LU77IC5FB2uu2o0weAXJhZBO4alo
        DnLt8NaSou4TyUNO8Mjcp1I=
X-Google-Smtp-Source: AKy350a3EVMx8HjUQax9YOrZ8VyFsA7brvq7XqNPiX0FkrCHLviUiwnOTEyZyflmog7os3VECQTUYw==
X-Received: by 2002:a62:3047:0:b0:626:cc72:51ac with SMTP id w68-20020a623047000000b00626cc7251acmr273212pfw.30.1680911924054;
        Fri, 07 Apr 2023 16:58:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 03/12] block: Send requeued requests to the I/O scheduler
Date:   Fri,  7 Apr 2023 16:58:13 -0700
Message-Id: <20230407235822.1672286-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
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
 block/blk-mq.c         | 21 +++++++++------------
 include/linux/blk-mq.h |  5 +++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 250556546bbf..57315395434b 100644
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
@@ -2065,9 +2057,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
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
+			q->elevator->type->ops.insert_requests(hctx, list,
+							/*at_head=*/true);
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
