Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C24C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130F62077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6O4gghA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCMRzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfCMRzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O82uO42zPFjhcbrzGyRDpxvzxNnyq3ZqK1xm+aaQuR4=; b=k6O4gghAs+5oCmTnjW7k4JQECm
        mUC/CqgTF3a6QeBRLgaqg5tmOBih2JfQ/SuIBKM26X+zQyfIvtpcJsEV4z3gJzg/07lC8xHYI8NoL
        bUZjp1BMZtfn1HvY2I2NyipT9EM9At2GKoLAHrrMQizZHqBBm4YEAr5ZChLuK7Tk+X6v96XK8KkWP
        1OrvXUsiIBQhtZ/k97EF68ypwJpmu3/KykDmdfztq8b0FEKo0LWoPTVitep075zIFqq4FDW5C/eJx
        aanjIk4yPlFMl7ab0G4p8f4Y4d32Sjy5AKyi+uEHn/lbKCBjNWBNUEY6CM4dUH7P2p5nJwseYB8/K
        30zaDXng==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486U-0001do-N4; Wed, 13 Mar 2019 17:55:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 08/17] nvme-fc: fix numa_node when dev is null
Date:   Wed, 13 Mar 2019 18:55:01 +0100
Message-Id: <20190313175510.20725-9-hch@lst.de>
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

From: James Smart <jsmart2021@gmail.com>

A recent change added a numa_node field to the nvme controller
and has the transport assign the node using dev_to_node().
However, fcloop registers with a NULL device struct, so the
dev_to_node() call oops.

Revise the assignment to assign no node when device struct is null.

Fixes: 103e515efa89b ("nvme: add a numa_node field to struct nvme_ctrl")
Reported-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
[hch: small coding style fixup]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ba8f2a9cbdaf..23f6bad19274 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3017,7 +3017,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	if (lport->dev)
+		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	else
+		ctrl->ctrl.numa_node = NUMA_NO_NODE;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
-- 
2.20.1

