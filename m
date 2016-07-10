Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41321 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbcGJD5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 9 Jul 2016 23:57:54 -0400
Date: Sun, 10 Jul 2016 05:57:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@fb.com,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] pci: spread interrupt vectors in
	pci_alloc_irq_vectors
Message-ID: <20160710035751.GC15720@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de> <1467621574-8277-9-git-send-email-hch@lst.de> <20160707110501.GA4917@dhcp-27-118.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707110501.GA4917@dhcp-27-118.brq.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 07, 2016 at 01:05:01PM +0200, Alexander Gordeev wrote:
> irq_create_affinity_mask() bails out with no affinity in case of single
> vector, but alloc_descs() (see below (*)) assigns the whole affinity
> mask. It should be consistent instead.

I don't understand the comment.  If we only have one vector (of any
kinds) there is no need to create an affinity mask, we'll leave the
interrupt to the existing irq balancing code.

> Actually, I just realized pci_alloc_irq_vectors() should probably call
> irq_create_affinity_mask() and handle it in a consistent way for all four
> cases: MSI-X, mulit-MSI, MSI and legacy.

That's what the earlier versions did, but you correctly pointed out
that we should call irq_create_affinity_mask only after we have reduced
the number of vectors to the number that the bridges can route, i.e.
that we have to move it into the pci_enable_msi(x)_range main loop.

> Optionally, the three latter could be dropped for now so you could proceed
> with NVMe.

NVMe cares for all these cases at least in theory.

> (*) In the future IRQ vs CPU mapping 1:N is possible/desirable so I suppose
> this piece of code worth a comment or better - a separate function. In fact,
> this algorithm already exists in alloc_descs(), which makes even more sense
> to factor it out:
> 
> 	for (i = 0; i < cnt; i++) {
> 		if (affinity) {
> 			cpu = cpumask_next(cpu, affinity);
> 			if (cpu >= nr_cpu_ids)
> 				cpu = cpumask_first(affinity);
> 			node = cpu_to_node(cpu);
> 
> 			/*
> 			 * For single allocations we use the caller provided
> 			 * mask otherwise we use the mask of the target cpu
> 			 */
> 			mask = cnt == 1 ? affinity : cpumask_of(cpu);
> 		}
> 
> 		[...]

While these two pieces of code look very similar there is an important
difference in why and how the mask is calculated.  In alloc_descs()
the difference here is that cnt = 1 is the MSI-X case where the
passed in affinity is that for the MSI-X descriptor which is for
a single vector.  in the MSI case where we have multiple vectors per
descriptor a different affinity is asigned for each vector based
of a single passed in mask.
