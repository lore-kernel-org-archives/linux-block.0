Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcGFIFv (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 6 Jul 2016 04:05:51 -0400
Date: Wed, 6 Jul 2016 10:05:45 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
 routines
Message-ID: <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-8-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467621574-8277-8-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 04, 2016 at 05:39:28PM +0900, Christoph Hellwig wrote:
> Add a function to allocate a range of interrupt vectors, which will
> transparently use MSI-X and MSI if available or fallback to legacy
> vectors.  The interrupts are available in a core managed array in the
> pci_dev structure, and can also be released using a similar function.
> A new helper, __pci_enable_msix_range, is introduced to allow allocating
> the array of msix descriptors in the core PCIe code at the exact number
> of vectors supported by the PCI host complex, and to also help with the
> automatic IRQ affinity assignment that will be added in the next commit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/PCI/MSI-HOWTO.txt | 437 ++++------------------------------------

[...]

> + pci_enable_msi, pci_enable_msi_range, pci_enable_msi_exact, pci_disable_msi,
> + pci_msi_vec_count, pci_enable_msix_range, pci_enable_msix_exact,
> + pci_disable_msix, pci_msix_vec_count

Description of these functions can be removed when all drivers migrated
to the new API. Also implementation descriptions + examples would still
be needed AFAICT.

[...]

> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2003-2004 Intel
>   * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
> + * Copyright (C) 2016 Christoph Hellwig.
>   */
>  
>  #include <linux/err.h>
> @@ -1120,6 +1121,98 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
> +static int __pci_enable_msix_range(struct pci_dev *dev, unsigned int min_vecs,
> +		unsigned int max_vecs)
> +{
> +	int vecs = max_vecs, ret, i;
> +
> +retry:
> +	if (vecs < min_vecs)
> +		return -ENOSPC;
> +
> +	dev->msix_vectors = kmalloc_array(vecs, sizeof(struct msix_entry),
> +				GFP_KERNEL);
> +	if (!dev->msix_vectors)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < vecs; i++)
> +		dev->msix_vectors[i].entry = i;
> +
> +	ret = pci_enable_msix(dev, dev->msix_vectors, vecs);
> +	if (ret)
> +		goto out_fail;
> +
> +	return vecs;
> +
> +out_fail:
> +	kfree(dev->msix_vectors);
> +	dev->msix_vectors = NULL;
> +
> +	if (ret >= 0) {
> +		/* retry with the actually supported number of vectors */
> +		vecs = ret;
> +		goto retry;
> +	}
> +
> +	return ret;
> +}

This function's code almost matches the existing pci_enable_msix_range()
so pci_enable_msix_range() should be reworked instead IMHO.

I took a look at the existing code and the rework does not appear
necessary as __pci_enable_msix_range() could look like this:

static int __pci_enable_msix_range(struct pci_dev *dev, unsigned int min_vecs,
		unsigned int max_vecs)
{
	int ret, i;
	struct msix_entry *entries;

	entries = kmalloc_array(max_vecs, sizeof(entries[0]), GFP_KERNEL);
	if (!entries)
		return -ENOMEM;

	for (i = 0; i < max_vecs; i++)
		entries[i].entry = i;

	ret = pci_enable_msix_range(dev, entries, min_vecs, max_vecs);

	kfree(entries);

	return ret;
}


We do not need to keep msix_entry array, since it only needed for
pci_irq_vector() function. But the same info could be retrieved from
msi_desc::irq.

