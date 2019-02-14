Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE89C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D201B21900
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436644AbfBNMYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:24:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436634AbfBNMYP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:24:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EF44637E2;
        Thu, 14 Feb 2019 12:24:14 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 751A15D6B6;
        Thu, 14 Feb 2019 12:24:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 3/4] nvme-pci: Simplify interrupt allocation
Date:   Thu, 14 Feb 2019 20:23:46 +0800
Message-Id: <20190214122347.17372-4-ming.lei@redhat.com>
In-Reply-To: <20190214122347.17372-1-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Feb 2019 12:24:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The NVME PCI driver contains a tedious mechanism for interrupt
allocation, which is necessary to adjust the number and size of interrupt
sets to the maximum available number of interrupts which depends on the
underlying PCI capabilities and the available CPU resources.

It works around the former short comings of the PCI and core interrupt
allocation mechanims in combination with interrupt sets.

The PCI interrupt allocation function allows to provide a maximum and a
minimum number of interrupts to be allocated and tries to allocate as
many as possible. This worked without driver interaction as long as there
was only a single set of interrupts to handle.

With the addition of support for multiple interrupt sets in the generic
affinity spreading logic, which is invoked from the PCI interrupt
allocation, the adaptive loop in the PCI interrupt allocation did not
work for multiple interrupt sets. The reason is that depending on the
total number of interrupts which the PCI allocation adaptive loop tries
to allocate in each step, the number and the size of the interrupt sets
need to be adapted as well. Due to the way the interrupt sets support was
implemented there was no way for the PCI interrupt allocation code or the
core affinity spreading mechanism to invoke a driver specific function
for adapting the interrupt sets configuration.

As a consequence the driver had to implement another adaptive loop around
the PCI interrupt allocation function and calling that with maximum and
minimum interrupts set to the same value. This ensured that the
allocation either succeeded or immediately failed without any attempt to
adjust the number of interrupts in the PCI code.

The core code now allows drivers to provide a callback to recalculate the
number and the size of interrupt sets during PCI interrupt allocation,
which in turn allows the PCI interrupt allocation function to be called
in the same way as with a single set of interrupts. The PCI code handles
the adaptive loop and the interrupt affinity spreading mechanism invokes
the driver callback to adapt the interrupt set configuration to the
current loop value. This replaces the adaptive loop in the driver
completely.

Implement the NVME specific callback which adjusts the interrupt sets
configuration and remove the adaptive allocation loop.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 62 +++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 193d94caf457..02ae653bf2c3 100644
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
+	affd->set_size[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
+	affd->set_size[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
+	affd->nr_sets = 2;
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
-	int *irq_sets = affd.set_size;
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
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	return pci_register_driver(&nvme_driver);
 }
 
-- 
2.9.5

