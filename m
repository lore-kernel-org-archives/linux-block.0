Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-2-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ee7ee373-5048-4e62-3f58-4e1e74edf7e5@suse.de>
Date: Tue, 8 Nov 2016 09:11:56 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
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
> ---
>  include/linux/interrupt.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 72f0721..7284bcd 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -232,6 +232,18 @@ struct irq_affinity_notify {
>  	void (*release)(struct kref *ref);
>  };
>
> +/**
> + * struct irq_affinity - Description for auto irq affinity assignements
> + * @pre_vectors:	Reserved vectors at the beginning of the MSIX
> + *			vector space
> + * @post_vectors:	Reserved vectors at the end of the MSIX
> + *			vector space
> + */
> +struct irq_affinity {
> +	int	pre_vectors;
> +	int	post_vectors;
> +};
> +
>  #if defined(CONFIG_SMP)
>
>  extern cpumask_var_t irq_default_affinity;
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
