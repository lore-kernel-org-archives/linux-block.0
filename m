Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE68C10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4179821B68
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440279AbfBNVg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:36:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440296AbfBNVgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:36:55 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOgE-0002CE-0s; Thu, 14 Feb 2019 22:36:26 +0100
Message-Id: <20190214211759.699390983@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 14 Feb 2019 21:47:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
References: <20190214204755.819014197@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

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

[ tglx: Simplify the callback further and restore the dropped adjustment of
  	number of sets ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/nvme/host/pci.c |  108 ++++++++++++------------------------------------
 1 file changed, 28 insertions(+), 80 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2041,41 +2041,32 @@ static int nvme_setup_host_mem(struct nv
 	return ret;
 }
 
-/* irq_queues covers admin queue */
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
+/*
+ * nirqs is the number of interrupts available for write and read
+ * queues. The core already reserved an interrupt for the admin queue.
+ */
+static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
-	unsigned int this_w_queues = write_queues;
-
-	WARN_ON(!irq_queues);
-
-	/*
-	 * Setup read/write queue split, assign admin queue one independent
-	 * irq vector if irq_queues is > 1.
-	 */
-	if (irq_queues <= 2) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
-		return;
-	}
+	struct nvme_dev *dev = affd->priv;
+	unsigned int nr_read_queues;
 
 	/*
-	 * If 'write_queues' is set, ensure it leaves room for at least
-	 * one read queue and one admin queue
-	 */
-	if (this_w_queues >= irq_queues)
-		this_w_queues = irq_queues - 2;
-
-	/*
-	 * If 'write_queues' is set to zero, reads and writes will share
-	 * a queue set.
-	 */
-	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
-	} else {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
-	}
+	 * If only one interrupt is available, combine write and read
+	 * queues. If 'write_queues' is set, ensure it leaves room for at
+	 * least one read queue.
+	 */
+	if (nrirqs == 1)
+		nr_read_queues = 0;
+	else if (write_queues >= nrirqs)
+		nr_read_queues = nrirqs - 1;
+	else
+		nr_read_queues = nrirqs - write_queues;
+
+	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
+	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
+	affd->nr_sets = nr_read_queues ? 2 : 1;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
@@ -2083,10 +2074,9 @@ static int nvme_setup_irqs(struct nvme_d
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct irq_affinity affd = {
 		.pre_vectors	= 1,
-		.nr_sets	= 2,
+		.calc_sets	= nvme_calc_irq_sets,
+		.priv		= dev,
 	};
-	unsigned int *irq_sets = affd.set_size;
-	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
 	/*
@@ -2102,51 +2092,8 @@ static int nvme_setup_irqs(struct nvme_d
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
-	return result;
+	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
@@ -3021,6 +2968,7 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	return pci_register_driver(&nvme_driver);
 }
 


