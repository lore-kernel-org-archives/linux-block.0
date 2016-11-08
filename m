Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/7] genirq/affinity: Handle pre/post vectors in
 irq_create_affinity_masks()
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-4-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a7e25633-b9fb-468f-fd33-28dbc0368cc1@suse.de>
Date: Tue, 8 Nov 2016 09:15:27 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-4-git-send-email-hch@lst.de>
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
>  drivers/pci/msi.c         |  4 ++--
>  include/linux/interrupt.h |  4 ++--
>  kernel/irq/affinity.c     | 46 +++++++++++++++++++++++++---------------------
>  3 files changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index c58d3c2..1761b8a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -558,7 +558,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
>  	u16 control;
>
>  	if (affinity) {
> -		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
> +		masks = irq_create_affinity_masks(nvec, NULL);
>  		if (!masks)
>  			pr_err("Unable to allocate affinity masks, ignoring\n");
>  	}
> @@ -697,7 +697,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	int ret, i;
>
>  	if (affinity) {
> -		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
> +		masks = irq_create_affinity_masks(nvec, NULL);
>  		if (!masks)
>  			pr_err("Unable to allocate affinity masks, ignoring\n");
>  	}
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 092adfb..bca8f1c 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -290,7 +290,7 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
>  extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>
> -struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
> +struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
>  int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
>
>  #else /* CONFIG_SMP */
> @@ -325,7 +325,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
>  }
>
>  static inline struct cpumask *
> -irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
> +irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
>  {
>  	return NULL;
>  }
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 8d92597..17360bd 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -51,16 +51,16 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
>
>  /**
>   * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
> - * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
> - *			is used
> - * @nvecs:		The number of vectors
> + * @nvecs:	The total number of vectors
> + * @affd:	Description of the affinity requirements
>   *
>   * Returns the masks pointer or NULL if allocation failed.
>   */
> -struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
> -					  int nvec)
> +struct cpumask *
> +irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
>  {
> -	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
> +	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
> +	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
>  	nodemask_t nodemsk = NODE_MASK_NONE;
>  	struct cpumask *masks;
>  	cpumask_var_t nmsk;
Check for NULL affd?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
