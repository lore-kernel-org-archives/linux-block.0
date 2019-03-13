Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD71C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87792077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWgCDrKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCMRzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMRzm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PV/JxbrmpNyd5IxWzyo2hafnmixA3OOL8VJKaNmAPlo=; b=IWgCDrKHYmRTFMTQyJo/4JS5lH
        T0ewRzl5NJIaSdKuBQj/lRLl08UAHtl4QGy9hirbCuLHY0Are69I3H19v+2y54m5O4BdCMIVYW3fM
        EyhUDayk5UByVknCzzmY+zxChnH/8IYR1jrGz9/KzPs/TrshLNcdhN1FxTc6tdg+FutMf4PGGX4Vt
        /RlHT5Zlka+CMtulWxw3zT82yyYq47TxcsXj4KcXsdXzUnrGeSoq57nK8srGmMI/0HXGC30F4xEip
        rTAae6pRDjyb0/tmjGzGL0vilMbS9PF54D5dUV2UnxgAZoltqtsTLL8qX881Jevx0btIYMLi1wwmG
        2pyPGvbg==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486J-0001LG-TJ; Wed, 13 Mar 2019 17:55:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 04/17] nvme: put ns_head ref if namespace fails allocation
Date:   Wed, 13 Mar 2019 18:54:57 +0100
Message-Id: <20190313175510.20725-5-hch@lst.de>
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

From: Sagi Grimberg <sagi@grimberg.me>

In case nvme_alloc_ns fails after we initialize ns_head but before we
add the ns to the controller namespaces list we need to explicitly put
the ns_head reference because when we teardown the controller we
won't find it, causing us to leak a dangling subsystem eventually.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc1641247b17..d57a84f45ed0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3304,6 +3304,7 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
+	nvme_put_ns_head(ns->head);
  out_free_id:
 	kfree(id);
  out_free_queue:
-- 
2.20.1

