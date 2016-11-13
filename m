Return-Path: <hch@lst.de>
Date: Sun, 13 Nov 2016 16:18:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] irq-poll: Reduce local_irq_save/restore operations
	in irq_poll_softirq
Message-ID: <20161113151802.GD7578@lst.de>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me> <1478991755-28153-4-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478991755-28153-4-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

> +	while (!list_empty(&list)) {

Maybe do a list_first_entry_or_null here if you're touching the list
iteration anyway?

> +	local_irq_disable();
> +	list_splice_tail_init(iop_list, &list);
> +	list_splice(&list, iop_list);
> +
>  	if (rearm)
>  		__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);

Maybe check if we have a non-empty list before disabling irqs?
Also that list_emtpy check can replace the rearm condition - we only
set the rearm flag if we break with a non-empty local list now.
