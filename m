Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A49AC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2578218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 23:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYm3XYpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCUXLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:11:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 19:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BZObFgD0YHTmBpSWsCHBn2fDd4rSkWNAwRfyeZBFLuE=; b=jYm3XYprp3mmAfPNC/u42aAAjG
        /fOkxoUy85M3Br+AtxPKzsaUvvkMq50MqhQTKa8uY49f4RuBWaAQbqDUlUpMgylDak0Js/wOWrnpV
        9hCLH+GJy5KLeI6FkIlXQBZMbGtbPLFPgJ8j3I1FVEnPNkA05g0uZSFGhujKwLBUrtX6kTwZM0PrE
        EDnDsRf4LASPfvesi0M5YwjZAYSpeNl8ENHOf18tLzZ56z8ZoSQ75Vl/y9BtsUZ+7GIR/+wfGFVZ2
        iUFiM45fKJbCTVuE1/EQ6rVhLBsGJA6vDZyshSTBGvPMD/BYSxsm7hVDs4ry/rbERfikLdWPQnteI
        +dI38f6g==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76qe-0003NA-21; Thu, 21 Mar 2019 23:11:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 09/15] nvme-pci: only call nvme_unmap_data for requests transferring data
Date:   Thu, 21 Mar 2019 16:10:31 -0700
Message-Id: <20190321231037.25104-10-hch@lst.de>
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

This mirrors how nvme_map_pci is called and will allow simplifying some
checks in nvme_unmap_pci later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce8bdc15ec3c..bc4ee869fe82 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,7 +929,8 @@ static void nvme_pci_complete_rq(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	nvme_cleanup_cmd(req);
-	nvme_unmap_data(iod->nvmeq->dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(iod->nvmeq->dev, req);
 	nvme_complete_rq(req);
 }
 
-- 
2.20.1