> +/**
> + * pci_alloc_irq_vectors - allocate multiple IRQs for a device
> + * @dev:		PCI device to operate on
> + * @min_vecs:		minimum number of vectors required (must be >= 1)
> + * @max_vecs:		maximum (desired) number of vectors
> + * @flags:		flags or quirks for the allocation
> + *
> + * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
> + * vectors if available, and fall back to a single legacy vector
> + * if neither is available.  Return the number of vectors allocated,
> + * (which might be smaller than @max_vecs) if successful, or a negative
> + * error code on error. If less than @min_vecs interrupt vectors are
> + * available for @dev the function will fail with -ENOSPC.
> + *
> + * To get the Linux irq number used for a vector that can be passed to
> + * request_irq use the pci_irq_vector() helper.
> + */
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +		unsigned int max_vecs, unsigned int flags)
> +{
> +	int vecs;
> +
> +	if (!(flags & PCI_IRQ_NOMSIX)) {
> +		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs);
> +		if (vecs > 0)
> +			return vecs;
> +	}
> +
> +	if (!(flags & PCI_IRQ_NOMSI)) {
> +		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
> +		if (vecs > 0)
> +			return vecs;
> +	}
> +
> +	/* use legacy irq if allowed */
> +	if (min_vecs == 1)
> +		return 1;
> +	return -ENOSPC;

The original error code (in vecs) would be overridden with -ENOSPC here.

> +}
> +EXPORT_SYMBOL(pci_alloc_irq_vectors);
> +
> +/**
> + * pci_free_irq_vectors - free previously allocated IRQs for a device
> + * @dev:		PCI device to operate on
> + *
> + * Undoes the allocations and enabling in pci_alloc_irq_vectors().
> + */
> +void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +	if (dev->msix_enabled)
> +		kfree(dev->msix_vectors);
> +	pci_disable_msix(dev);
> +	pci_disable_msi(dev);
> +}
> +EXPORT_SYMBOL(pci_free_irq_vectors);
> +
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
>  {
>  	return to_pci_dev(desc->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..129871f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -320,6 +320,7 @@ struct pci_dev {
>  	 * directly, use the values stored here. They might be different!
>  	 */
>  	unsigned int	irq;
> +	struct msix_entry *msix_vectors;

As suggested above, it is not needed.

>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>  
>  	bool match_driver;		/* Skip attaching driver */
> @@ -1237,6 +1238,9 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
>  int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  		      unsigned int command_bits, u32 flags);
>  
> +#define PCI_IRQ_NOMSI		(1 << 0) /* don't try to use MSI interrupts */
> +#define PCI_IRQ_NOMSIX		(1 << 1) /* don't try to use MSI-X interrupts */
> +
>  /* kmem_cache style wrapper around pci_alloc_consistent() */
>  
>  #include <linux/pci-dma.h>
> @@ -1284,6 +1288,24 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  		return rc;
>  	return 0;
>  }
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +		unsigned int max_vecs, unsigned int flags);
> +void pci_free_irq_vectors(struct pci_dev *dev);
> +
> +
> +/**
> + * pci_irq_vector - return Linux IRQ number of a device vector
> + * @dev: PCI device to operate on
> + * @nr: device-relative interrupt vector index (0-based).
> + */
> +static inline unsigned int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> +{
> +	if (dev->msix_enabled)
> +		return dev->msix_vectors[nr].vector;

So here you could search with for_each_pci_msi_entry() instead.


> +	WARN_ON_ONCE(!dev->msi_enabled && nr > 0);
> +	return dev->irq + nr;

I think this function should check irq number existence and return the
vector number or -EINVAL;

> +}
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
>  static inline void pci_msi_shutdown(struct pci_dev *dev) { }
> @@ -1307,6 +1329,23 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
>  static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  		      struct msix_entry *entries, int nvec)
>  { return -ENOSYS; }
> +static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
> +		unsigned int min_vecs, unsigned int max_vecs,
> +		unsigned int flags)
> +{
> +	if (min_vecs > 1)
> +		return -ENOSPC;

In case CONFIG_PCI_MSI is unset min_vecs > 1 is -EINVAL;

> +	return 1;
> +}
> +static inline void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +}
> +
> +static inline unsigned int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> +{
> +	WARN_ON_ONCE(nr > 0);

As suggested above, it would rather -EINVAL;

> +	return dev->irq;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> -- 
> 2.1.4
> 
