Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756367AbcISHZC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 03:25:02 -0400
Date: Mon, 19 Sep 2016 09:30:58 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@fb.com, tglx@linutronix.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] genirq/msi: Add cpumask allocation to
 alloc_msi_entry
Message-ID: <20160919073057.GA31001@agordeev.lab.eng.brq.redhat.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <1473862739-15032-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473862739-15032-2-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 14, 2016 at 04:18:47PM +0200, Christoph Hellwig wrote:
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 19e9dfb..8a3e8727 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -18,20 +18,42 @@
>  /* Temparory solution for building, will be removed later */
>  #include <linux/pci.h>
>  
> -struct msi_desc *alloc_msi_entry(struct device *dev)
> +/**
> + * alloc_msi_entry - Allocate an initialize msi_entry
> + * @dev:	Pointer to the device for which this is allocated
> + * @nvec:	The number of vectors used in this entry
> + * @affinity:	Optional pointer to an affinity mask array size of @nvec
> + *
> + * If @affinity is not NULL then a an affinity array[@nvec] is allocated
> + * and the affinity masks from @affinity are copied.
> + */
> +struct msi_desc *
> +alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
>  {
> -	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> +	struct msi_desc *desc;
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
>  	if (!desc)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&desc->list);
>  	desc->dev = dev;
> +	desc->nvec_used = nvec;
> +	if (affinity) {
> +		desc->affinity = kmemdup(affinity,
> +			nvec * sizeof(*desc->affinity), GFP_KERNEL);
> +		if (!desc->affinity) {
> +			kfree(desc);
> +			return NULL;
> +		}
> +	}

nit - should not "desc" initialization follow "desc->affinity" allocation?

>  	return desc;
>  }
>  
>  void free_msi_entry(struct msi_desc *entry)
>  {
> +	kfree(entry->affinity);
>  	kfree(entry);
>  }
>  
> -- 
> 2.1.4
> 
