Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbcIVIp0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 04:45:26 -0400
Date: Thu, 22 Sep 2016 10:51:17 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] genirq/msi: Switch to new irq spreading
 infrastructure
Message-ID: <20160922085117.GF26808@agordeev.lab.eng.brq.redhat.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-4-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 14, 2016 at 04:18:49PM +0200, Christoph Hellwig wrote:
>  static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
> -			      struct msix_entry *entries, int nvec)
> +			      struct msix_entry *entries, int nvec,
> +			      bool affinity)
>  {
> -	const struct cpumask *mask = NULL;
> +	struct cpumask *curmsk, *masks = NULL;
>  	struct msi_desc *entry;
> -	int cpu = -1, i;
> -
> -	for (i = 0; i < nvec; i++) {
> -		if (dev->irq_affinity) {
> -			cpu = cpumask_next(cpu, dev->irq_affinity);
> -			if (cpu >= nr_cpu_ids)
> -				cpu = cpumask_first(dev->irq_affinity);
> -			mask = cpumask_of(cpu);
> -		}
> +	int ret, i;
>  
> -		entry = alloc_msi_entry(&dev->dev, 1, NULL);
> +	if (affinity) {
> +		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
> +		if (!masks)
> +			pr_err("Unable to allocate affinity masks, ignoring\n");

Okay, so if we can tolerate affinity mask failure here, then we should be
able to tolerate it everywhere. Therefore, this piece of code (I pointed
in my other mail) in __pci_enable_msi_range() should not bail out:

		if (affinity) {
			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
					nvec);
			if (nvec < minvec)
				return -ENOSPC;
		}

> +	}
> +
> +	for (i = 0, curmsk = masks; i < nvec; i++) {
> +		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
>  		if (!entry) {
>  			if (!i)
>  				iounmap(base);
>  			else
>  				free_msi_irqs(dev);
>  			/* No enough memory. Don't try again */
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto out;
>  		}
>  
>  		entry->msi_attrib.is_msix	= 1;
> @@ -710,11 +720,14 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			entry->msi_attrib.entry_nr = i;
>  		entry->msi_attrib.default_irq	= dev->irq;
>  		entry->mask_base		= base;
> -		entry->affinity			= mask;
>  
>  		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
> +		if (masks)
> +			curmsk++;
>  	}
> -
> +	ret = 0;
> +out:
> +	kfree(masks);
>  	return 0;

	return ret;

>  }
