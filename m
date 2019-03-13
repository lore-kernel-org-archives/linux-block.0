Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71658C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE72077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n7DGSCk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCMRz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:55:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCMRz5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0znmyB4jgUG/x15PDO4gc00aPgLYh7nJM/7o4PLcFDI=; b=n7DGSCk1O4GX5d77t2jmX//awb
        /IX2GgDSXeuI7bl3qZ91s6GhUkMvAKjNKHXuyTpT0J50kFtDrJOY+ACyS6GomQ0W6jn9nMNPzsz15
        DU9VoYDjEsT0x3/kEyeHPj4xOBtzSkKE78uJJNcC+wXo80ZStcR/fQ+B8EEyR6UiqWiT1MYOmddnC
        fzZMMqgNMf0sA0L+PNsmEPqhRJScoQ7RH/QFCTNjc6UsaZhmGmxSp3lW6JZ+w6re7wjtY5I9Cbxpp
        6KyvWMDXV2XcWdtnjC6XEgJ0L7o2Me4hLdU9xS60sjsY8oCLZWqrbTSwQ1nC7B6tbWIPpruEsvUCS
        6Zz50ahQ==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486a-0001kf-2k; Wed, 13 Mar 2019 17:55:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Nigel Kirkland <nigel.kirkland@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 10/17] nvmet-fc: fix issues with targetport assoc_list list walking
Date:   Wed, 13 Mar 2019 18:55:03 +0100
Message-Id: <20190313175510.20725-11-hch@lst.de>
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

There are two changes:

1) The logic in the __nvmet_fc_free_assoc() routine is bad. It uses
"safe" routines assuming pointers will come back valid.  However, the
intervening next structure being linked can be removed from the list and
the resulting safe pointers are bad, resulting in NULL ptrs being hit.

Correct by scheduling a work element to perform the association delete,
which can be done while under lock.

2) Prior patch that added the work element scheduling left a possible
reference on the object if the work element couldn't be scheduled.

Correct by doing the put on a failing schedule_work() call.

Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1e9654f04c60..8d34aa573d5b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1143,10 +1143,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		spin_unlock_irqrestore(&tgtport->lock, flags);
-		nvmet_fc_delete_target_assoc(assoc);
-		nvmet_fc_tgt_a_put(assoc);
-		spin_lock_irqsave(&tgtport->lock, flags);
+		if (!schedule_work(&assoc->del_work))
+			nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
@@ -1185,7 +1183,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			schedule_work(&assoc->del_work);
+			if (schedule_work(&assoc->del_work))
+				nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
 
-- 
2.20.1

