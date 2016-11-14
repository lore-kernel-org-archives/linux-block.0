Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 3/3] irq-poll: Reduce local_irq_save/restore operations in
 irq_poll_softirq
To: Christoph Hellwig <hch@lst.de>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
 <1478991755-28153-4-git-send-email-sagi@grimberg.me>
 <20161113151802.GD7578@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7f053596-0173-b3c7-a81e-8e3809ad5bac@grimberg.me>
Date: Mon, 14 Nov 2016 03:02:42 +0200
MIME-Version: 1.0
In-Reply-To: <20161113151802.GD7578@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

>> +	while (!list_empty(&list)) {
>
> Maybe do a list_first_entry_or_null here if you're touching the list
> iteration anyway?

I can do that.

>> +	local_irq_disable();
>> +	list_splice_tail_init(iop_list, &list);
>> +	list_splice(&list, iop_list);
>> +
>>  	if (rearm)
>>  		__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
>
> Maybe check if we have a non-empty list before disabling irqs?

Which list? the local list? do in case the local list is empty
but iop_list isn't another irq_poll_sched() already raised a
softirq?

> Also that list_emtpy check can replace the rearm condition - we only
> set the rearm flag if we break with a non-empty local list now.

You're right.
