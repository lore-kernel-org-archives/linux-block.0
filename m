Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6982C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C104D2087B
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeLPC0F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeLPC0F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 21:26:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1569D3695F;
        Sun, 16 Dec 2018 02:26:05 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F39B819C7C;
        Sun, 16 Dec 2018 02:25:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] blk-mq: deal with shared queue mapping reliably
Date:   Sun, 16 Dec 2018 10:25:16 +0800
Message-Id: <20181216022517.26650-4-ming.lei@redhat.com>
In-Reply-To: <20181216022517.26650-1-ming.lei@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 16 Dec 2018 02:26:05 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch sets map->nr_queues as zero explictly if there is zero
queues for such queue type, then blk_mq_map_swqueue() can become
more robust to deal with shared mappings.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c          |  3 +++
 drivers/nvme/host/pci.c | 37 ++++++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a4a0895dae65..a737d912c46b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2435,6 +2435,9 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		for (j = 0; j < set->nr_maps; j++) {
 			hctx = blk_mq_map_queue_type(q, j, i);
 
+			if (!set->map[j].nr_queues)
+					continue;
+
 			/*
 			 * If the CPU is already set in the mask, then we've
 			 * mapped this one already. This can happen if
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 95bd68be2078..43074c54279e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -492,29 +492,32 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	offset = queue_irq_offset(dev);
 	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &set->map[i];
+		unsigned nr_queues;
 
-		map->nr_queues = dev->io_queues[i];
-		if (!map->nr_queues) {
+		nr_queues = map->nr_queues = dev->io_queues[i];
+		if (!nr_queues) {
 			BUG_ON(i == HCTX_TYPE_DEFAULT);
 
-			/* shared set, resuse read set parameters */
-			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
+			/* shared set, resuse default set parameters and table */
+			nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
 			qoff = 0;
 			offset = queue_irq_offset(dev);
-		}
 
-		/*
-		 * The poll queue(s) doesn't have an IRQ (and hence IRQ
-		 * affinity), so use the regular blk-mq cpu mapping if
-		 * poll queue(s) don't share mapping with TYPE_DEFAULT.
-		 */
-		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL || !qoff)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
-		else
-			blk_mq_map_queues(map);
-		qoff += map->nr_queues;
-		offset += map->nr_queues;
+			memcpy(map->mq_map, set->map[HCTX_TYPE_DEFAULT].mq_map,
+				   nr_cpu_ids * sizeof(map->mq_map[0]));
+		} else {
+			/*
+			 * The poll queue(s) doesn't have an IRQ (and hence IRQ
+			 * affinity), so use the regular blk-mq cpu mapping.
+			 */
+			map->queue_offset = qoff;
+			if (i != HCTX_TYPE_POLL)
+				blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+			else
+				blk_mq_map_queues(map);
+		}
+		qoff += nr_queues;
+		offset += nr_queues;
 	}
 
 	return 0;
-- 
2.9.5

