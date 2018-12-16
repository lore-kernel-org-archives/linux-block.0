Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FBC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5869A2084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeLPCZr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeLPCZr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 21:25:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 889FC81DF1;
        Sun, 16 Dec 2018 02:25:47 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2F45C1A1;
        Sun, 16 Dec 2018 02:25:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] nvme-pci: correct mapping for poll queue(s)
Date:   Sun, 16 Dec 2018 10:25:14 +0800
Message-Id: <20181216022517.26650-2-ming.lei@redhat.com>
In-Reply-To: <20181216022517.26650-1-ming.lei@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 16 Dec 2018 02:25:47 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we don't have poll queue, its mapping should share default type's,
instead of setting up one new mapping via blk_mq_map_queues().

blk_mq_map_swqueue() is actually fragile to deal with shared mapping, then
one same ctx can be mapped to two hctxes with same queue type, this
way may cause IO hang easily.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb9d8270f32c..95bd68be2078 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -505,10 +505,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 
 		/*
 		 * The poll queue(s) doesn't have an IRQ (and hence IRQ
-		 * affinity), so use the regular blk-mq cpu mapping
+		 * affinity), so use the regular blk-mq cpu mapping if
+		 * poll queue(s) don't share mapping with TYPE_DEFAULT.
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL)
+		if (i != HCTX_TYPE_POLL || !qoff)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
-- 
2.9.5

