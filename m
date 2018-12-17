Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E2C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772B420874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeLQKnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbeLQKnS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 05:43:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92B78B67C;
        Mon, 17 Dec 2018 10:43:18 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 594272719F;
        Mon, 17 Dec 2018 10:43:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/4] blk-mq: fix shared queue mapping
Date:   Mon, 17 Dec 2018 18:42:46 +0800
Message-Id: <20181217104248.5828-3-ming.lei@redhat.com>
In-Reply-To: <20181217104248.5828-1-ming.lei@redhat.com>
References: <20181217104248.5828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 17 Dec 2018 10:43:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Even though poll_queues are zero, nvme's mapping for HCTX_TYPE_POLL still
may be setup via blk_mq_map_queues() which cause different mapping compared
with HCTX_TYPE_DEFAULT's mapping built from managed irq affinity.

This mapping will cause hctx->type to be over-written in blk_mq_map_swqueue(),
then the whole mapping may become broken, for example, one same ctx can be
mapped to different hctxs with same hctx type. This bad mapping has caused
IO hang in simple dd test, as reported by Mike.

This patch sets map->nr_queues as zero explictly if there is zero
queues for such queue type, also maps to correct hctx if .nr_queues of the
queue type is zero.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>

(don't handle zero .nr_queues map in blk_mq_map_swqueue())
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c          |  3 +++
 block/blk-mq.h          | 11 +++++++----
 drivers/nvme/host/pci.c |  6 +-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 313f28b2d079..e843f23843c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2431,6 +2431,9 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		for (j = 0; j < set->nr_maps; j++) {
 			hctx = blk_mq_map_queue_type(q, j, i);
 
+			if (!set->map[j].nr_queues)
+				continue;
+
 			/*
 			 * If the CPU is already set in the mask, then we've
 			 * mapped this one already. This can happen if
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b63a0de8a07a..f50c73d559d7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -105,12 +105,15 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
-	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
-	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
+	if ((flags & REQ_HIPRI) &&
+	    q->tag_set->nr_maps > HCTX_TYPE_POLL &&
+	    q->tag_set->map[HCTX_TYPE_POLL].nr_queues &&
+	    test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		type = HCTX_TYPE_POLL;
 
-	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
-		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
+	else if (((flags & REQ_OP_MASK) == REQ_OP_READ) &&
+	         q->tag_set->nr_maps > HCTX_TYPE_READ &&
+		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
 		type = HCTX_TYPE_READ;
 
 	return blk_mq_map_queue_type(q, type, cpu);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb9d8270f32c..698b350b38cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -496,11 +496,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		map->nr_queues = dev->io_queues[i];
 		if (!map->nr_queues) {
 			BUG_ON(i == HCTX_TYPE_DEFAULT);
-
-			/* shared set, resuse read set parameters */
-			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
-			qoff = 0;
-			offset = queue_irq_offset(dev);
+			continue;
 		}
 
 		/*
-- 
2.9.5

