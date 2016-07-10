Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41287 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933258AbcGJDrj (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 9 Jul 2016 23:47:39 -0400
Date: Sun, 10 Jul 2016 05:47:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
	routines
Message-ID: <20160710034737.GB15720@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de> <1467621574-8277-8-git-send-email-hch@lst.de> <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jul 06, 2016 at 10:05:45AM +0200, Alexander Gordeev wrote:
> > + pci_enable_msi, pci_enable_msi_range, pci_enable_msi_exact, pci_disable_msi,
> > + pci_msi_vec_count, pci_enable_msix_range, pci_enable_msix_exact,
> > + pci_disable_msix, pci_msix_vec_count
> 
> Description of these functions can be removed when all drivers migrated
> to the new API. Also implementation descriptions + examples would still
> be needed AFAICT.

I diagreed - if we deprecated functions the only thing that should
be mentioned is a "don't use these". 

> This function's code almost matches the existing pci_enable_msix_range()
> so pci_enable_msix_range() should be reworked instead IMHO.

That's what earlier versions of the code did.  However due to the
fact that we want to avoid over-allocating the msix_vectors array
(minor) and get the vectors count of the affinity mask right (major,
as pointed out by you last time) I had to move the allocations inside
the helpers that loop around the atctual enablement.  I didn't want
to change the function to a different version of the algorithm just
before removing them relatively soon.  But given that strong preference
for changing these simple functions instead of duplicating them I've
changed that patch to do that now.

> We do not need to keep msix_entry array, since it only needed for
> pci_irq_vector() function. But the same info could be retrieved from
> msi_desc::irq.

Indeed.  Avoiding this allocation makes these interfaces quite a bit
simpler.  It requires a few prep patches, but I think it's definitively
worth, so the next version will avoid the need for the msix_entry array.

> > +	/* use legacy irq if allowed */
> > +	if (min_vecs == 1)
> > +		return 1;
> > +	return -ENOSPC;
> 
> The original error code (in vecs) would be overridden with -ENOSPC here.

Ok, fixed.

> > +	WARN_ON_ONCE(!dev->msi_enabled && nr > 0);
> > +	return dev->irq + nr;
> 
> I think this function should check irq number existence and return the
> vector number or -EINVAL;

Ok, fixed.

> > +		unsigned int flags)
> > +{
> > +	if (min_vecs > 1)
> > +		return -ENOSPC;
> 
> In case CONFIG_PCI_MSI is unset min_vecs > 1 is -EINVAL;

Ok, fixed.
