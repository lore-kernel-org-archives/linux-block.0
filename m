Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23377 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750771AbcFNVy3 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 17:54:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5ELp0O3142714
	for <linux-block@vger.kernel.org>; Tue, 14 Jun 2016 17:54:28 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jch4pd5g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 14 Jun 2016 17:54:28 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-block@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Tue, 14 Jun 2016 18:54:26 -0300
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
To: Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, gpiccoli@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 14 Jun 2016 18:54:22 -0300
MIME-Version: 1.0
In-Reply-To: <1465934346-20648-7-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57607D0E.1060907@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/14/2016 04:58 PM, Christoph Hellwig wrote:
> This is lifted from the blk-mq code and adopted to use the affinity mask
> concept just intruced in the irq handling code.

Very nice patch Christoph, thanks. There's a little typo above, on 
"intruced".

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/interrupt.h | 11 +++++++++
>   kernel/irq/Makefile       |  1 +
>   kernel/irq/affinity.c     | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 72 insertions(+)
>   create mode 100644 kernel/irq/affinity.c
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 9fcabeb..12003c0 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -278,6 +278,9 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
>   extern int
>   irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
>
> +int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs);
> +
>   #else /* CONFIG_SMP */
>
>   static inline int irq_set_affinity(unsigned int irq, const struct cpumask *m)
> @@ -308,6 +311,14 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
>   {
>   	return 0;
>   }
> +
> +static inline int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs)
> +{
> +	*affinity_mask = NULL;
> +	*nr_vecs = 1;
> +	return 0;
> +}
>   #endif /* CONFIG_SMP */
>
>   /*
> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index 2ee42e9..1d3ee31 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
>   obj-$(CONFIG_PM_SLEEP) += pm.o
>   obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
>   obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
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
> + * otherwise we map one to the first sibling of each socket.
> + *
> + * If there are more vectors than CPUs we will still only have one bit
> + * set per CPU, but interrupt code will keep on assining the vectors from
> + * the start of the bitmap until we run out of vectors.
> + */

Another little typo above in "assining".

I take this opportunity to ask you something, since I'm working in a 
related code in a specific driver - sorry in advance if my question is 
silly or if I misunderstood your code.

The function irq_create_affinity_mask() below deals with the case in 
which we have nr_vecs < num_online_cpus(); in this case, wouldn't be a 
good idea to trying distribute the vecs among cores?

Example: if we have 128 online cpus, 8 per core (meaning 16 cores) and 
64 vecs, I guess would be ideal to distribute 4 vecs _per core_, leaving 
4 CPUs in each core without vecs.

Makes sense for you?
Thanks,


Guilherme


> +int irq_create_affinity_mask(struct cpumask **affinity_mask,
> +		unsigned int *nr_vecs)
> +{
> +	unsigned int vecs = 0;
> +
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
> +	return 0;
> +}
>

