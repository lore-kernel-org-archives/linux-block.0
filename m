Return-Path: <linux-block-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58219 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcGDKcQ (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2016 06:32:16 -0400
Date: Mon, 4 Jul 2016 12:30:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: axboe@fb.com, agordeev@redhat.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: automatic interrupt affinity for MSI/MSI-X capable devices V3
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
Message-ID: <alpine.DEB.2.11.1607041227340.4083@nanos>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 4 Jul 2016, Christoph Hellwig wrote:

> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.
> 
> Compared to the last posting the core IRQ changes are stable and it would
> be great to get them merged int the tip tree.  The two PCI patches have
> been completely rewritten after feedback from Alexander, while the block
> changes have also been stable.

I applied the first 6 patches. They are available in a seperate branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

and integrated into the irq/core branch. irq/for-block can be pulled from the
block folks if required.

Thanks,

	tglx
