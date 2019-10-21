Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5837CA9EB9
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68CD2070B
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfJUJrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:47:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJrT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:47:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 118BCA8D25C0E97483D5;
        Mon, 21 Oct 2019 17:47:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 17:47:10 +0800
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <20191021093448.GA22635@ming.t460p>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
Date:   Mon, 21 Oct 2019 10:47:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191021093448.GA22635@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/10/2019 10:34, Ming Lei wrote:
> On Mon, Oct 21, 2019 at 10:19:18AM +0100, John Garry wrote:
>> On 20/10/2019 11:14, Ming Lei wrote:
>>>>> ght? If so, I need to find some simple sysfs entry to
>>>>>>> tell me of this occurrence, to trigger the capture. Or add something. My
>>>>>>> script is pretty dump.
>>>>>>>
>>>>>>> BTW, I did notice that we the dump_stack in __blk_mq_run_hw_queue()
>>>>>>> pretty soon before the problem happens - maybe a clue or maybe coincidence.
>>>>>>>
>>>>>
>>>>> I finally got to capture that debugfs dump at the point the SCSI IOs
>>>>> timeout, as attached. Let me know if any problem receiving it.
>>>>>
>>>>> Here's a kernel log snippet at that point (I added some print for the
>>>>> timeout):
>>>>>
>>>>> 609] psci: CPU6 killed.
>>>>> [  547.722217] CPU5: shutdown
>>>>> [  547.724926] psci: CPU5 killed.
>>>>> [  547.749951] irq_shutdown
>>>>> [  547.752701] IRQ 800: no longer affine to CPU4
>>>>> [  547.757265] CPU4: shutdown
>>>>> [  547.759971] psci: CPU4 killed.
>>>>> [  547.790348] CPU3: shutdown
>>>>> [  547.793052] psci: CPU3 killed.
>>>>> [  547.818330] CPU2: shutdown
>>>>> [  547.821033] psci: CPU2 killed.
>>>>> [  547.854285] CPU1: shutdown
>>>>> [  547.856989] psci: CPU1 killed.
>>>>> [  575.925307] scsi_timeout req=0xffff0023b0dd9c00 reserved=0
>>>>> [  575.930794] scsi_timeout req=0xffff0023b0df2700 reserved=0
>>>> From the debugfs log, 66 requests are dumped, and 63 of them has
>>> been submitted to device, and the other 3 is in ->dispatch list
>>> via requeue after timeout is handled.
>>>
>>
>> Hi Ming,
>>
>>> You mentioned that:
>>>
>>> " - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for when
>>>  inflights rqs !=0, and I don't see them for this timeout"
>>>
>>> There might be two reasons:
>>>
>>> 1) You are still testing a multiple reply-queue device?
>>
>> As before, I am testing by exposing mutliple queues to the SCSI midlayer. I
>> had to make this change locally, as on mainline we still only expose a
>> single queue and use the internal reply queue when enabling managed
>> interrupts.
>>
>> As I
>>> mentioned last times, it is hard to map reply-queue into blk-mq
>>> hctx correctly.
>>
>> Here's my branch, if you want to check:
>>
>> https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq-v4
>>
>> It's a bit messy (sorry), but you can see that the reply-queue in the LLDD
>> is removed in commit 087b95af374.
>>
>> I am now thinking of actually making this change to the LLDD in mainline to
>> avoid any doubt in future.
>
> As I mentioned last time, you do share tags among all MQ queues on your hardware
> given your hardware is actually SQ HBA, so commit 087b95af374 is definitely
> wrong, isn't it?
>

Yes, we share tags among all queues, but we generate the tag - known as 
IPTT - in the LLDD now, as we can no longer use the request tag (as it 
is not unique per all queues):

https://github.com/hisilicon/kernel-dev/commit/087b95af374be6965583c1673032fb33bc8127e8#diff-f5d8fff19bc539a7387af5230d4e5771R188

As I said, the branch is messy and I did have to fix 087b95af374.

> It can be very hard to partition the single tags among multiple hctx.
>

I really do think now that I'll make this change on mainline to avoid 
doubt...

Thanks,
John

>
> Thanks,
> Ming
>
>
> .
>


