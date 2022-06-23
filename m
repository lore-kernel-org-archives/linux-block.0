Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935DAC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiFWX0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:17 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858452E67
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:16 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id o18so590793plg.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jp/dOxiOcqQO4HcTlE71wKaOLAfvCjPmT9GXQdly+2Q=;
        b=xm00QsFkvB6vjJJl6MGrNcLHEqCrW2uITIw5IpIdTvhgP6Fkb7zEH/9UgcVnduAwU6
         91+/tiikD89Xt+L41uiaxqFP1DGJUEacSU77QptxhRv0KBVgF+lQv04UmiEOFf2/dDHA
         h5cITUZ4zs2rAYV4UIoI5RhjHNoHuNPbqLEN8o1PACmJ+EjV0CpCNCjwHPO81rExOKa+
         VCrYoGmqn1Ay5eDBPU5OM8yr6MJfgUs6lWv5QPdnKHeq4YYZFc7FlDsZSuqubQkc8DLv
         NX4sGlMccOJLn4oGqTE7frtTDnmes0eaoM/eUjuB3eWkJy/r3a8EmPQXw/cFUY0Cvabg
         DC6g==
X-Gm-Message-State: AJIora+ZhfblPx6VAd4EjgXvPHDskMyT5QVxPhmB1BxgRl3T29E1r49d
        OeAosUMftOzHI0QTt9Y5bvg=
X-Google-Smtp-Source: AGRyM1sATxq+5jIPmAtmmvP9EGcpVR5NPDWtUK/sXh6V7SXZ9D/99W0KpHRETXqQMrYNpHXnzq7ITw==
X-Received: by 2002:a17:90a:9cd:b0:1ec:7258:d01b with SMTP id 71-20020a17090a09cd00b001ec7258d01bmr453821pjo.244.1656026775847;
        Thu, 23 Jun 2022 16:26:15 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 4/6] block/mq-deadline: Only use zone locking if necessary
Date:   Thu, 23 Jun 2022 16:26:01 -0700
Message-Id: <20220623232603.3751912-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
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
- If such write requests get reordered by the software or hardware queue
  mechanism, nr_hw_queues * nr_requests - 1 retries are sufficient to
  reorder the write requests.
- It happens infrequently that zoned write requests are reordered by the
  block layer.
- Either no I/O scheduler is used or an I/O scheduler is used that
  submits write requests per zone in LBA order.

See also commit 5700f69178e9 ("mq-deadline: Introduce zone locking
support").

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c   |  3 ++-
 block/mq-deadline.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index cafcbc508dfb..88a0610ba0c3 100644
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
index 1a9e835e816c..8ab9694c8f3a 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -292,7 +292,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		return NULL;
 
 	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -326,7 +326,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	if (!rq)
 		return NULL;
 
-	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
+	if (data_dir == DD_READ || blk_queue_pipeline_zoned_writes(rq->q))
 		return rq;
 
 	/*
@@ -445,8 +445,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
@@ -719,6 +720,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
 	enum dd_prio prio;
+	bool pipelined_seq_write = blk_queue_pipeline_zoned_writes(q) &&
+		blk_rq_is_zoned_seq_write(rq);
 	LIST_HEAD(free);
 
 	lockdep_assert_held(&dd->lock);
@@ -743,7 +746,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	trace_block_rq_insert(rq);
 
-	if (at_head) {
+	if (at_head && !pipelined_seq_write) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
 		rq->fifo_time = jiffies;
 	} else {
@@ -823,7 +826,7 @@ static void dd_finish_request(struct request *rq)
 
 	atomic_inc(&per_prio->stats.completed);
 
-	if (blk_queue_is_zoned(q)) {
+	if (!blk_queue_pipeline_zoned_writes(q)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&dd->zone_lock, flags);
