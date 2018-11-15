Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97CC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968CF223CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSUhOjJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968CF223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeKPDZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388683AbeKPDZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zeE9qNUvxwXROYdSpTrdQdie5JY3zQ1AuyiC6Pi1Or0=; b=tSUhOjJtxW3jA6YutbhGI+Lnt
        yXnUdZMb4QQ4fphmHcsBtC5fCXjOux9cV5qCpHdvoj0ysoljgMJPkZU5lwb/Y5nSW6MqnjsDfpj6U
        ZTiuTyhojc0bGQ0PSUSErVNsqKUkaWcd5PTFKm+JdYR2WHHdRmrV7lSMec/q9oQe1Dgg0Z28cs+cz
        JEIiaAi8VT/p2td5fioy+qAORpUL7PLhJjlMwyR5pmq1Qby4hTa7Ar4VhXl/0VqhGXTj2no+6CRk5
        Y5zDmozaK3eXuXMAPJ22umqUz12HMo6c8LYZ0htMVrUWjzb7ZVq02hDT6wzlkVGNNSvDJnvwuGj7y
        bRlPmjgzA==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFn-0002LK-KD; Thu, 15 Nov 2018 17:16:31 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 05/11] nvmet: Add install_queue callout
Date:   Thu, 15 Nov 2018 09:16:17 -0800
Message-Id: <20181115171626.9306-6-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvmet-tcp will implement it to allocate queue commands which
are only known at nvmf connect time (sq size).

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
 drivers/nvme/target/nvmet.h       | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 1f05d8507e35..a84668e8939c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -117,6 +117,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
 			!!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));
 
+	if (ctrl->ops->install_queue) {
+		int ret = ctrl->ops->install_queue(req->sq);
+		if (ret) {
+			pr_err("failed to install queue %d cntlid %d ret %d\n",
+				qid, ret, ctrl->cntlid);
+			return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index abc603fa725d..1362afe6e0b3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -281,6 +281,7 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	int (*install_queue)(struct nvmet_sq *nvme_sq);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.17.1

