Return-Path: <tglx@linutronix.de>
Date: Fri, 16 Jun 2017 12:23:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set
 helper
In-Reply-To: <20170603140403.27379-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706161221250.2254@nanos>
References: <20170603140403.27379-1-hch@lst.de> <20170603140403.27379-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +
> +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)

This should be named irq_affinity_force() because it circumvents the 'move
in irq context' mechanism. I'll do that myself. No need to resend.

Thanks,

	tglx
