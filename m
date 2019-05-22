Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCDC18E7D
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB9E217D9
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfEVJrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 05:47:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVJrw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 05:47:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54D8DAF10;
        Wed, 22 May 2019 09:47:50 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
 <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1deeda32-eac2-9056-f17b-3a643e671374@suse.de>
Date:   Wed, 22 May 2019 11:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/19 11:06 AM, John Garry wrote:
>>>>
>>>> +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct 
>>>> hlist_node *node)
>>>> +{
>>>> +    struct blk_mq_hw_ctx    *hctx;
>>>> +    struct blk_mq_tags    *tags;
>>>> +
>>>> +    hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
>>>> +    tags = hctx->tags;
>>>> +
>>>> +    if (tags)
>>>> +        clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
>>>> +
>>>
>>> Hi Ming,
>>>
>>> Thanks for the effort here.
>>>
>>> I would like to make an assertion on a related topic, which I hope 
>>> you can
>>> comment on:
>>>
>>> For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu
>>> masks) for a request queue are required to match the hw queues used 
>>> in the
>>> LLDD (if using managed interrupts).
>>>
>>> In others words, a SCSI LLDD needs to expose all hw queues for this 
>>> to work.
>>>
More importantly, the SCSI LLDD needs to be _able_ to expose one hw 
queue per CPU.
Which cannot be taken for granted; especially in larger machines it's 
relatively easy to have more CPUs than MSI-X vectores...

>>> The reason I say this is because if the LLDD does not expose the hw 
>>> queues
>>> and manages them internally - as some SCSI LLDDs do - yet uses managed
>>> interrupts to spread the hw queue MSI vectors across all CPUs, then 
>>> we still
>>> only have a single blk_mq_hw_ctx per rq with a cpumask covering all 
>>> cpus,
>>> which is not what we would want.
>>
> 
> Hi Ming,
> 
>> Good catch!
>>
>> This drain mechanism won't address the issue for these SCSI LLDDs in 
>> which:
>>
>>     1) blk_mq_hw_ctx serves as submission hw queue
>>
>>     2) one private reply queue serves as completion queue, for which one
>>     MSI vector with cpumask is setup via 
>> pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY).
>>
>> What we should only drain is the completion queue if all its mapped
>> CPUs are offline.
>>
Hmm. That's a very unusual setup. Typically it's the other way round; 
SCSI LLDDs have several completion queues (as these are mapped to MSI-X 
vectors), but only one submission queue.
(Classical examples are mptsas, megaraid_sas, aacraid, and hpsa)

But I still do think we need to handle this case; the HBA might not 
expose enough MSI-X vectors/hw queues for us to map to all CPUs.
In which case we'd be running into the same situation.

And I do think we _need_ to drain the associated completion queue as 
soon as _any_ CPU in that set it plugged; otherwise we can't ensure that 
any interrupt for pending I/O will _not_ arrive at the dead CPU.

And yes, this would amount to quiesce the HBA completely if only one 
queue is exposed. But there's no way around this; the alternative would 
be to code a fallback patch in each driver to catch missing completions.
Which would actually be an interface change, requiring each vendor / 
maintainer to change their driver. Not very nice.

>> Looks you suggest to expose all completion(reply) queues as 'struct 
>> blk_mq_hw_ctx',
>> which may involve in another more hard problem:  how to split the single
>> hostwide tags into each reply queue.
> 
> Yes, and this is what I expecting to hear Re. hostwide tags.
> 
But this case is handled already; things like lpfc and qla2xxx have been 
converted to this model (exposing all hw queues, and use a host-wide 
tagmap).

So from that side there is not really an issue.

I even provided patchset to convert megaraid_sas (cf 'megaraid_sas: 
enable blk-mq for fusion'); you might want to have a look there to see 
how it can be done.

> I'd rather not work towards that
>> direction because:
>>
>> 1) it is very hard to partition global resources into several parts,
>> especially it is hard to make every part happy.
>>
>> 2) sbitmap is smart/efficient enough for this global allocation
>>
>> 3) no obvious improvement is obtained from the resource partition, 
>> according
>> to previous experiment result done by Kashyap.
> 
> I'd like to also do the test.
> 
> However I would need to forward port the patchset, which no longer 
> cleanly applies (I was referring to this 
> https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/). 
> Any help with that would be appreciated.
> 
If you would post it on the mailing list (or send it to me) I can have a 
look. Converting SAS is on my list of things to do, anyway.

>>
>> I think we could implement the drain mechanism in the following way:
>>
>> 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
>> approach in the patch
> 
> Maybe the gain of exposing multiple queues+managed interrupts outweighs 
> the loss in the LLDD of having to generate this unique tag with sbitmap; 
> I know that we did not use sbitmap ever in the LLDD for generating the 
> tag when testing previously. However I'm still not too hopeful.
> 
Thing is, the tag _is_ already generated by the time the command is 
passed to the LLDD. So there is no overhead; you just need to establish 
a 1:1 mapping between SCSI cmds from the midlayer and your internal 
commands.

Which is where the problem starts: if you have to use the same command 
pool for internal commands you have to set some tags aside to avoid a 
clash with the tags generated from the block layer.
That's easily done, but if you do that quiescing is getting harder, as 
then the block layer wouldn't know about these internal commands.
This is what I'm trying to address with my patchset to use private tags 
in SCSI, as then the block layer maintains all tags, and is able to 
figure out if the queue really is quiesced.
(And I really need to post my patchset).

>>
>> 2) otherwise:
>> - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
>> 'struct blk_mq_ops'
> 
> This would not be allowed to block, right?
> 
>>
>> - call .prep_queue_dead from blk_mq_hctx_notify_dead()
>>
>> 3) inside .prep_queue_dead():
>> - the driver checks if all mapped CPU on the completion queue is offline
>> - if yes, wait for in-flight requests originated from all CPUs mapped to
>> this completion queue, and it can be implemented as one block layer API
> 
> That could work. However I think that someone may ask why the LLDD just 
> doesn't register for the CPU hotplug event itself (which I would really 
> rather avoid), instead of being relayed the info from the block layer.
> 
Again; what would you do if not all CPUs from a pool are gone?
You still might be getting interrupts for non-associated interrupts, and 
quite some drivers are unhappy under these circumstances.
Hence I guess it'll be better to quiesce the queue as soon as _any_ CPU 
from the pool is gone.

Plus we could be doing this from the block layer without any callbacks 
from the driver...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
