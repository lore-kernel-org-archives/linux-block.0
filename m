Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbcF3RZJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 30 Jun 2016 13:25:09 -0400
Date: Thu, 30 Jun 2016 19:28:09 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
 routines
Message-ID: <20160630172808.GB9247@agordeev.lab.eng.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-8-git-send-email-hch@lst.de>
 <20160623111610.GA28861@dhcp-27-118.brq.redhat.com>
 <20160630165417.GA21787@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630165417.GA21787@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 30, 2016 at 06:54:17PM +0200, Christoph Hellwig wrote:
> > > +static unsigned int pci_nr_irq_vectors(struct pci_dev *pdev)
> > > +{
> > > +	int nr_entries;
> > > +
> > > +	nr_entries = pci_msix_vec_count(pdev);
> > > +	if (nr_entries <= 0 && pci_msi_supported(pdev, 1))
> > > +		nr_entries = pci_msi_vec_count(pdev);
> > > +	if (nr_entries <= 0)
> > > +		nr_entries = 1;
> > > +	return nr_entries;
> > > +}
> > 
> > This function is strange, because it:
> >   (a) does not consider PCI_IRQ_NOMSIX flag;
> >   (b) only calls pci_msi_supported() for MSI case;
> >   (c) calls pci_msi_supported() with just one vector;
> >   (d) might return suboptimal number of vectors (number of MSI-X used 
> >       later for MSI or vice versa)
> > 
> > Overall, I would suggest simply return maximum between MSI-X and MSI
> > numbers and let the rest of the code (i.e the two range functions)
> > handle a-d.
> 
> Ok, fixed except for (c) - the only thing pci_msi_supported does with
> nvec is to check for it being less than 1, which we don't care about,
> and which really shouldn't be in this function to start with.

Yes, but we should not rely on our knowledge of pci_msi_supported()
internals, aren't we? We need to follow the API which asks nvecs for
whatever reason. Anyway, if you return maximum of the two it does not
matter.

> > > +	struct msix_entry *msix_entries;
> > > +	int vecs, i;
> > > +
> > > +	msix_entries = kcalloc(max_vecs, sizeof(struct msix_entry), GFP_KERNEL);
> > > +	if (!msix_entries)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < max_vecs; i++)
> > > +		msix_entries[i].entry = i;
> > > +
> > > +	vecs = pci_enable_msix_range(pdev, msix_entries, min_vecs, max_vecs);
> > > +	if (vecs > 0) {
> > 
> > This condition check is unneeded.
> 
> Why?  We could get -ENOSPC back.  Oh, because our for loop will
> terminate immediately.  I can update it, but I think removing it
> is less readable than keeping it around.

Yes, I think you are right.

> > > +	if (!(flags & PCI_IRQ_NOMSIX)) {
> > > +		vecs = pci_enable_msix_range_wrapper(dev, irqs, min_vecs,
> > > +				max_vecs);
> > > +		if (vecs > 0)
> > > +			goto done;
> > > +	}
> > > +
> > > +	vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
> > > +	if (vecs > 0) {
> > > +		for (i = 0; i < vecs; i++)
> > > +			irqs[i] = dev->irq + i;
> > > +		goto done;
> > > +	}
> > > +
> > > +	if (min_vecs > 1)
> > > +		return -ENOSPC;
> > 
> > irqs is leaked if (min_vecs > 1)
> > 
> > You can get rid of this check at all if you reorganize your code i.e.
> > like this:
> > 
> > 	...
> > 
> > 	vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
> > 	if (vecs < 0)
> > 		goto legacy;
> > 
> > 	for (i = 0; i < vecs; i++)
> > 		irqs[i] = dev->irq + i;
> > 
> > done:
> > 	...
> > 
> > 
> > legacy:
> > 	...
> 
> I've just moved the if below the kfree.

I think I need to look at the updated version :)

> > > +#define PCI_IRQ_NOMSIX		(1 << 0) /* don't try to use MSI-X interrupts */
> > 
> > BTW, why PCI_IRQ_NOMSIX only and no PCI_IRQ_NOMSI?
> 
> Because there is no need to call this API if your device only supports
> a single legacy vector anyway.

What if a device reports (up to 32) MSIs and MSI-X allocation failed? The
driver might prefer the legacy single (i.e. due to errata in MSI), but
there is no flag to ask for it.
