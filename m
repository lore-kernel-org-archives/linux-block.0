Return-Path: <helgaas@kernel.org>
Date: Tue, 8 Nov 2016 15:25:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
Message-ID: <20161108212526.GF14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478544462-9549-2-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 07, 2016 at 10:47:36AM -0800, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
> 
> Some drivers (various network and RDMA adapter for example) have a MSI-X
> vector layout where most of the vectors are used for I/O queues and should
> have CPU affinity assigned to them, but some (usually 1 but sometimes more)
> at the beginning or end are used for low-performance admin or configuration
> work and should not have any explicit affinity assigned to them.
> 
> This adds a new irq_affinity structure, which will be passed through a
> variant of pci_irq_alloc_vectors that allows to specify these
> requirements (and is extensible to any future quirks in that area) so that
> the core IRQ affinity algorithm can take this quirks into account.
> 
> Signed-off-by: Christogh Hellwig <hch@lst.de>

s/Christogh/Christoph/ (also above)

What tree would you prefer?  I vote for the IRQ tree since that seems
to be where the interesting parts are, and I think I acked all the PCI
bits.

> + * struct irq_affinity - Description for auto irq affinity assignements
> + * @pre_vectors:	Reserved vectors at the beginning of the MSIX
> + *			vector space
> + * @post_vectors:	Reserved vectors at the end of the MSIX
> + *			vector space

Maybe include something more informative than just "reserved", e.g.,
"Don't apply affinity to @pre_vectors at beginning of MSI-X vector
space" or "Vectors at beginning of MSI-X vector space that are exempt
from affinity"?

> + */
> +struct irq_affinity {
> +	int	pre_vectors;
> +	int	post_vectors;
> +};
> +
>  #if defined(CONFIG_SMP)
>  
>  extern cpumask_var_t irq_default_affinity;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
