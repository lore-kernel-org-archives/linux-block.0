Return-Path: <tglx@linutronix.de>
Date: Fri, 16 Jun 2017 14:00:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set
 helper
In-Reply-To: <alpine.DEB.2.20.1706161306070.2254@nanos>
Message-ID: <alpine.DEB.2.20.1706161357380.2254@nanos>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-4-hch@lst.de> <alpine.DEB.2.20.1706161306070.2254@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 16 Jun 2017, Thomas Gleixner wrote:
> On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> > +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)
> > +{
> > +	struct irq_data *data = irq_desc_get_irq_data(desc);
> > +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	bool ret = false;
> > +
> > +	if (!irq_can_move_pcntxt(data) && chip->irq_mask)
> > +		chip->irq_mask(data);
> > +
> > +	if (chip->irq_set_affinity) {
> > +		if (chip->irq_set_affinity(data, mask, true) == -ENOSPC)
> > +			pr_crit("IRQ %d set affinity failed because there are no available vectors.  The device assigned to this IRQ is unstable.\n", irq);
> > +		ret = true;
> > +	}
> > +
> > +	/*
> > +	 * We unmask if the irq was not marked masked by the core code.
> > +	 * That respects the lazy irq disable behaviour.
> > +	 */
> > +	if (!irq_can_move_pcntxt(data) &&
> > +	    !irqd_irq_masked(data) && chip->irq_unmask)
> > +		chip->irq_unmask(data);
> 
> There is another issue with this. Nothing updates the affinity mask in
> irq_desc, when we just invoke the chip callback. Let me have a look.

Indeed. So that magic you do in the next patches (the hotplug callbacks)
only work proper for affinity masks with a single cpu set.

The problem is that we don't have a distinction between the 'possible'
(e.g. set by /proc/irq/affinity) and the effective affinity mask.

Needs more thought.

Thanks,

	tglx
