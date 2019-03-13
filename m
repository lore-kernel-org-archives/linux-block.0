Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED04C10F03
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804722077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hR2q5LH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCMR4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMR4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rQvOwbrOSa579QqBt4y93cUwNAawWZxVB0UIgI1QPkg=; b=hR2q5LH3npX1nER5nhaFCCnoWD
        XO28dqcI+SdO61KKr4bWojozDtGSUPW2Idig1/sfowtqLZbpZXG++L72Kg1XrUa72NAv6SP+yAsR5
        PKQs/KbReH+9whoM5x8sBnIHSUbQfB50pKNMTumLCTTz/KZPaFnDuhYFQTXe2K1daHKDa8oLsKfSV
        hlvkgprzlomyG9Yns3hZSJlaxLlMRQAkH+Vs88BbVtkHoac5xfjO5q5mCf7bUtbsxQbyfKLIBhsfI
        wiSUs5aa+M97iqDRSyCNMESKSfVdQt7Z+4dpyZxSVmwwBdVPYPPtDYBiwcSwgp60QM1JqrCiYrTbJ
        BoKG8OMw==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486k-0001zs-Pi; Wed, 13 Mar 2019 17:56:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 14/17] nvme: add proper discard setup for the multipath device
Date:   Wed, 13 Mar 2019 18:55:07 +0100
Message-Id: <20190313175510.20725-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a gendisk argument to nvme_config_discard so that the call to
nvme_update_disk_info for the multipath device node updates the
proper request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26ae805fc958..6a57ece7d76b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1495,10 +1495,10 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct request_queue *queue = ns->queue;
+	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
 	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
@@ -1606,7 +1606,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	set_capacity(disk, capacity);
 
-	nvme_config_discard(ns);
+	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(ns);
 
 	if (id->nsattr & (1 << 0))
-- 
2.20.1

