Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35879 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbcGGLFy (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 7 Jul 2016 07:05:54 -0400
Date: Thu, 7 Jul 2016 13:05:01 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160707110501.GA4917@dhcp-27-118.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-9-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467621574-8277-9-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 04, 2016 at 05:39:29PM +0900, Christoph Hellwig wrote:
> Set the affinity_mask in the PCI device before allocating vectors so that
> the affinity can be propagated through the MSI descriptor structures to
> the core IRQ code.  Add a new helper __pci_enable_msi_range which is
> similar to __pci_enable_msix_range introduced in the last patch so that
> we can allocate the affinity mask in a self-contained fashion and for the
> right number of vectors.
> 
> A new PCI_IRQ_NOAFFINITY flag is added to pci_alloc_irq_vectors so that
> this function can also be used by drivers that don't wish to use the
> automatic affinity assignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/PCI/MSI-HOWTO.txt |  3 +-
>  drivers/pci/msi.c               | 72 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/pci.h             |  2 ++
>  3 files changed, 72 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
> index 35d1326..dcd3f6d 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.txt
> @@ -95,7 +95,8 @@ argument set to this limit, and the PCI core will return -ENOSPC if it can't
>  meet the minimum number of vectors.
>  The flags argument should normally be set to 0, but can be used to
>  pass the PCI_IRQ_NOMSI and PCI_IRQ_NOMSIX flag in case a device claims
> -to support MSI or MSI-X, but the support is broken.
> +to support MSI or MSI-X, but the support is broken, or to PCI_IRQ_NOAFFINITY
> +if the driver does not wish to use the automatic affinity assignment feature.
>  
>  To get the Linux IRQ numbers passed to request_irq and free_irq
>  and the vectors use the following function:
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b0834d..7f38e07 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -568,6 +568,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
>  	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>  	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>  	entry->nvec_used		= nvec;
> +	entry->affinity			= dev->irq_affinity;

irq_create_affinity_mask() bails out with no affinity in case of single
vector, but alloc_descs() (see below (*)) assigns the whole affinity
mask. It should be consistent instead.

Actually, I just realized pci_alloc_irq_vectors() should probably call
irq_create_affinity_mask() and handle it in a consistent way for all four
cases: MSI-X, mulit-MSI, MSI and legacy.

Optionally, the three latter could be dropped for now so you could proceed
with NVMe.

>  	if (control & PCI_MSI_FLAGS_64BIT)
>  		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> @@ -679,10 +680,18 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>  static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			      struct msix_entry *entries, int nvec)
>  {
> +	const struct cpumask *mask = NULL;
>  	struct msi_desc *entry;
> -	int i;
> +	int cpu = -1, i;
>  
>  	for (i = 0; i < nvec; i++) {
> +		if (dev->irq_affinity) {
> +			cpu = cpumask_next(cpu, dev->irq_affinity);
> +			if (cpu >= nr_cpu_ids)
> +				cpu = cpumask_first(dev->irq_affinity);
> +			mask = cpumask_of(cpu);
> +		}
> +

(*) In the future IRQ vs CPU mapping 1:N is possible/desirable so I suppose
this piece of code worth a comment or better - a separate function. In fact,
this algorithm already exists in alloc_descs(), which makes even more sense
to factor it out:

	for (i = 0; i < cnt; i++) {
		if (affinity) {
			cpu = cpumask_next(cpu, affinity);
			if (cpu >= nr_cpu_ids)
				cpu = cpumask_first(affinity);
			node = cpu_to_node(cpu);

			/*
			 * For single allocations we use the caller provided
			 * mask otherwise we use the mask of the target cpu
			 */
			mask = cnt == 1 ? affinity : cpumask_of(cpu);
		}

		[...]

	}

>  		entry = alloc_msi_entry(&dev->dev);
>  		if (!entry) {
>  			if (!i)
> @@ -699,6 +708,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  		entry->msi_attrib.default_irq	= dev->irq;
>  		entry->mask_base		= base;
>  		entry->nvec_used		= 1;
> +		entry->affinity			= mask;
>  
>  		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>  	}
> @@ -1121,8 +1131,53 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
> +static int __pci_enable_msi_range(struct pci_dev *dev, int min_vecs, int max_vecs,

So I won't comment on this function before the above is decided.

> +		unsigned int flags)
> +{
> +	int vecs, ret;
> +
> +	if (!pci_msi_supported(dev, min_vecs))
> +		return -EINVAL;
> +
> +	vecs = pci_msi_vec_count(dev);
> +	if (vecs < 0)
> +		return vecs;
> +	if (vecs < min_vecs)
> +		return -EINVAL;
> +	if (vecs > max_vecs)
> +		vecs = max_vecs;
> +
> +retry:
> +	if (vecs < min_vecs)
> +		return -ENOSPC;
> +
> +	if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +		dev->irq_affinity = irq_create_affinity_mask(&vecs);
> +		if (vecs < min_vecs) {
> +			ret = -ERANGE;
> +			goto out_fail;
> +		}
> +	}
> +
> +	ret = msi_capability_init(dev, vecs);
> +	if (ret)
> +		goto out_fail;
> +
> +	return vecs;
> +
> +out_fail:
> +	kfree(dev->irq_affinity);
> +	if (ret >= 0) {
> +		/* retry with the actually supported number of vectors */
> +		vecs = ret;
> +		goto retry;
> +	}
> +
> +	return ret;
> +}
> +
>  static int __pci_enable_msix_range(struct pci_dev *dev, unsigned int min_vecs,
> -		unsigned int max_vecs)
> +		unsigned int max_vecs, unsigned int flags)
>  {
>  	int vecs = max_vecs, ret, i;
>  
> @@ -1138,6 +1193,13 @@ retry:
>  	for (i = 0; i < vecs; i++)
>  		dev->msix_vectors[i].entry = i;
>  
> +	if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +		dev->irq_affinity = irq_create_affinity_mask(&vecs);
> +		ret = -ENOSPC;
> +		if (vecs < min_vecs)
> +			goto out_fail;
> +	}
> +
>  	ret = pci_enable_msix(dev, dev->msix_vectors, vecs);
>  	if (ret)
>  		goto out_fail;
> @@ -1147,6 +1209,8 @@ retry:
>  out_fail:
>  	kfree(dev->msix_vectors);
>  	dev->msix_vectors = NULL;
> +	kfree(dev->irq_affinity);
> +	dev->irq_affinity = NULL;
>  
>  	if (ret >= 0) {
>  		/* retry with the actually supported number of vectors */
> @@ -1180,13 +1244,13 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  	int vecs;
>  
>  	if (!(flags & PCI_IRQ_NOMSIX)) {
> -		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs);
> +		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs, flags);
>  		if (vecs > 0)
>  			return vecs;
>  	}
>  
>  	if (!(flags & PCI_IRQ_NOMSI)) {
> -		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
> +		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
>  		if (vecs > 0)
>  			return vecs;
>  	}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 129871f..6a64c54 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -321,6 +321,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	struct msix_entry *msix_vectors;
> +	struct cpumask	*irq_affinity;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>  
>  	bool match_driver;		/* Skip attaching driver */
> @@ -1240,6 +1241,7 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  
>  #define PCI_IRQ_NOMSI		(1 << 0) /* don't try to use MSI interrupts */
>  #define PCI_IRQ_NOMSIX		(1 << 1) /* don't try to use MSI-X interrupts */
> +#define PCI_IRQ_NOAFFINITY	(1 << 2) /* don't auto-assign affinity */
>  
>  /* kmem_cache style wrapper around pci_alloc_consistent() */
>  
> -- 
> 2.1.4
> 
