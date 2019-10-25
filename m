Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D5CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7394021872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfJYQdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:33:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbfJYQdi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:33:38 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E71DCCD0A5CB995C046A;
        Fri, 25 Oct 2019 17:33:36 +0100 (IST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 25 Oct 2019 17:33:36 +0100
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 25 Oct
 2019 17:33:36 +0100
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
From:   John Garry <john.garry@huawei.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
Message-ID: <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
Date:   Fri, 25 Oct 2019 17:33:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> There might be two reasons:
>>
>> 1) You are still testing a multiple reply-queue device?
> 
> As before, I am testing by exposing mutliple queues to the SCSI 
> midlayer. I had to make this change locally, as on mainline we still 
> only expose a single queue and use the internal reply queue when 
> enabling managed interrupts.
> 
> As I
>> mentioned last times, it is hard to map reply-queue into blk-mq
>> hctx correctly.
> 
> Here's my branch, if you want to check:
> 
> https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-mq-v4
> 
> It's a bit messy (sorry), but you can see that the reply-queue in the 
> LLDD is removed in commit 087b95af374.
> 
> I am now thinking of actually making this change to the LLDD in mainline 
> to avoid any doubt in future.
> 
>>
>> 2) concurrent dispatch to device, which can be observed by the
>> following patch.
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 06081966549f..3590f6f947eb 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -679,6 +679,8 @@ void blk_mq_start_request(struct request *rq)
>>  {
>>         struct request_queue *q = rq->q;
>>
>> +       WARN_ON_ONCE(test_bit(BLK_MQ_S_INTERNAL_STOPPED, 
>> &rq->mq_hctx->state));
>> +
>>         trace_block_rq_issue(q, rq);
>>
>>         if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
>>
>> However, I think it is hard to be 2#, since the current CPU is the last
>> CPU in hctx->cpu_mask.
>>
> 
> I'll try it.
> 

Hi Ming,

I am looking at this issue again.

I am using 
https://lore.kernel.org/linux-scsi/1571926881-75524-1-git-send-email-john.garry@huawei.com/T/#t 
with expose_mq_experimental set. I guess you're going to say that this 
series is wrong, but I think it's ok for this purpose.

Forgetting that for a moment, maybe I have found an issue.

For the SCSI commands which timeout, I notice that 
scsi_set_blocked(reason=SCSI_MLQUEUE_EH_RETRY) was called 30 seconds 
earlier.

  scsi_set_blocked+0x20/0xb8
  __scsi_queue_insert+0x40/0x90
  scsi_softirq_done+0x164/0x1c8
  __blk_mq_complete_request_remote+0x18/0x20
  flush_smp_call_function_queue+0xa8/0x150
  generic_smp_call_function_single_interrupt+0x10/0x18
  handle_IPI+0xec/0x1a8
  arch_cpu_idle+0x10/0x18
  do_idle+0x1d0/0x2b0
  cpu_startup_entry+0x24/0x40
  secondary_start_kernel+0x1b4/0x208

I also notice that the __scsi_queue_insert() call, above, seems to retry 
to requeue the request on a dead rq in calling 
__scsi_queue_insert()->blk_mq_requeue_requet()->__blk_mq_requeue_request(), 
***:

[ 1185.235243] psci: CPU1 killed.
[ 1185.238610] blk_mq_hctx_notify_dead cpu1 dead 
request_queue=0xffff0023ace24f60 (id=19)
[ 1185.246530] blk_mq_hctx_notify_dead cpu1 dead 
request_queue=0xffff0023ace23f80 (id=17)
[ 1185.254443] blk_mq_hctx_notify_dead cpu1 dead 
request_queue=0xffff0023ace22fa0 (id=15)
[ 1185.262356] blk_mq_hctx_notify_dead cpu1 dead 
request_queue=0xffff0023ace21fc0 (id=13)***
[ 1185.270271] blk_mq_hctx_notify_dead cpu1 dead 
request_queue=0xffff0023ace20fe0 (id=11)
[ 1185.939451] scsi_softirq_done NEEDS_RETRY rq=0xffff0023b7416000
[ 1185.945359] scsi_set_blocked reason=0x1057
[ 1185.949444] __blk_mq_requeue_request request_queue=0xffff0023ace21fc0 
id=13 rq=0xffff0023b7416000***

[...]

[ 1214.903455] scsi_timeout req=0xffff0023add29000 reserved=0
[ 1214.908946] scsi_timeout req=0xffff0023add29300 reserved=0
[ 1214.914424] scsi_timeout req=0xffff0023add29600 reserved=0
[ 1214.919909] scsi_timeout req=0xffff0023add29900 reserved=0

I guess that we're retrying as the SCSI failed in the LLDD for some reason.

So could this be the problem - we're attempting to requeue on a dead 
request queue?

Thanks,
John

> Thanks as always,
> John
> 
>>
>> Thanks,
>> Ming

