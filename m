Return-Path: <tglx@linutronix.de>
Date: Sun, 18 Jun 2017 01:14:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set
 helper
In-Reply-To: <20170603140403.27379-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706180111280.2428@nanos>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +
> +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)
> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	bool ret = false;
> +
> +	if (!irq_can_move_pcntxt(data) && chip->irq_mask)
> +		chip->irq_mask(data);
> +
> +	if (chip->irq_set_affinity) {
> +		if (chip->irq_set_affinity(data, mask, true) == -ENOSPC)
> +			pr_crit("IRQ %d set affinity failed because there are no available vectors.  The device assigned to this IRQ is unstable.\n", irq);
> +		ret = true;
> +	}
> +
> +	/*
> +	 * We unmask if the irq was not marked masked by the core code.
> +	 * That respects the lazy irq disable behaviour.
> +	 */
> +	if (!irq_can_move_pcntxt(data) &&
> +	    !irqd_irq_masked(data) && chip->irq_unmask)
> +		chip->irq_unmask(data);
> +
> +	return ret;
> +}

That needs even more care as this does not include the handling for move in
progress, which will make your affinity setting fail.

Ideally we include that managed shutdown magic into fixup_irqs(), but
that's arch specific. So that needs the long dragged out update to the
generic irq cpuhotplug code to handle the x86'isms proper.

Thanks,

	tglx
