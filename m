Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F61C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbiF0Xn4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbiF0Xnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:55 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652818348
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:55 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id cv13so10863432pjb.4
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GzC4O0PTfqt87MREOZLKKGbzlxl9HlHXBQPDVQspuew=;
        b=B8hrHsliov8Isa2nMvXoOBpIYr0axtwXe5Q5xjKvLmpiRbaADeYIqaKKBWAjEixXDX
         hKjRBlm3vc1JI4ZZktbaW91Y6LUZNgebUd7sF26vCkUMc84uiSheBM3pI9ciT3SusjwY
         jqVsY3V82pou/DL4rRdl9kVjv3DlSkTj5HBu1d+13YHdvYQMdyKjbwLPXTJ0o66rsDgI
         cn85Y6wFQXVLSZgl4t1j0+iFoG8HeUzxXU3aetDALKXbvzgc8WWQWXffsQDFCnwa4tF3
         tNMenktJ0EvaZ/cqEmKElWFIF1XUB0OLigyDdvbmr53S8mo42VUpOdGkAqQeHUxE1/Sh
         Mjgw==
X-Gm-Message-State: AJIora9vzINje3UMebkCgnwgSVEMoVp+QBNX3D37+UlS/EmVymBUqpvk
        4apZ99e9u093s5/HNdLRSL0L0pEuuns=
X-Google-Smtp-Source: AGRyM1vjkdj467FkmaLcoGHY6i0/3vmeEhlEhP6ythhqfjQs+aqFBP5DL56hw4b3/jt+gwtq7Ihu1g==
X-Received: by 2002:a17:903:11c9:b0:16b:8293:c599 with SMTP id q9-20020a17090311c900b0016b8293c599mr1966017plh.136.1656373434487;
        Mon, 27 Jun 2022 16:43:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 4/8] block/mq-deadline: Only use zone locking if necessary
Date:   Mon, 27 Jun 2022 16:43:31 -0700
Message-Id: <20220627234335.1714393-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Measurements have shown that limiting the queue depth to one for zoned
writes has a significant negative performance impact on zoned UFS devices.
Hence this patch that disables zone locking from the mq-deadline scheduler
for storage controllers that support pipelining zoned writes. This patch is
based on the following assumptions:
- Applications submit write requests to sequential write required zones
  in order.
- The I/O priority of all pipelined write requests is the same per zone.
- Pipelined zoned write requests are submitted to a single hardware
  queue per zone.
- If such write requests get reordered by the software or hardware queue
  mechanism, nr_requests - 1 retries are sufficient to reorder the write
  requests.
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c   |  3 ++-
 block/mq-deadline.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9da8cf1bb378..63c730a18ac4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -513,7 +513,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
-		if (!args->seq_zones_wlock) {
+		if (!blk_queue_pipeline_zoned_writes(q) &&
+		    !args->seq_zones_wlock) {
 			args->seq_zones_wlock =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
 			if (!args->seq_zones_wlock)
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..aaef07a55984 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -292,7 +292,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -326,7 +327,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
+	    blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -445,8 +447,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -719,6 +722,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
+	bool pipelined_seq_write = blk_queue_pipeline_zoned_writes(q) &&
+		blk_rq_is_seq_zone_write(rq);
 	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
@@ -743,7 +748,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (at_head && !pipelined_seq_write) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
@@ -823,7 +828,8 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (blk_queue_is_zoned(rq->q) &&
+	    !blk_queue_pipeline_zoned_writes(q)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
