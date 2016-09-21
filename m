Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933871AbcIUMRn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2016 08:17:43 -0400
Date: Wed, 21 Sep 2016 14:23:36 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] genirq/msi: Switch to new irq spreading
 infrastructure
Message-ID: <20160921122335.GD26808@agordeev.lab.eng.brq.redhat.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-4-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-4-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 14, 2016 at 04:18:49PM +0200, Christoph Hellwig wrote:
> @@ -1039,6 +1058,7 @@ EXPORT_SYMBOL(pci_msi_enabled);
>  static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  		unsigned int flags)
>  {
> +	bool affinity = flags & PCI_IRQ_AFFINITY;
>  	int nvec;
>  	int rc;

The below notes apply to __pci_enable_msi_range() obviously.

> @@ -1111,26 +1129,24 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  		struct msix_entry *entries, int minvec, int maxvec,
>  		unsigned int flags)
>  {
> -	int nvec = maxvec;
> -	int rc;
> +	bool affinity = flags & PCI_IRQ_AFFINITY;
> +	int rc, nvec = maxvec;
>  
>  	if (maxvec < minvec)
>  		return -ERANGE;

A sanity check is missing in case dev->irq_affinity/cpu_online_mask
weight is less than minvec. We want to throw -EINVAL in this case,
not -ENOSPC.

>  	for (;;) {
> -		if (flags & PCI_IRQ_AFFINITY) {
> -			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> +		if (affinity) {
> +			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
> +					nvec);
>  			if (nvec < minvec)
>  				return -ENOSPC;
>  		}

The affinity mask weight might change and fall below minvec before
__pci_enable_msix() is called. I guess, get/put_online_cpus() calls
need to protect the loop iterations, not just irq_calc_affinity_vectors()
function alone.

But throwing -ENOSPC due to lack of dedicated CPUs for interrupt
handling looks like an overkill in general case, since we still can
distribute interrupts to a lower cpumask. Sorry if I forgot or missed
a discussion on this case.

> -		rc = pci_enable_msix(dev, entries, nvec);
> +		rc = __pci_enable_msix(dev, entries, nvec, affinity);
>  		if (rc == 0)
>  			return nvec;
>  
> -		kfree(dev->irq_affinity);
> -		dev->irq_affinity = NULL;
> -
>  		if (rc < 0)
>  			return rc;
>  		if (rc < minvec)
