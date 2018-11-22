Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95FC43610
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0F32080F
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CaLFCTJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F32080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404024AbeKVMdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404021AbeKVMdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tiEHjGZk27ZQZk11RKGqIkWf55qCwP7iQbHyCkJhRjE=; b=CaLFCTJqbfAGompEveB846K3V
        A7hr2BeOvflTH2rOJISsnuh1l0vkJ/q82qyyyGhorvNDn2cOBnsE3O9QvIwXWsOorD9UQjdWa4BB0
        zKTvk22DkS5HNUO4s2/liTLGmpUcL/VqaFF/Rrq6qBNCTxNyUc956vU/0n7+O+UPutltOzcNtX3//
        KvuJM9fQlcErndh8ae7r0NABFbSto5i+Ef1ZDdU7f6u4IrHq+3GyqOUQcj4QgnKdjXNUoXbUwMrOW
        zUI7RvfpAt3bfp90FGfO5b62ZMsXk9amsR8NpEqQ4oOmV3x+eyd3zu6f5w7kLbvDRKgqNAi3OI/yX
        KSv9BoTng==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE7-0006v0-98; Thu, 22 Nov 2018 01:56:19 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 07/13] nvmet: Add install_queue callout
Date:   Wed, 21 Nov 2018 17:56:05 -0800
Message-Id: <20181122015615.15763-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

nvmet-tcp will implement it to allocate queue commands which
are only known at nvmf connect time (sq size).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/nvme/target/fabrics-cmd.c | 10 ++++++++++
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 328ae46d8344..ee7d84621d65 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -121,6 +121,16 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		req->rsp->sq_head = cpu_to_le16(0xffff);
 	}
 
+	if (ctrl->ops->install_queue) {
+		u16 ret = ctrl->ops->install_queue(req->sq);
+
+		if (ret) {
+			pr_err("failed to install queue %d cntlid %d ret %x\n",
+				qid, ret, ctrl->cntlid);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7d8b7a7d572a..89df51ee5bdf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -279,6 +279,7 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.17.1

