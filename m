Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C07C282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE202217F9
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 12:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfEVMVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 08:21:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729018AbfEVMVd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 08:21:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4025A92D0AA14AA23F07;
        Wed, 22 May 2019 20:21:30 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 May 2019
 20:21:22 +0800
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20190517091424.19751-1-ming.lei@redhat.com>
 <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
 <20190522015620.GA11959@ming.t460p>
 <ce014369-4bf2-55fe-3c0f-3a46d3a016dc@huawei.com>
 <20190522100139.GA16877@ming.t460p>
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
Message-ID: <4baa342b-4933-8b01-406a-6bd8b79f2251@huawei.com>
Date:   Wed, 22 May 2019 13:21:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190522100139.GA16877@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I'd rather not work towards that
>>> direction because:
>>>
>>> 1) it is very hard to partition global resources into several parts,
>>> especially it is hard to make every part happy.
>>>
>>> 2) sbitmap is smart/efficient enough for this global allocation
>>>
>>> 3) no obvious improvement is obtained from the resource partition, according
>>> to previous experiment result done by Kashyap.
>>
>> I'd like to also do the test.
>>
>> However I would need to forward port the patchset, which no longer cleanly
>> applies (I was referring to this https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/).
>> Any help with that would be appreciated.
>
> The queue type change causes patches not applied any more.
>
> Could you just test the patch against v4.15 and see if there is any
> improvement?
>

I'd rather test against latest mainline, but if it is too difficult then 
I can backport LLDD stuff and test against 4.15. It may take a while.

> Even if it may improve performance on hisi_sas, I still suggest to not
> use that approach to solve the issue for draining in-flight requests when
> all CPUs of one hw queue becomes offline, since this way might hurt
> performance on other drivers.
>
>>
>>>
>>> I think we could implement the drain mechanism in the following way:
>>>
>>> 1) if 'struct blk_mq_hw_ctx' serves as completion queue, use the
>>> approach in the patch
>>
>> Maybe the gain of exposing multiple queues+managed interrupts outweighs the
>> loss in the LLDD of having to generate this unique tag with sbitmap; I know
>
> The unique tag has zero cost, see blk_mq_unique_tag().

But we want a tag unique in range [0, host tag count), which 
blk_mq_unique_tag() does not provide.

>
>> that we did not use sbitmap ever in the LLDD for generating the tag when
>> testing previously. However I'm still not too hopeful.
>>
>>>
>>> 2) otherwise:
>>> - introduce one callbcack of .prep_queue_dead(hctx, down_cpu) to
>>> 'struct blk_mq_ops'
>>
>> This would not be allowed to block, right?
>
> It is allowed to block in CPU hotplug handler.
>
>>
>>>
>>> - call .prep_queue_dead from blk_mq_hctx_notify_dead()
>>>
>>> 3) inside .prep_queue_dead():
>>> - the driver checks if all mapped CPU on the completion queue is offline
>>> - if yes, wait for in-flight requests originated from all CPUs mapped to
>>> this completion queue, and it can be implemented as one block layer API
>>
>> That could work. However I think that someone may ask why the LLDD just
>> doesn't register for the CPU hotplug event itself (which I would really
>> rather avoid), instead of being relayed the info from the block layer.
>
> .prep_queue_dead() is run from blk-mq's CPU hotplug handler.
>
> I also think of abstracting completion queue in blk-mq for hpsa,
> hisi_sas_v3_hw and  mpt3sas, but that can't cover to drain device's internal
> command, so looks it is inevitable for us to introduce driver callback.
>

On topic of internal commands, I assume that the approach would be to 
reserve tags in blk_mq_tag_set.reserved_tags (currently not set in 
scsi_mq_setup_tags()), and the LLDD would use 
blk_mq_alloc_request(,,BLK_MQ_REQ_RESERVED) to get a tag.

I guess that this may be Hannes' idea also (see "as then the block layer 
maintains all tags, and is able to figure out if the queue really is 
quiesced").

Thanks,
John

>
> Thanks,
> Ming
>
> .
>


