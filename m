Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419DC28CC2
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A782070D
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 09:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2JmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 05:42:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfE2JmM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 05:42:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D7B3487BFBF343E4681;
        Wed, 29 May 2019 17:42:10 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
 17:42:08 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on CPU
 unplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com>
 <20190529022852.GA21398@ming.t460p> <20190529024200.GC21398@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <linux-scsi@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Message-ID: <5bc07fd5-9d2b-bf9c-eb77-b8cebadb9150@huawei.com>
Date:   Wed, 29 May 2019 10:42:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190529024200.GC21398@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/05/2019 03:42, Ming Lei wrote:
> On Wed, May 29, 2019 at 10:28:52AM +0800, Ming Lei wrote:
>> On Tue, May 28, 2019 at 05:50:40PM +0100, John Garry wrote:
>>> On 27/05/2019 16:02, Ming Lei wrote:
>>>> Managed interrupts can not migrate affinity when their CPUs are offline.
>>>> If the CPU is allowed to shutdown before they're returned, commands
>>>> dispatched to managed queues won't be able to complete through their
>>>> irq handlers.
>>>>
>>>> Wait in cpu hotplug handler until all inflight requests on the tags
>>>> are completed or timeout. Wait once for each tags, so we can save time
>>>> in case of shared tags.
>>>>
>>>> Based on the following patch from Keith, and use simple delay-spin
>>>> instead.
>>>>
>>>> https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
>>>>
>>>> Some SCSI devices may have single blk_mq hw queue and multiple private
>>>> completion queues, and wait until all requests on the private completion
>>>> queue are completed.
>>>
>>> Hi Ming,
>>>
>>> I'm a bit concerned that this approach won't work due to ordering: it seems
>>> that the IRQ would be shutdown prior to the CPU dead notification for the
>>
>> Managed IRQ shutdown is run in irq_migrate_all_off_this_cpu(), which is
>> called in the callback of takedown_cpu(). And the CPU dead notification
>> is always sent after that CPU becomes offline, see cpuhp_invoke_callback().
>
> Hammm, looks we both say same thing.
>
> Yeah, it is too late to drain requests in the cpu hotplug DEAD handler,
> maybe we can try to move managed IRQ shutdown after sending the dead
> notification.
>

Even if the IRQ is shutdown later, all CPUs would still be dead, so none 
available to receive the interrupt or do the work for draining the queue.

> I need to think of it further.

It would seem that we just need to be informed of CPU offlining earlier, 
and plug the drain in there.

>

Cheers,
John

> Thanks,
> Ming
>
> .
>


