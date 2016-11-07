Return-Path: <tglx@linutronix.de>
Date: Mon, 7 Nov 2016 16:53:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] irq,pci: allow drivers to specify complex affinity
 requirement
In-Reply-To: <1478473646-12524-2-git-send-email-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1611071643500.3709@nanos>
References: <1478473646-12524-1-git-send-email-hch@lst.de> <1478473646-12524-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sun, 6 Nov 2016, Christoph Hellwig wrote:
>  drivers/pci/msi.c         | 61 ++++++++++++++++++++++++--------------------
>  include/linux/interrupt.h | 26 ++++++++++++++++---
>  include/linux/pci.h       | 14 ++++++----
>  kernel/irq/affinity.c     | 65 ++++++++++++++++++++++++-----------------------

Can you please split that up in bits and pieces. This change it all patch
is not fun to review.

>  4 files changed, 98 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd074..c312535 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -551,14 +551,15 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  }
>  
>  static struct msi_desc *
> -msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
> +msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity,
> +		struct irq_affinity *desc)

This should be 'const struct ....'. And can we please name this *affd or
something like that?

>  {
>  	struct cpumask *masks = NULL;
>  	struct msi_desc *entry;
>  	u16 control;
>  
>  	if (affinity) {

If we do it right, then we can get rid of the bool and depend on that irq
affinity pointer. We just have to push down the flag evaluation to
pci_alloc_irq_vectors[_affinity].

> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -232,6 +232,24 @@ struct irq_affinity_notify {
>  	void (*release)(struct kref *ref);
>  };
>  
> +/*
> + * This structure allows drivers to optionally specify complex IRQ affinity
> + * requirements.
> + */
> +struct irq_affinity {
> +	/*
> +	 * Number of vectors before the main affinity vectors that should not
> +	 * have have any CPU affinity:
> +	 */

Please make that kernel doc.

> +	int		pre_vectors;
> +
> +	/*
> +	 * Number of vectors after the main affinity vectors that should not
> +	 * have have any CPU affinity:
> +	 */
> +	int		post_vectors;
> +};
> +

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0e49f70..be0abd2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
...  
> +#define pci_alloc_irq_vectors(dev, min_vecs, max_vecs, flags) \
> +	pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags, NULL)

static inline please

>  #endif /* LINUX_PCI_H */
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 17f51d63..151b285 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -51,16 +51,16 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
>  
>  /**
>   * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
> - * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
> - *			is used
> + * @desc:		description of the affinity requirements

@affd and sentence starts with an uppercase letter, please.

>   * @nvecs:		The number of vectors

If you rename the argument then you want to rename this as well.

>   *
>   * Returns the masks pointer or NULL if allocation failed.
>   */
> -struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
> -					  int nvec)
> +struct cpumask *irq_create_affinity_masks(struct irq_affinity *desc,
> +					  int total_nvec)

Thanks,

	tglx
