Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF9C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F77E217FA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 13:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfBLNFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbfBLNFQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 08:05:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9633A59448;
        Tue, 12 Feb 2019 13:05:15 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1C6C1992A;
        Tue, 12 Feb 2019 13:05:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/4] nvme-pci: avoid irq allocation retrying via .calc_sets
Date:   Tue, 12 Feb 2019 21:04:38 +0800
Message-Id: <20190212130439.14501-4-ming.lei@redhat.com>
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 12 Feb 2019 13:05:15 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently pre-caculate each set vectors, and this way requires same
'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
then nvme_setup_irqs() has to retry in case of allocation failure.

This usage & interface is a bit awkward because the retry should have
been avoided by providing one reasonable 'min_vecs'.

Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
can calculate each set's vector after IRQ vectors is allocated and
before spread IRQ, then NVMe's retry in case of irq allocation failure
can be removed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 62 +++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0086bdf80ea1..ca381894542a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2078,14 +2078,25 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 	}
 }
 
+static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
+{
+	struct nvme_dev *dev = affd->priv;
+
+	nvme_calc_io_queues(dev, nvecs);
+
+	affd->set_vectors[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
+	affd->set_vectors[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
+	affd->nr_sets = HCTX_TYPE_POLL;
+}
+
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = 2,
+		.calc_sets = nvme_calc_irq_sets,
+		.priv = dev,
 	};
-	int *irq_sets = affd.set_vectors;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
@@ -2102,50 +2113,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 * Otherwise, we assign one independent vector to admin queue.
-		 */
-		if (irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
-
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
+	result = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 	return result;
 }
 
@@ -3021,6 +2990,7 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
+	BUILD_BUG_ON(HCTX_TYPE_POLL > IRQ_MAX_SETS);
 	return pci_register_driver(&nvme_driver);
 }
 
-- 
2.9.5

