Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbcFYUWy (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 25 Jun 2016 16:22:54 -0400
Date: Sat, 25 Jun 2016 22:22:49 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160625202249.GB29251@dhcp-27-118.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-9-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465934346-20648-9-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 09:59:01PM +0200, Christoph Hellwig wrote:
> Set the affinity_mask before allocating vectors.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c   | 26 ++++++++++++++++++++++++--
>  include/linux/pci.h |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a33adec..50d694c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -568,6 +568,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
>  	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>  	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>  	entry->nvec_used		= nvec;
> +	entry->affinity			= dev->irq_affinity;
>  
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
> @@ -1176,12 +1186,20 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	unsigned int vecs, i;
>  	u32 *irqs;
> +	int ret;
>  
>  	max_vecs = min(max_vecs, pci_nr_irq_vectors(dev));
>  
> +	ret = irq_create_affinity_mask(&dev->irq_affinity, &max_vecs);

	dev->irq_affinity = irq_create_affinity_mask(&max_vecs); ?


> +	if (ret)
> +		return ret;
> +	if (max_vecs < min_vecs)
> +		return -ENOSPC;

irq_create_affinity_mask() should be called after MSI-X/MSI is enabled,
because we do not know number of vectors before the range functions
returned that number.

Since affinity masks is a function of number of vectors and CPU topology
the resulting masks might turn out suboptimal in general case (and
this code supposed to be general, right?).

I.e irq_create_affinity_mask() could decide "per-first-sibling" spreading
given number of available vectors, but only a subset of MSI vectors
were actually allocated. For that subset "per-core" affinity mask could
have been initialized, but we will still go with "per-first-sibling".

> +	ret = -ENOMEM;
>  	irqs = kcalloc(max_vecs, sizeof(u32), GFP_KERNEL);
>  	if (!irqs)
> -		return -ENOMEM;
> +		goto out_free_affinity;
>  
>  	if (!(flags & PCI_IRQ_NOMSIX)) {
>  		vecs = pci_enable_msix_range_wrapper(dev, irqs, min_vecs,
> @@ -1208,6 +1226,10 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  done:
>  	dev->irqs = irqs;
>  	return vecs;
> +out_free_affinity:
> +	kfree(dev->irq_affinity);
> +	dev->irq_affinity = NULL;
> +	return ret;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 84a20fc..f474611 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -321,6 +321,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	unsigned int	*irqs;
> +	struct cpumask	*irq_affinity;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>  
>  	bool match_driver;		/* Skip attaching driver */
> -- 
> 2.1.4
> 
