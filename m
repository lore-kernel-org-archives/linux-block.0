Return-Path: <tglx@linutronix.de>
Date: Sun, 18 Jun 2017 01:21:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] genirq: allow assigning affinity to present but not
 online CPUs
In-Reply-To: <20170603140403.27379-2-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706180114420.2428@nanos>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:

> This will allow us to spread MSI/MSI-X affinity over all present CPUs and
> thus better deal with systems where cpus are take on and offline all the
> time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/irq/manage.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 070be980c37a..5c25d4a5dc46 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -361,17 +361,17 @@ static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
>  	if (irqd_affinity_is_managed(&desc->irq_data) ||
>  	    irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
>  		if (cpumask_intersects(desc->irq_common_data.affinity,
> -				       cpu_online_mask))
> +				       cpu_present_mask))
>  			set = desc->irq_common_data.affinity;
>  		else
>  			irqd_clear(&desc->irq_data, IRQD_AFFINITY_SET);
>  	}
>  
> -	cpumask_and(mask, cpu_online_mask, set);
> +	cpumask_and(mask, cpu_present_mask, set);
>  	if (node != NUMA_NO_NODE) {
>  		const struct cpumask *nodemask = cpumask_of_node(node);
>  
> -		/* make sure at least one of the cpus in nodemask is online */
> +		/* make sure at least one of the cpus in nodemask is present */
>  		if (cpumask_intersects(mask, nodemask))
>  			cpumask_and(mask, mask, nodemask);
>  	}

This is a dangerous one. It might break existing setups subtly. Assume the
AFFINITY_SET flag is set, then this tries to preserve the user supplied
affinity mask. So that might end up with some random mask which does not
contain any online CPU. Not what we want.

We really need to seperate the handling of the managed interrupts from the
regular ones. Otherwise we end up with hard to debug issues. Cramming stuff
into the existing code, does not solve the problem, but it creates new ones.

Thanks,

	tglx
