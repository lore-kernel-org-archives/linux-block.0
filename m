Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49082C282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23616217F9
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfEVMau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 08:30:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfEVMau (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 08:30:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 436B4B160C86D6305229;
        Wed, 22 May 2019 20:30:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 May 2019
 20:30:38 +0800
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
 <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
 <1deeda32-eac2-9056-f17b-3a643e671374@suse.de>
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
Message-ID: <11bb0171-d5a2-1faa-6fd6-6204b5a56cfc@huawei.com>
Date:   Wed, 22 May 2019 13:30:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1deeda32-eac2-9056-f17b-3a643e671374@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> But I still do think we need to handle this case; the HBA might not
> expose enough MSI-X vectors/hw queues for us to map to all CPUs.
> In which case we'd be running into the same situation.
>
> And I do think we _need_ to drain the associated completion queue as
> soon as _any_ CPU in that set it plugged; otherwise we can't ensure that
> any interrupt for pending I/O will _not_ arrive at the dead CPU.

Really? I did not think that it was possible for this to happen.

>
> And yes, this would amount to quiesce the HBA completely if only one
> queue is exposed. But there's no way around this; the alternative would
> be to code a fallback patch in each driver to catch missing completions.
> Which would actually be an interface change, requiring each vendor /
> maintainer to change their driver. Not very nice.
>
>>> Looks you suggest to expose all completion(reply) queues as 'struct
>>> blk_mq_hw_ctx',
>>> which may involve in another more hard problem:  how to split the single
>>> hostwide tags into each reply queue.
>>
>> Yes, and this is what I expecting to hear Re. hostwide tags.
>>
> But this case is handled already; things like lpfc and qla2xxx have been
> converted to this model (exposing all hw queues, and use a host-wide
> tagmap).
>
> So from that side there is not really an issue.
>
> I even provided patchset to convert megaraid_sas (cf 'megaraid_sas:
> enable blk-mq for fusion'); you might want to have a look there to see
> how it can be done.

ok, I'll have a search.

>
>> I'd rather not work towards that
>>> direction because:
>>>
>>> 1) it is very hard to partition global resources into several parts,
>>> especially it is hard to make every part happy.
>>>
>>> 2) sbitmap is smart/efficient enough for this global allocation
>>>
>>> 3) no obvious improvement is obtained from the resource partition,
>>> according
>>> to previous experiment result done by Kashyap.
>>
>> I'd like to also do the test.
>>
>> However I would need to forward port the patchset, which no longer
>> cleanly applies (I was referring to this
>> https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/).
>> Any help with that would be appreciated.
>>
> If you would post it on the mailing list (or send it to me) I can have a
> look. Converting SAS is on my list of things to do, anyway.
>

ok

>>>
>>> I think we could implement the drain mechanism in the following way:
>>>
>>> 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
>>> approach in the patch
>>
>> Maybe the gain of exposing multiple queues+managed interrupts
>> outweighs the loss in the LLDD of having to generate this unique tag
>> with sbitmap; I know that we did not use sbitmap ever in the LLDD for
>> generating the tag when testing previously. However I'm still not too
>> hopeful.
>>
> Thing is, the tag _is_ already generated by the time the command is
> passed to the LLDD. So there is no overhead; you just need to establish
> a 1:1 mapping between SCSI cmds from the midlayer and your internal
> commands.
>
> Which is where the problem starts: if you have to use the same command
> pool for internal commands you have to set some tags aside to avoid a
> clash with the tags generated from the block layer.
> That's easily done, but if you do that quiescing is getting harder, as
> then the block layer wouldn't know about these internal commands.
> This is what I'm trying to address with my patchset to use private tags
> in SCSI, as then the block layer maintains all tags, and is able to
> figure out if the queue really is quiesced.
> (And I really need to post my patchset).

Ack

>
>>>
>>> 2) otherwise:
>>> - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
>>> 'struct blk_mq_ops'
>>
>> This would not be allowed to block, right?
>>
>>>
>>> - call .prep_queue_dead from blk_mq_hctx_notify_dead()
>>>
>>> 3) inside .prep_queue_dead():
>>> - the driver checks if all mapped CPU on the completion queue is offline
>>> - if yes, wait for in-flight requests originated from all CPUs mapped to
>>> this completion queue, and it can be implemented as one block layer API
>>
>> That could work. However I think that someone may ask why the LLDD
>> just doesn't register for the CPU hotplug event itself (which I would
>> really rather avoid), instead of being relayed the info from the block
>> layer.
>>
> Again; what would you do if not all CPUs from a pool are gone?
> You still might be getting interrupts for non-associated interrupts, and
> quite some drivers are unhappy under these circumstances.
> Hence I guess it'll be better to quiesce the queue as soon as _any_ CPU
> from the pool is gone.
>
> Plus we could be doing this from the block layer without any callbacks
> from the driver...
>
> Cheers,
>
> Hannes

Thanks,
John



