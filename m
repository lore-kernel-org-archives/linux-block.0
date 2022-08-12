Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF64C00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiHLVEI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiHLVEH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:04:07 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE181B4409
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:04:06 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id l64so1770863pge.0
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YQUAQSldISzLju8OPJYICJ9P0f9R1O3rjBo81hH5czw=;
        b=df2Fsi3di4JBaNzYZUroa/y3DCMqrwghadeVuyHRSxr3Df+9WeiKxfMAOcpUb4I8Xb
         Fzw+o5FlkJ7XN7m/e1k3d9A5ILywNmD21CvKKYuHqtM9v9oyEcValdHP5qo2VBmwMjf0
         L2BKPqcT+vhmvvdhNVlvQcRWg+wKXALnpSBaarPadn7ir8L8t97rX4jvEfc5EuQT+VXe
         g/FXTwspW5kefs38L9YoIMTt4TU+Vbbp7xQJOeo2Okt3zMXoVnoYirnsKPlTpumutvmZ
         xMDXpd+4qo0JhKloq9/pkpyR6ehAdahEV7HAwO1YeOPYfVP6WCbsJ0cfmULx7RI5aacI
         7B9w==
X-Gm-Message-State: ACgBeo3vvXLqIKagTNn7zRvYACVhyATRG5dk96pOCaJEirH47NT0J2Tx
        CB8m+0WtVTTjdmqRRxJgjMg=
X-Google-Smtp-Source: AA6agR4O43acsIjRbpOSwGqB0CsnPrfj71ichTIuphffrq+e/6LSbEx6WYUaNdhuOXevI66WnpJAeQ==
X-Received: by 2002:a63:8143:0:b0:41c:fc6f:681b with SMTP id t64-20020a638143000000b0041cfc6f681bmr4423388pgd.249.1660338246080;
        Fri, 12 Aug 2022 14:04:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id b72-20020a621b4b000000b0052d3d08cd96sm2049159pfb.67.2022.08.12.14.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:04:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH] block: Submit flush requests to the I/O scheduler
Date:   Fri, 12 Aug 2022 14:03:55 -0700
Message-Id: <20220812210355.2252143-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When submitting a REQ_OP_WRITE | REQ_FUA request to a zoned storage
device, these requests must be passed to the (mq-deadline) I/O scheduler
to ensure that these happen at the write pointer. It has been verfied
that this patch prevents that write pointer violations happen
sporadically when f2fs is using a zoned storage device.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ee62b95f3e5..530aad95cc33 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2546,16 +2546,14 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+static void blk_mq_plug_issue(struct blk_plug *plug, bool from_schedule)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
 	int queued = 0;
-	int errors = 0;
 
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
-		blk_status_t ret;
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
@@ -2563,29 +2561,9 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 			hctx = rq->mq_hctx;
 		}
 
-		ret = blk_mq_request_issue_directly(rq, last);
-		switch (ret) {
-		case BLK_STS_OK:
-			queued++;
-			break;
-		case BLK_STS_RESOURCE:
-		case BLK_STS_DEV_RESOURCE:
-			blk_mq_request_bypass_insert(rq, false, last);
-			blk_mq_commit_rqs(hctx, &queued, from_schedule);
-			return;
-		default:
-			blk_mq_end_request(rq, ret);
-			errors++;
-			break;
-		}
+		blk_mq_sched_insert_request(rq, /*at_head=*/false,
+			/*run_queue=*/last, /*async=*/false);
 	}
-
-	/*
-	 * If we didn't flush the entire list, we could have told the driver
-	 * there was more coming, but that turned out to be a lie.
-	 */
-	if (errors)
-		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
@@ -2655,8 +2633,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 				return;
 		}
 
-		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug, false));
+		blk_mq_run_dispatch_ops(q, blk_mq_plug_issue(plug, false));
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
