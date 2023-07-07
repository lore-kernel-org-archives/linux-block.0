Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC4EB64DA
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGGJqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjGGJqk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:46:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8022108
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K4bMg5yZliyiqY8nRi1CjsjKBI5RC4P8/ENNcWprmTg=; b=qWgEq9tE4rPqm3loJHWgH8ZDW2
        YxsCmOca6jtyU19TzYzTnGbOI6Q8SB/qj9LyFh0DrPVmL7xNFIxVxzcIV7/Y/Yf4jmVQmbVqGzGOf
        KpV03wS2Xf1E0QhZxUBTNJar3uy2Vwu9/66CXKkwJC9OTtVsSvxyY1og7Y+/2pYNnA85YibpI58t6
        p/HFzV4V7F3GIR5f9tGCBCod87kj6tH04A65Mh5vHBtyjBTF6ErDrd4FVVHWqAUvzS3LYoTK3OVO/
        PRL8xG64HHmMiPXqgR89h+DWK57VSkfgI67tqcYj+701GroWYFTWBBoBvA/NlXO+4lUkyNHXMaaJc
        Y5X1n56g==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHi2v-0049j3-1f;
        Fri, 07 Jul 2023 09:46:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Date:   Fri,  7 Jul 2023 11:46:15 +0200
Message-Id: <20230707094616.108430-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094616.108430-1-hch@lst.de>
References: <20230707094616.108430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ctrl->max_discard_sectors stores a value that is potentially based of
the DMRSL field in Identify Controller, which is in units of LBAs and
thus dependent on the Format of a namespace.

Fix this by moving the calculation of max_discard_sectors entirely
into nvme_config_discard and replacing the ctrl->max_discard_sectors
value with a local variable so that the calculation is always
namespace-specific.

Fixes: 1a86924e4f46 ("nvme: fix interpretation of DMRSL")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2d6c1f4ad7f5c8..05372bec3b7aff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1721,20 +1721,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
-		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
+	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
+			NVME_DSM_MAX_RANGES);
 
-	if (ctrl->max_discard_sectors == 0) {
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX)) {
+		blk_queue_max_discard_sectors(queue,
+				nvme_lba_to_sect(ns, ctrl->dmrsl));
+	} else if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
+		blk_queue_max_discard_sectors(queue, UINT_MAX);
+	} else {
 		blk_queue_max_discard_sectors(queue, 0);
 		return;
 	}
 
-	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
-			NVME_DSM_MAX_RANGES);
-
 	queue->limits.discard_granularity = size;
 
-	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
 	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
@@ -2870,13 +2871,10 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	struct nvme_id_ctrl_nvm *id;
 	int ret;
 
-	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
-		ctrl->max_discard_sectors = UINT_MAX;
+	if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
 		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
-	} else {
-		ctrl->max_discard_sectors = 0;
+	else
 		ctrl->max_discard_segments = 0;
-	}
 
 	/*
 	 * Even though NVMe spec explicitly states that MDTS is not applicable
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470afad..d59ed2ba1c37ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -296,7 +296,6 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u32 max_integrity_segments;
-	u32 max_discard_sectors;
 	u32 max_discard_segments;
 	u32 max_zeroes_sectors;
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.39.2

