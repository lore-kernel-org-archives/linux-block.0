Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/7] genirq/affinity: Handle pre/post vectors in
 irq_calc_affinity_vectors()
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-3-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1daf8fb5-d58e-9cf4-5b33-b39de1db4c20@suse.de>
Date: Tue, 8 Nov 2016 09:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
>
> Only calculate the affinity for the main I/O vectors, and skip the
> pre or post vectors specified by struct irq_affinity.
>
> Also remove the irq_affinity cpumask argument that has never been used.
> If we ever need it in the future we can pass it through struct
> irq_affinity.
>
> Signed-off-by: Christogh Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c         |  6 ++----
>  include/linux/interrupt.h |  4 ++--
>  kernel/irq/affinity.c     | 24 ++++++++++--------------
>  3 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index ad70507..c58d3c2 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1091,8 +1091,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>
>  	for (;;) {
>  		if (affinity) {
> -			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
> -					nvec);
> +			nvec = irq_calc_affinity_vectors(nvec, NULL);
>  			if (nvec < minvec)
>  				return -ENOSPC;
>  		}
> @@ -1140,8 +1139,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>
>  	for (;;) {
>  		if (affinity) {
> -			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
> -					nvec);
> +			nvec = irq_calc_affinity_vectors(nvec, NULL);
>  			if (nvec < minvec)
>  				return -ENOSPC;
>  		}
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 7284bcd..092adfb 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -291,7 +291,7 @@ extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>
>  struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
> -int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec);
> +int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
>
>  #else /* CONFIG_SMP */
>
> @@ -331,7 +331,7 @@ irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
>  }
>
>  static inline int
> -irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
> +irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
>  {
>  	return maxvec;
>  }
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 17f51d63..8d92597 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -131,24 +131,20 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
>  }
>
>  /**
> - * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
> - * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
> - *			is used
> - * @maxvec:		The maximum number of vectors available
> + * irq_calc_affinity_vectors - Calculate the optimal number of vectors
> + * @maxvec:	The maximum number of vectors available
> + * @affd:	Description of the affinity requirements
>   */
> -int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
> +int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
>  {
> -	int cpus, ret;
> +	int resv = affd->pre_vectors + affd->post_vectors;
> +	int vecs = maxvec - resv;
> +	int cpus;
>
Shouldn't you check for NULL affd here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
