Return-Path: <SRS0=EAuX=OL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D5C64EB4
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36E820851
	for <linux-block@archiver.kernel.org>; Sun,  2 Dec 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FxqDLsP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36E820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbeLBQsB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:48:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbeLBQsB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 11:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v7Uma6s66mJDpXg4yZ5MDNBz99Mo29t2gW6fzmUIzPA=; b=FxqDLsP/IPZ2vSaD8EPhWgtZk9
        igdQTcoIGp6wbPShNIsQ6uw8nppO3mE7THwMPr+PFanCQWetxTQO6kCsfaAdQkVPxiiRXm2+uPhx6
        PVJJAqKsgIh95dMDT9cJNMOe1Ix5/13nyUeaIaWOTb3CO8jzgtNEJi9yvZvAsuRcxD1KFO0jXiaRr
        fis/D6C9eYZtvNNbNV7K1kUeQNKY/D5UBng4MTnpO0O4ApXFJNAvjjIPM6X7wB5FXY5aGsQlMaX0I
        riC9BbmyvEig8gKmIbOEVh1MJOa/7eR03qnBUOxBeoaMJifPG6X9uwDqv0uPu7+1Z9d3ypGlgNxYm
        fPQQJ83w==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTUuS-0002St-G4; Sun, 02 Dec 2018 16:47:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
Date:   Sun,  2 Dec 2018 17:46:21 +0100
Message-Id: <20181202164628.1116-7-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the opcode for the delete SQ/CQ command as an argument instead of
the somewhat confusing pass loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10c26a2e355a..9ceba9900ca3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2244,31 +2244,29 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
+static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 {
-	int pass, queues = dev->online_queues - 1;
+	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
-	u8 opcode = nvme_admin_delete_sq;
 
-	for (pass = 0; pass < 2; pass++) {
-		int sent = 0, i = queues;
-
-		reinit_completion(&dev->ioq_wait);
+	reinit_completion(&dev->ioq_wait);
  retry:
-		timeout = ADMIN_TIMEOUT;
-		for (; i > 0; i--, sent++)
-			if (nvme_delete_queue(&dev->queues[i], opcode))
-				break;
-
-		while (sent--) {
-			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
-			if (timeout == 0)
-				return;
-			if (i)
-				goto retry;
-		}
-		opcode = nvme_admin_delete_cq;
+	timeout = ADMIN_TIMEOUT;
+	while (nr_queues > 0) {
+		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
+			break;
+		nr_queues--;
+		sent++;
 	}
+	while (sent--) {
+		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
+				timeout);
+		if (timeout == 0)
+			return false;
+		if (nr_queues)
+			goto retry;
+	}
+	return true;
 }
 
 /*
@@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
+			nvme_disable_io_queues(dev, nvme_admin_delete_cq);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
-- 
2.19.1

