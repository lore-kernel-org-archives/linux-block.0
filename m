Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33395 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbcF3RfL (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 30 Jun 2016 13:35:11 -0400
Date: Thu, 30 Jun 2016 19:35:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160630173508.GA23378@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de> <1465934346-20648-8-git-send-email-hch@lst.de> <20160623111610.GA28861@dhcp-27-118.brq.redhat.com> <20160630165417.GA21787@lst.de> <20160630172808.GB9247@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630172808.GB9247@agordeev.lab.eng.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 30, 2016 at 07:28:09PM +0200, Alexander Gordeev wrote:
> I think I need to look at the updated version :)

I've astarted processing the comments for the whole series and plan
to post an update tomorrow.

> > > > +#define PCI_IRQ_NOMSIX		(1 << 0) /* don't try to use MSI-X interrupts */
> > > 
> > > BTW, why PCI_IRQ_NOMSIX only and no PCI_IRQ_NOMSI?
> > 
> > Because there is no need to call this API if your device only supports
> > a single legacy vector anyway.
> 
> What if a device reports (up to 32) MSIs and MSI-X allocation failed? The
> driver might prefer the legacy single (i.e. due to errata in MSI), but
> there is no flag to ask for it.

Ok, I'll add it for now.
