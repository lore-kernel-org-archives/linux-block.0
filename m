Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA2C0015E
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGZTfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGZTfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:07 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BD2D43
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:05 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-686efdeabaeso137156b3a.3
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400105; x=1691004905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spi0QoOx8xiu22EDvlyX8nDXg1t+SawetU4mZevhtFk=;
        b=VYG9TXj7Awes2O8G7wdYPU56BQhlnh1LtLs6PjL3f2DIkxWIpEQnyPkhavL3K7At9I
         QO2W4/hNUVZiwR5QeGwsDHPh7yQKDef7BnjOBjQ3/Qn8ISP48tSMgtWxstzAxng6Ko1G
         A+LoPtRE5CQxQhal5kcRquuuW2pRAZbPr/+3EszIxP+q/XYLq0ADo5LJhf6Gk20GEdl0
         Z/XvkPxWNOGR6FB86NaIhc3x6ICC1IbAIRXrqaXhVltU6mgnvjsvNEM9tJwtyB9vBQwN
         UP4bIvSz28JcRIn31mPA18cX2tGFMN3lLg2V/9hpMgLuzHctg4aEA4SJfH4oa1ZV/yco
         T2IA==
X-Gm-Message-State: ABy/qLaaU5udA0nfQBPs2v6ctRPctbksO3ai8UXxWIjZfH4SM9qtcyg9
        0RL4HMDHhJnH4oTgIywEgfQ=
X-Google-Smtp-Source: APBJJlEMDh1KZg3grPe1Zdftvn5YnV5i/pG6YClz0QeU5WruwdXSJEDm+ZRXS/k/Pap1UZ/83u5p/A==
X-Received: by 2002:a05:6a00:181e:b0:686:9385:4644 with SMTP id y30-20020a056a00181e00b0068693854644mr3454388pfa.2.1690400105218;
        Wed, 26 Jul 2023 12:35:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 3/7] block/mq-deadline: Only use zone locking if necessary
Date:   Wed, 26 Jul 2023 12:34:07 -0700
Message-ID: <20230726193440.1655149-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726193440.1655149-1-bvanassche@acm.org>
References: <20230726193440.1655149-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one for zoned
writes has a significant negative performance impact on zoned UFS devices.
Hence this patch that disables zone locking by the mq-deadline scheduler
if zoned writes are submitted in order and if the storage controller
preserves the command order. This patch is based on the following
assumptions:
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- The I/O priority of all write requests is the same per zone.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..9a64577fe942 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -338,6 +338,17 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	return rq;
 }
 
+/*
+ * Use write locking if either QUEUE_FLAG_NO_ZONE_WRITE_LOCK or
+ * REQ_NO_ZONE_WRITE_LOCK has not been set. Not using zone write locking is
+ * only safe if the submitter allocates and submit requests in LBA order per
+ * zone and if the block driver preserves the request order.
+ */
+static bool dd_use_write_locking(struct request *rq)
+{
+	return blk_queue_is_zoned(rq->q) && !blk_no_zone_write_lock(rq);
+}
+
 /*
  * For the specified data direction, return the next request to
  * dispatch using arrival ordered lists.
@@ -353,7 +364,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !dd_use_write_locking(rq))
 		return rq;
 
 	/*
@@ -398,7 +409,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !dd_use_write_locking(rq))
 		return rq;
 
 	/*
@@ -526,8 +537,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	}
 
 	/*
-	 * For a zoned block device, if we only have writes queued and none of
-	 * them can be dispatched, rq will be NULL.
+	 * For a zoned block device that requires write serialization, if we
+	 * only have writes queued and none of them can be dispatched, rq will
+	 * be NULL.
 	 */
 	if (!rq)
 		return NULL;
@@ -552,7 +564,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
 	/*
 	 * If the request needs its target zone locked, do it.
 	 */
-	blk_req_zone_write_lock(rq);
+	if (dd_use_write_locking(rq))
+		blk_req_zone_write_lock(rq);
 	rq->rq_flags |= RQF_STARTED;
 	return rq;
 }
@@ -933,7 +946,7 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (dd_use_write_locking(rq)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
