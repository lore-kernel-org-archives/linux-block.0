Return-Path: <keith.busch@intel.com>
Date: Thu, 25 Oct 2018 15:52:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181025215213.GA8141@localhost.localdomain>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-12-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181025211626.12692-12-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 25, 2018 at 03:16:23PM -0600, Jens Axboe wrote:
> A driver may have a need to allocate multiple sets of MSI/MSI-X
> interrupts, and have them appropriately affinitized. Add support for
> defining a number of sets in the irq_affinity structure, of varying
> sizes, and get each set affinitized correctly across the machine.

<>

> @@ -258,13 +272,18 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  {
>  	int resv = affd->pre_vectors + affd->post_vectors;
>  	int vecs = maxvec - resv;
> +	int i, set_vecs;
>  	int ret;
>  
>  	if (resv > minvec)
>  		return 0;
>  
>  	get_online_cpus();
> -	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs) + resv;
> +	ret = min_t(int, cpumask_weight(cpu_possible_mask), vecs);
>  	put_online_cpus();
> -	return ret;
> +
> +	for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> +		set_vecs += affd->sets[i];
> +
> +	return resv + max(ret, set_vecs);
>  }

This is looking pretty good, but we may risk getting into an infinite
loop in __pci_enable_msix_range() if we're requesting too many vectors
in a set: the above code may continue returning set_vecs, overriding
the reduced nvec that pci requested, and pci msix initialization will
continue to fail because it is repeatedly requesting to activate the
same vector count that failed before.
