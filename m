Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37777 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcFNT7L (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 15:59:11 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V2
Date: Tue, 14 Jun 2016 21:58:53 +0200
Message-Id: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This series enhances the irq and PCI code to allow spreading around MSI and
MSI-X vectors so that they have per-cpu affinity if possible, or at least
per-node.  For that it takes the algorithm from blk-mq, moves it to
a common place, and makes it available through a vastly simplified PCI
interrupt allocation API.  It then switches blk-mq to be able to pick up
the queue mapping from the device if available, and demonstrates all this
using the NVMe driver.

There also is a git tree available at:

   git://git.infradead.org/users/hch/block.git

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/msix-spreading.4

Changes since V1:
 - irq core improvements to properly assign the affinity before
   request_irq (tglx)
 - better handling of the MSI vs MSI-X differences in the low level
   MSI allocator (hch and tglx)
 - various improvements to pci_alloc_irq_vectors (hch)
 - remove blk-mq hardware queue reassigned on hotplug cpu events (hch)
 - forward ported to Jens' current for-next tree (hch)

