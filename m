Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF928C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449421917
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AELOigRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCUXL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MuNeHJhHP6zs9FYi34jrqpD9S3C95VDJLqEBME273kM=; b=AELOigRNCpvcU1eYW+p15mVVVf
        pBbIabu7JYsc+UlUay09v6LXTRwU2z8P+dq8zKZWxXtaUQpX4umZD5qBo7ly4hhD8fRU7colONUq1
        QZ9Ae3Ay9RTJhiHDDGwRCxeHA3VFc3d6HRKjJyH2Ka2yyaRegOcB9fo5WjD0fU1KYJQGEHaoMixIq
        iq8kn68X3m7gq1d2VorR1brCM987XwEZEe+4fpHOG6zFU8SEq+hw1YFdfz8+bCMDqOXUv4/ljldX/
        DyNylIvnezP9VjOKfbcCVjvp5c0/OhGrJDBLKmZ+JRN14lvI4+DaAPx88eb5Q+q3V8LtyQSsP2L2I
        3wXEd0mw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qI-0002tm-Cl; Thu, 21 Mar 2019 23:11:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 05/15] nvme-pci: remove the unused iod->length field
Date:   Thu, 21 Mar 2019 16:10:27 -0700
Message-Id: <20190321231037.25104-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d63aac..bf0d71fe243e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -220,7 +220,6 @@ struct nvme_iod {
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
-	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
 	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
 	struct scatterlist *sg;
@@ -603,7 +602,6 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
-	iod->length = size;
 
 	return BLK_STS_OK;
 }
-- 
2.20.1

