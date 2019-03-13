Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24559C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C352077B
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sq2hdLDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCMR4D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:56:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMR4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mbvgNJ5FXQMW0T5VbRX+G7xe7VM96Au8zROp0Xs9UhU=; b=Sq2hdLDbRWVE59vFH3ryoHvGg5
        7Xvx7T/dp6XzQp2nua2kcGkZPmhfWsSceAa+oHFHIkHgcyBhMoqSII2NGRCv5pygwzUJK+d0HBalN
        0rflMzrmwuLDSuNk72AuQDPMmpzihOA1enKGMWflPGAnOEhj46NjwA3JAR5J8d05GhRV7kTx3sOYR
        hD1yF2fDrKTtM5Rj2yvJYXSG/iUvwXhALu+flZnzUdex54PXNEc5Tq3JxU9Kyvw1UO457EtJ+OYd1
        Abtjp6KhXIup60tQIuCFuF9bTs8v3SYgiFM5PSSEtVEDVEBJe2wT8Q+67eAsQHnglBpiOXwpKYKAT
        0OEJCzQQ==;
Received: from 089144197017.atnat0006.highway.a1.net ([89.144.197.17] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h486f-0001t1-GE; Wed, 13 Mar 2019 17:55:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 12/17] nvme: disable Write Zeroes for qemu controllers
Date:   Wed, 13 Mar 2019 18:55:05 +0100
Message-Id: <20190313175510.20725-13-hch@lst.de>
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

Qemu started out with a broken implementation of Write Zeroes written
by yours truly.  Disable Write Zeroes on qemu for now, eventually
we need to go back and make all the qemu quirks version specific,
but that is left for another time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Tested-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b92fab434066..951e9f31b57c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1531,7 +1531,8 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	u32 max_sectors;
 	unsigned short bs = 1 << ns->lba_shift;
 
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
+	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
+	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		return;
 	/*
 	 * Even though NVMe spec explicitly states that MDTS is not
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b91f1838bbd5..527d64545023 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -87,6 +87,11 @@ enum nvme_quirks {
 	 * Ignore device provided subnqn.
 	 */
 	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
+
+	/*
+	 * Broken Write Zeroes.
+	 */
+	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f54718b63637..3a2377888a46 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2975,7 +2975,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
-		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
+		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.20.1

