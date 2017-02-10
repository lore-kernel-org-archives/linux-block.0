Return-Path: <tglx@linutronix.de>
Date: Fri, 10 Feb 2017 12:13:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] genirq/affinity: update CPU affinity for CPU hotplug
 events
In-Reply-To: <20170203143600.32307-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1702101153401.4036@nanos>
References: <20170203143600.32307-1-hch@lst.de> <20170203143600.32307-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 3 Feb 2017, Christoph Hellwig wrote:
> @@ -127,6 +127,7 @@ enum cpuhp_state {
>  	CPUHP_AP_ONLINE_IDLE,
>  	CPUHP_AP_SMPBOOT_THREADS,
>  	CPUHP_AP_X86_VDSO_VMA_ONLINE,
> +	CPUHP_AP_IRQ_AFFINIY_ONLINE,

s/AFFINIY/AFFINITY/ perhaps?

> +static void __irq_affinity_set(unsigned int irq, struct irq_desc *desc,
> +		cpumask_t *mask)

static void __irq_affinity_set(unsigned int irq, struct irq_desc *desc,
			       cpumask_t *mask)

Please

> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	int ret;
> +
> +	if (!irqd_can_move_in_process_context(data) && chip->irq_mask)
> +		chip->irq_mask(data);
> +	ret = chip->irq_set_affinity(data, mask, true);
> +	WARN_ON_ONCE(ret);
> +
> +	/*
> +	 * We unmask if the irq was not marked masked by the core code.
> +	 * That respects the lazy irq disable behaviour.
> +	 */
> +	if (!irqd_can_move_in_process_context(data) &&
> +	    !irqd_irq_masked(data) && chip->irq_unmask)
> +		chip->irq_unmask(data);
> +}

This looks very familiar. arch/x86/kernel/irq.c comes to mind

> +
> +static void irq_affinity_online_irq(unsigned int irq, struct irq_desc *desc,
> +		unsigned int cpu)
> +{
> +	const struct cpumask *affinity;
> +	struct irq_data *data;
> +	struct irq_chip *chip;
> +	unsigned long flags;
> +	cpumask_var_t mask;
> +
> +	if (!desc)
> +		return;
> +
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +
> +	data = irq_desc_get_irq_data(desc);
> +	affinity = irq_data_get_affinity_mask(data);
> +	if (!irqd_affinity_is_managed(data) ||
> +	    !irq_has_action(irq) ||
> +	    !cpumask_test_cpu(cpu, affinity))
> +		goto out_unlock;
> +
> +	/*
> +	 * The interrupt descriptor might have been cleaned up
> +	 * already, but it is not yet removed from the radix tree
> +	 */
> +	chip = irq_data_get_irq_chip(data);
> +	if (!chip)
> +		goto out_unlock;
> +
> +	if (WARN_ON_ONCE(!chip->irq_set_affinity))
> +		goto out_unlock;
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {

You really want to allocate that _BEFORE_ locking desc->lock. GFP_KERNEL
inside the lock held region is wrong and shows that this was never tested :)

And no, we don't want GFP_ATOMIC here. You can allocate is once at the call
site and hand it in, so you avoid the alloc/free dance when iterating over
a large number of descriptors.

> +		pr_err("failed to allocate memory for cpumask\n");
> +		goto out_unlock;
> +	}
> +
> +	cpumask_and(mask, affinity, cpu_online_mask);
> +	cpumask_set_cpu(cpu, mask);
> +	if (irqd_has_set(data, IRQD_AFFINITY_SUSPENDED)) {
> +		irq_startup(desc, false);
> +		irqd_clear(data, IRQD_AFFINITY_SUSPENDED);
> +	} else {
> +		__irq_affinity_set(irq, desc, mask);
> +	}
> +
> +	free_cpumask_var(mask);
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +}



> +int irq_affinity_online_cpu(unsigned int cpu)
> +{
> +	struct irq_desc *desc;
> +	unsigned int irq;
> +
> +	for_each_irq_desc(irq, desc)
> +		irq_affinity_online_irq(irq, desc, cpu);

That lacks protection against concurrent irq setup/teardown. Wants to be
protected with irq_lock_sparse()

> +	return 0;
> +}
> +
> +static void irq_affinity_offline_irq(unsigned int irq, struct irq_desc *desc,
> +		unsigned int cpu)
> +{
> +	const struct cpumask *affinity;
> +	struct irq_data *data;
> +	struct irq_chip *chip;
> +	unsigned long flags;
> +	cpumask_var_t mask;
> +
> +	if (!desc)
> +		return;
> +
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +
> +	data = irq_desc_get_irq_data(desc);
> +	affinity = irq_data_get_affinity_mask(data);
> +	if (!irqd_affinity_is_managed(data) ||
> +	    !irq_has_action(irq) ||
> +	    irqd_has_set(data, IRQD_AFFINITY_SUSPENDED) ||
> +	    !cpumask_test_cpu(cpu, affinity))
> +		goto out_unlock;
> +
> +	/*
> +	 * Complete the irq move. This cpu is going down and for
> +	 * non intr-remapping case, we can't wait till this interrupt
> +	 * arrives at this cpu before completing the irq move.
> +	 */
> +	irq_force_complete_move(desc);

Hmm. That's what we do in x86 when the cpu is really dying, i.e. before it
really goes away. It's the last resort we have.

So if a move is pending, then you force it here and then you call
__irq_affinity_set() further down, which queues another pending move, which
then gets cleaned up in the cpu dying code.

If a move is pending, then you should first verify whether the pending
affinity mask is different from the one you are going to set. If it's the
same, you can just let the final cleanup code do its job. If not, then you
need to check whether it has something to do with the current affinity mask
or whether its completely different. Otherwise you just destroy the
previous setting which tried to move the interrupt to some other place
already.

> +	/*
> +	 * The interrupt descriptor might have been cleaned up
> +	 * already, but it is not yet removed from the radix tree
> +	 */
> +	chip = irq_data_get_irq_chip(data);
> +	if (!chip)
> +		goto out_unlock;
> +
> +	if (WARN_ON_ONCE(!chip->irq_set_affinity))
> +		goto out_unlock;
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
> +		pr_err("failed to allocate memory for cpumask\n");
> +		goto out_unlock;
> +	}

Same allocation issue.

> +
> +	cpumask_copy(mask, affinity);
> +	cpumask_clear_cpu(cpu, mask);
> +	if (cpumask_empty(mask)) {
> +		irqd_set(data, IRQD_AFFINITY_SUSPENDED);
> +		irq_shutdown(desc);
> +	} else {
> +		__irq_affinity_set(irq, desc, mask);
> +	}
> +
> +	free_cpumask_var(mask);
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +}
> +
> +int irq_affinity_offline_cpu(unsigned int cpu)
> +{
> +	struct irq_desc *desc;
> +	unsigned int irq;
> +
> +	for_each_irq_desc(irq, desc)
> +		irq_affinity_offline_irq(irq, desc, cpu);

Same protection issue.

Thanks,

	tglx
