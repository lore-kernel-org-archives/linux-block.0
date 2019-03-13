Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D066C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140742077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2gclWjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCMRzc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMRzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j/JsuMGyEP0J83b8B9e31BYfABo9ORCoYa/36TuNGEg=; b=W2gclWjPTprKGSLOzRcXLrYu32
        op+6hM9nJlTP0lVE1nVkJQqsXGBoEsYM82sG7BTXkNtJnC2acF1iFnm7sPZxBRz/G+qheYOsxOIVf
        IpyJ1/SUcTAP2QLZgl5696MVHiZNYiA42Fc0s86I5sKdsKQt+V8loPNsoqHioMhdWpb//JE5YHSSB
        a8jce1fNHbFSy8PgBM00N2qnqYFdEWmK3Hs97/oUq8tgOJPVLCY+vnOdYIgSosv3wrVegNqRS7RFu
        9opT/O61Vfgw8CRtf43Hf5vO4KtZRhnY2ujyJfA3+M3R11U6FJ0DRE4fDier0M1CZXzm2LvSy2x5u
        D7Ggw+9Q==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486D-0001CX-OO; Wed, 13 Mar 2019 17:55:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 02/17] nvme: don't warn on block content change effects
Date:   Wed, 13 Mar 2019 18:54:55 +0100
Message-Id: <20190313175510.20725-3-hch@lst.de>
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

From: Keith Busch <keith.busch@intel.com>

A write or flush IO passthrough command is expected to change the
logical block content, so don't warn on these as no additional handling
is necessary.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07bf2bff3a76..dc1641247b17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1250,7 +1250,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (ns) {
 		if (ctrl->effects)
 			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
-		if (effects & ~NVME_CMD_EFFECTS_CSUPP)
+		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn(ctrl->device,
 				 "IO command:%02x has unhandled effects:%08x\n",
 				 opcode, effects);
-- 
2.20.1

