Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78441C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 22:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjEPWdh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 18:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEPWde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 18:33:34 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C86E8D
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:33 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so1582265ad.0
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 15:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276413; x=1686868413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wf3oFXc53dbL2Y9+RB2yCOp47YOiZf0uoEqAZxnr7V8=;
        b=ByQB6PrURpAQntaxL8ZEHsQG8pFzHgoV1TPftC5jc04TxWRjWGSzfYyCX/fTH/J6aU
         Arvc50E50gSeYkTCPHE8DOcx2z8BXYWSlA1Qqc3BuwRk9fvrr+s3CPCsQkpTYWh+2VYz
         g6H7+NCJS0p0SI39UfmsfZ1SS1aNLhXqUM3086G40Chm9f4jTh1q3xIhj4qPc63HSpDj
         fxdc8V/LrxkqEyxIy5RLAbBbjjRoSwHgi7TNGd1TD2mdXwwl6ZPKkXQ4Cz43mws2XZoR
         I3NVPY8hos2hiVXdic+L60p2RRWHJKXddj+sEdwkpIHNEnhB83KNc4n29gkeLVr4yP7X
         lv7A==
X-Gm-Message-State: AC+VfDxNBi23C3QUYlLHfnzwHOGB6b6/SJDwOLUSeHEyKudm56xmUzww
        SsW9LQWEiWN/t96Wd9znAl7//2sdpBI=
X-Google-Smtp-Source: ACHHUZ4qNFr8s5Y62l/pbKEEd33s2TYuDs0oI+SaHZdUc53nNOIotNZsMfeVe9nyDqu+Q+Aa8JjZCQ==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id l18-20020a170903245200b001adbc860851mr29891266pls.45.1684276412959;
        Tue, 16 May 2023 15:33:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:baed:ee38:35e4:f97d])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001ae48d441desm839255pln.148.2023.05.16.15.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:33:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 04/11] block: Introduce blk_rq_is_seq_zoned_write()
Date:   Tue, 16 May 2023 15:33:13 -0700
Message-ID: <20230516223323.1383342-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230516223323.1383342-1-bvanassche@acm.org>
References: <20230516223323.1383342-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the function blk_rq_is_seq_zoned_write(). This function will
be used in later patches to preserve the order of zoned writes that
require write serialization.

This patch includes an optimization: instead of using
rq->q->disk->part0->bd_queue to check whether or not the queue is
associated with a zoned block device, use rq->q->disk->queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      |  5 +----
 include/linux/blk-mq.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 835d9e937d4d..096b6b47561f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -60,10 +60,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
-	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
-		return blk_rq_zone_is_seq(rq);
-
-	return false;
+	return blk_rq_is_seq_zoned_write(rq);
 }
 EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed6..301d72f85486 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1164,6 +1164,17 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
 	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
 }
 
+/**
+ * blk_rq_is_seq_zoned_write() - Check if @rq requires write serialization.
+ * @rq: Request to examine.
+ *
+ * Note: REQ_OP_ZONE_APPEND requests do not require serialization.
+ */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	return op_is_zoned_write(req_op(rq)) && blk_rq_zone_is_seq(rq);
+}
+
 bool blk_req_needs_zone_write_lock(struct request *rq);
 bool blk_req_zone_write_trylock(struct request *rq);
 void __blk_req_zone_write_lock(struct request *rq);
@@ -1194,6 +1205,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
 	return !blk_req_zone_is_write_locked(rq);
 }
 #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
+{
+	return false;
+}
+
 static inline bool blk_req_needs_zone_write_lock(struct request *rq)
 {
 	return false;
