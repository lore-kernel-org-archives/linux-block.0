Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbcFYUFY (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sat, 25 Jun 2016 16:05:24 -0400
Date: Sat, 25 Jun 2016 22:05:19 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
Message-ID: <20160625200518.GA29251@dhcp-27-118.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465934346-20648-7-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 09:58:59PM +0200, Christoph Hellwig wrote:
> This is lifted from the blk-mq code and adopted to use the affinity mask
> concept just intruced in the irq handling code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/interrupt.h | 11 +++++++++
>  kernel/irq/Makefile       |  1 +
>  kernel/irq/affinity.c     | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
>  create mode 100644 kernel/irq/affinity.c
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 9fcabeb..12003c0 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -278,6 +278,9 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
>  extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>  
> +int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs);
> +
>  #else /* CONFIG_SMP */
>  
>  static inline int irq_set_affinity(unsigned int irq, const struct cpumask *m)
> @@ -308,6 +311,14 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
>  {
>  	return 0;
>  }
> +
> +static inline int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs)
> +{
> +	*affinity_mask = NULL;
> +	*nr_vecs = 1;
> +	return 0;
> +}
>  #endif /* CONFIG_SMP */
>  
>  /*
> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index 2ee42e9..1d3ee31 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
>  obj-$(CONFIG_PM_SLEEP) += pm.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
>  obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
> +obj-$(CONFIG_SMP) += affinity.o
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> new file mode 100644
> index 0000000..1daf8fb
> --- /dev/null
> +++ b/kernel/irq/affinity.c
> @@ -0,0 +1,60 @@
> +
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/cpu.h>
> +
> +static int get_first_sibling(unsigned int cpu)
> +{
> +	unsigned int ret;
> +
> +	ret = cpumask_first(topology_sibling_cpumask(cpu));
> +	if (ret < nr_cpu_ids)
> +		return ret;
> +	return cpu;
> +}
> +
> +/*
> + * Take a map of online CPUs and the number of available interrupt vectors
> + * and generate an output cpumask suitable for spreading MSI/MSI-X vectors
> + * so that they are distributed as good as possible around the CPUs.  If
> + * more vectors than CPUs are available we'll map one to each CPU,

Unless I do not misinterpret a loop from msix_setup_entries() (patch 08/13),
the above is incorrect:

	for (i = 0; i < nvec; i++) {
		if (dev->irq_affinity) {
			cpu = cpumask_next(cpu, dev->irq_affinity);
			if (cpu >= nr_cpu_ids)
				cpu = cpumask_first(dev->irq_affinity);
			mask = cpumask_of(cpu);
		}

		...

		entry->affinity			= mask;
	}

> + * otherwise we map one to the first sibling of each socket.

(*) I guess, in some topology configurations a total number of all
first siblings may be less than the number of vectors.

> + * If there are more vectors than CPUs we will still only have one bit
> + * set per CPU, but interrupt code will keep on assining the vectors from
> + * the start of the bitmap until we run out of vectors.
> + */
> +int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs)

Both the callers of this function and the function itself IMHO would
read better if it simply returned the affinity mask. Or passed the 
affinity mask pointer.

> +{
> +	unsigned int vecs = 0;

In case (*nr_vecs >= num_online_cpus()) the contents of *nr_vecs
will be overwritten with 0.

> +	if (*nr_vecs == 1) {
> +		*affinity_mask = NULL;
> +		return 0;
> +	}
> +
> +	*affinity_mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +	if (!*affinity_mask)
> +		return -ENOMEM;
> +
> +	if (*nr_vecs >= num_online_cpus()) {
> +		cpumask_copy(*affinity_mask, cpu_online_mask);
> +	} else {
> +		unsigned int cpu;
> +
> +		for_each_online_cpu(cpu) {
> +			if (cpu == get_first_sibling(cpu)) {
> +				cpumask_set_cpu(cpu, *affinity_mask);
> +				vecs++;
> +			}
> +
> +			if (--(*nr_vecs) == 0)
> +				break;
> +		}
> +	}
> +
> +	*nr_vecs = vecs;

So considering (*) comment above the number of available vectors
might be unnecessarily shrunken here.

I think nr_vecs need not be an out-parameter since we always can
assign multiple vectors to a CPU. It is better than limiting number
of available vectors AFAIKT. Or you could pass one-per-cpu flag
explicitly.

> +	return 0;
> +}
> -- 
> 2.1.4
> 
