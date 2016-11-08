Return-Path: <tglx@linutronix.de>
Date: Tue, 8 Nov 2016 15:48:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Hannes Reinecke <hare@suse.de>
cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
    linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
    Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
    Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
In-Reply-To: <1478591241-123356-1-git-send-email-hare@suse.de>
Message-ID: <alpine.DEB.2.20.1611081547530.3501@nanos>
References: <1478591241-123356-1-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 Nov 2016, Hannes Reinecke wrote:

> Add a reverse-mapping function to return the interrupt vector for
> any CPU if interrupt affinity is enabled.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/pci/msi.c   | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd074..de5ed32 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1302,6 +1302,42 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
>  }
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
> +/**
> + * pci_irq_get_affinity_vector - return the vector number for a given CPU
> + * @dev:	PCI device to operate on
> + * @cpu:	cpu number
> + *
> + * Returns the vector number for CPU @cpu or a negative error number
> + * if interrupt affinity is not set.
> + */
> +int pci_irq_get_affinity_vector(struct pci_dev *dev, int cpu)
> +{
> +	if (dev->msix_enabled) {
> +		struct msi_desc *entry;
> +
> +		for_each_pci_msi_entry(entry, dev) {
> +			if (cpumask_test_cpu(cpu, entry->affinity))

entry->affinity can be NULL
