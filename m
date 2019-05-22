Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B36C18E7D
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5496205ED
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 09:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfEVJGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 05:06:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVJGb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 05:06:31 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD56D1C4D3E07277C8FF;
        Wed, 22 May 2019 17:06:29 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 May 2019
 17:06:22 +0800
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
Date:   Wed, 22 May 2019 10:06:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190522015620.GA11959@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>>
>>> +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
>>> +{
>>> +	struct blk_mq_hw_ctx	*hctx;
>>> +	struct blk_mq_tags	*tags;
>>> +
>>> +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
>>> +	tags = hctx->tags;
>>> +
>>> +	if (tags)
>>> +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
>>> +
>>
>> Hi Ming,
>>
>> Thanks for the effort here.
>>
>> I would like to make an assertion on a related topic, which I hope you can
>> comment on:
>>
>> For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu
>> masks) for a request queue are required to match the hw queues used in the
>> LLDD (if using managed interrupts).
>>
>> In others words, a SCSI LLDD needs to expose all hw queues for this to work.
>>
>> The reason I say this is because if the LLDD does not expose the hw queues
>> and manages them internally - as some SCSI LLDDs do - yet uses managed
>> interrupts to spread the hw queue MSI vectors across all CPUs, then we still
>> only have a single blk_mq_hw_ctx per rq with a cpumask covering all cpus,
>> which is not what we would want.
>

Hi Ming,

> Good catch!
>
> This drain mechanism won't address the issue for these SCSI LLDDs in which:
>
> 	1) blk_mq_hw_ctx serves as submission hw queue
>
> 	2) one private reply queue serves as completion queue, for which one
> 	MSI vector with cpumask is setup via pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY).
>
> What we should only drain is the completion queue if all its mapped
> CPUs are offline.
>
> Looks you suggest to expose all completion(reply) queues as 'struct blk_mq_hw_ctx',
> which may involve in another more hard problem:  how to split the single
> hostwide tags into each reply queue.

Yes, and this is what I expecting to hear Re. hostwide tags.

I'd rather not work towards that
> direction because:
>
> 1) it is very hard to partition global resources into several parts,
> especially it is hard to make every part happy.
>
> 2) sbitmap is smart/efficient enough for this global allocation
>
> 3) no obvious improvement is obtained from the resource partition, according
> to previous experiment result done by Kashyap.

I'd like to also do the test.

However I would need to forward port the patchset, which no longer 
cleanly applies (I was referring to this 
https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/). 
Any help with that would be appreciated.

>
> I think we could implement the drain mechanism in the following way:
>
> 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
> approach in the patch

Maybe the gain of exposing multiple queues+managed interrupts outweighs 
the loss in the LLDD of having to generate this unique tag with sbitmap; 
I know that we did not use sbitmap ever in the LLDD for generating the 
tag when testing previously. However I'm still not too hopeful.

>
> 2) otherwise:
> - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
> 'struct blk_mq_ops'

This would not be allowed to block, right?

>
> - call .prep_queue_dead from blk_mq_hctx_notify_dead()
>
> 3) inside .prep_queue_dead():
> - the driver checks if all mapped CPU on the completion queue is offline
> - if yes, wait for in-flight requests originated from all CPUs mapped to
> this completion queue, and it can be implemented as one block layer API

That could work. However I think that someone may ask why the LLDD just 
doesn't register for the CPU hotplug event itself (which I would really 
rather avoid), instead of being relayed the info from the block layer.

>
> Any comments on the above approach?
>
> Thanks,
> Ming

Cheers,
John

>
> .
>


