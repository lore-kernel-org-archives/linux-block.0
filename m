Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbcFZThT (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 26 Jun 2016 15:37:19 -0400
Date: Sun, 26 Jun 2016 21:40:23 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: automatic interrupt affinity for MSI/MSI-X capable devices V2
Message-ID: <20160626194023.GB20915@agordeev.lab.eng.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 09:58:53PM +0200, Christoph Hellwig wrote:
> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.

Hi Christoph,

One general comment. As result of this series there will be
three locations to store/point to affinities: IRQ descriptor,
MSI descriptor and PCI device descriptor.

IRQ and MSI descriptors merely refer to duplicate masks while
the PCI device mask is the sum of all its MSI interrupts' masks.

Besides, MSI descriptors and PCI device affinity masks are only
used just once - at MSI initialization.

Overall, it looks like some cleanup is possible here.
