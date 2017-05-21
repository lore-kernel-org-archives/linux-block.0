Return-Path: <tglx@linutronix.de>
Date: Sun, 21 May 2017 21:03:06 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] genirq/affinity: factor out a irq_affinity_set
 helper
In-Reply-To: <20170519085756.29742-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1705212052000.3023@nanos>
References: <20170519085756.29742-1-hch@lst.de> <20170519085756.29742-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 19 May 2017, Christoph Hellwig wrote:

> Factor out code from the x86 cpu hot plug code to program the affinity
> for a vector for a hot plug / hot unplug event.
> +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)
> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	bool ret = false;
> +
> +	if (!irqd_can_move_in_process_context(data) && chip->irq_mask)

Using that inline directly will make this function useless on architectures
which have GENERIC_PENDING_IRQS not set.

kernel/irq/manage.c has that wrapped. We need to move those wrappers to the
internal header file, so that it gets compiled out on other platforms.

Thanks,

	tglx
