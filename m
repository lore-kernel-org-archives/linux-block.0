Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56514 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbcGDIjm (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2016 04:39:42 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: agordeev@redhat.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V3
Date: Mon,  4 Jul 2016 17:39:21 +0900
Message-Id: <1467621574-8277-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series enhances the irq and PCI code to allow spreading around MSI and
MSI-X vectors so that they have per-cpu affinity if possible, or at least
per-node.  For that it takes the algorithm from blk-mq, moves it to
a common place, and makes it available through a vastly simplified PCI
interrupt allocation API.  It then switches blk-mq to be able to pick up
the queue mapping from the device if available, and demonstrates all this
using the NVMe driver.

Compared to the last posting the core IRQ changes are stable and it would
be great to get them merged int the tip tree.  The two PCI patches have
been completely rewritten after feedback from Alexander, while the block
changes have also been stable.

There also is a git tree available at:

   git://git.infradead.org/users/hch/block.git msix-spreading.6

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/msix-spreading.6

Changes since V2:
 - improve the description of IRQD_AFFINITY_MANAGED
 - update MSI-HOWTO.txt
 - add a PCI_IRQ_NOMSI flag to avoid using MSI vectors
 - add a PCI_IRQ_NOAFFINITY flag to skip auto affinity
 - change the irq_create_affinity_mask calling convention
 - rewrite pci_alloc_irq_vectors to create the affinity mask only after
   we know the final vector count
 - cleanup pci_free_irq_vectors
 - replace pdev->irqs with pdev->msix_vectors and introduce
   a pci_irq_vector helper to get the Linux IRQ numbers

Changes since V1:
 - irq core improvements to properly assign the affinity before
   request_irq (tglx)
 - better handling of the MSI vs MSI-X differences in the low level
   MSI allocator (hch and tglx)
 - various improvements to pci_alloc_irq_vectors (hch)
 - remove blk-mq hardware queue reassigned on hotplug cpu events (hch)
 - forward ported to Jens' current for-next tree (hch)

