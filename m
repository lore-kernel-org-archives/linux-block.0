Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7819AC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B46C2077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+kWSQQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCMR4K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMR4K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/LWPabjyVlxDe+VxUON9609Sqi2++5RXgoJDxbeLRsI=; b=Q+kWSQQGKNeY/CDbZPmFjOX8y0
        qtQVv6evfxRz/wPihb0neGNo/p6GY9dPZKHEHl9aGC4G1VbIsWhoG3twWDy6hh7wAmbcTpshOB7/Z
        jz2yw/R+TmqyAf+5qI+VWHYSMAAbEBTCOWgcD6a4Ow+3e7ADULSBg9MPsFcKOG7ajarTh1SzpgkeE
        pm3NH1hq7iNaZxUt2Lfump2d5Ebl1OB5ynt/tsAgp264Vqp8hoN9vnuxHglyEFKwuT3PLAyrybSRN
        1BJSkOKJKhmoRIf7H8U1srgkzudgDWb6aaizhGiAd0OWoDTuKx2Ele5DH5iAARX54SyPEEmDYvtlV
        cUEGmwWA==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486n-00023u-KU; Wed, 13 Mar 2019 17:56:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 15/17] nvme: add proper write zeroes setup for the multipath device
Date:   Wed, 13 Mar 2019 18:55:08 +0100
Message-Id: <20190313175510.20725-16-hch@lst.de>
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

Add a gendisk argument to nvme_config_write_zeroes so that the call to
nvme_update_disk_info for the multipath device node updates the
proper request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Tested-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a57ece7d76b..470601980794 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1526,7 +1526,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
+static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
 	u32 max_sectors;
 	unsigned short bs = 1 << ns->lba_shift;
@@ -1549,7 +1549,7 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	else
 		max_sectors = ((u32)(ns->ctrl->max_hw_sectors + 1) * bs) >> 9;
 
-	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
+	blk_queue_max_write_zeroes_sectors(disk->queue, max_sectors);
 }
 
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1607,7 +1607,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(ns);
+	nvme_config_write_zeroes(disk, ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.20.1

