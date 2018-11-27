Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23470C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC53420873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/FCWesU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC53420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeK1KP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tiEHjGZk27ZQZk11RKGqIkWf55qCwP7iQbHyCkJhRjE=; b=X/FCWesUlzV6g95j9oPFcGuFw
        Ak1KFlOlyz9nVBOh5GcjFe6jwubx5tij8ahJTcOgd2Q0SF4Degk7EvF/xJZxv0H7U1Rjr0TbdAICp
        HK3tLaBrFx9Ziz4OSHOc3NyyMJvLIJ2nBlB21+M1gi6J7A7pZSMDP3AJ3X3Cocd3k+S40172mCWQ2
        fJgNtXYAMInvN4ip3A/X/O0ZQFEVvs1gdV7c4fbrC+ABadSQpp9lRcJg91i5Zlm9cti7vvOxrO0+z
        ZYxjS1YwpgGWn2AHsmrJdIxqw/YaRlDiXh6bpK95rI4TA7oA3+d1/zBy1YRfdYOM7Ks0vbHT0z/3u
        NHOAAYbdw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRmac-0007cp-Qy; Tue, 27 Nov 2018 23:16:22 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 07/13] nvmet: Add install_queue callout
Date:   Tue, 27 Nov 2018 15:16:09 -0800
Message-Id: <20181127231615.9446-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
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

