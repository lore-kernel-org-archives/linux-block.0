Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E4C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F8E217F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 16:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfB0QCU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:02:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfB0QCU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 11:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0B16780CE;
        Wed, 27 Feb 2019 16:02:19 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDD1A5D6B6;
        Wed, 27 Feb 2019 16:02:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-block@vger.kernel.org
Subject: [PATCH V2] mmc: align max segment size with logical block size
Date:   Thu, 28 Feb 2019 00:02:11 +0800
Message-Id: <20190227160211.11967-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 27 Feb 2019 16:02:19 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Logical block size is the lowest possible block size that the storage
device can address. Max segment size is often related with controller's
DMA capability. And it is reasonable to align max segment size with
logical block size.

SDHCI sets un-aligned max segment size, and causes ADMA error, so
fix it by aligning max segment size with logical block size.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/mmc/core/block.c | 6 ------
 drivers/mmc/core/queue.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 14f3fdb8c6bb..9ce8eb51a60f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2380,12 +2380,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
 		 "mmcblk%u%s", card->host->index, subname ? subname : "");
 
-	if (mmc_card_mmc(card))
-		blk_queue_logical_block_size(md->queue.queue,
-					     card->ext_csd.data_sector_size);
-	else
-		blk_queue_logical_block_size(md->queue.queue, 512);
-
 	set_capacity(md->disk, size);
 
 	if (mmc_host_cmd23(card->host)) {
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cc19e71c71d4..7c364a9c4eeb 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -355,6 +355,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	u64 limit = BLK_BOUNCE_HIGH;
+	unsigned block_size = 512;
 
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
@@ -368,7 +369,13 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	blk_queue_max_segments(mq->queue, host->max_segs);
-	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
+
+	if (mmc_card_mmc(card))
+		block_size = card->ext_csd.data_sector_size;
+
+	blk_queue_logical_block_size(mq->queue, block_size);
+	blk_queue_max_segment_size(mq->queue,
+			round_down(host->max_seg_size, block_size));
 
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
-- 
2.9.5

