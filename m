Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4202CA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A8420717
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 09:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJ2JW3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:22:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2059 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727263AbfJ2JW2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 05:22:28 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 6352B267BE2DE53C6595;
        Tue, 29 Oct 2019 09:22:27 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Oct 2019 09:22:27 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 09:22:26 +0000
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
 <20191028104238.GA14008@ming.t460p>
 <a5e25466-c4db-c254-be37-45a9ca85851c@huawei.com>
 <20191029015009.GD22088@ming.t460p>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a5a7c039-ff1b-b898-884d-f415318ccb7f@huawei.com>
Date:   Tue, 29 Oct 2019 09:22:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191029015009.GD22088@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/10/2019 01:50, Ming Lei wrote:
> On Mon, Oct 28, 2019 at 11:55:42AM +0000, John Garry wrote:
>>>>
>>>> For the SCSI commands which timeout, I notice that
>>>> scsi_set_blocked(reason=SCSI_MLQUEUE_EH_RETRY) was called 30 seconds
>>>> earlier.
>>>>
>>>>    scsi_set_blocked+0x20/0xb8
>>>>    __scsi_queue_insert+0x40/0x90
>>>>    scsi_softirq_done+0x164/0x1c8
>>>>    __blk_mq_complete_request_remote+0x18/0x20
>>>>    flush_smp_call_function_queue+0xa8/0x150
>>>>    generic_smp_call_function_single_interrupt+0x10/0x18
>>>>    handle_IPI+0xec/0x1a8
>>>>    arch_cpu_idle+0x10/0x18
>>>>    do_idle+0x1d0/0x2b0
>>>>    cpu_startup_entry+0x24/0x40
>>>>    secondary_start_kernel+0x1b4/0x208
>>>
>>> Could you investigate a bit the reason why timeout is triggered?
>>
>> Yeah, it does seem a strange coincidence that the SCSI command even failed
>> and we have to retry, since these should be uncommon events. I'll check on
>> this LLDD error.
>>
>>>
>>> Especially we suppose to drain all in-flight requests before the
>>> last CPU of this hctx becomes offline, and it shouldn't be caused by
>>> the hctx becoming dead, so still need you to confirm that all
>>> in-flight requests are really drained in your test.
>>
>> ok
>>
>> Or is it still
>>> possible to dispatch to LDD after BLK_MQ_S_INTERNAL_STOPPED is set?
>>
>> It shouldn't be. However it would seem that this IO had been dispatched to
>> the LLDD, the hctx dies, and then we attempt to requeue on that hctx.
> 
> But this patch does wait for completion of in-flight request before
> shutdown the last CPU of this hctx.
> 

Hi Ming,

It may actually be a request from a hctx which is not shut down which 
errors and causes the time out. I'm still checking.

BTW, Can you let me know exactly where you want the debug for "Or 
blk_mq_hctx_next_cpu() may still run WORK_CPU_UNBOUND schedule after
all CPUs are offline, could you add debug message in that branch?"

Thanks,
John

> 
> Thanks,
> Ming
> 
> .
> 

