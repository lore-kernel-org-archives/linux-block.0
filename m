Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AEDC433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25879206E6
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgFCQSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:18:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725810AbgFCQSK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jun 2020 12:18:10 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6B25AE759EDE03F1823D;
        Wed,  3 Jun 2020 17:18:08 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.59) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Jun 2020
 17:18:06 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
Date:   Wed, 3 Jun 2020 17:16:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200603133608.GA2149752@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.59]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/06/2020 14:36, Ming Lei wrote:
> On Wed, Jun 03, 2020 at 01:53:47PM +0200, Christoph Hellwig wrote:
>> On Wed, Jun 03, 2020 at 06:51:27PM +0800, Ming Lei wrote:
>>> Commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
>>> prevents new request from being allocated on hctx which is going to be inactive,
>>> meantime drains all in-queue requests.
>>>
>>> We needn't to prevent driver tag from being allocated during cpu hotplug, more
>>> importantly we have to provide driver tag for requests, so that the cpu hotplug
>>> handling can move on. blk_mq_get_tag() is shared for allocating both internal
>>> tag and drive tag, so driver tag allocation may fail because the hctx is
>>> marked as inactive.
>>>
>>> Fix the issue by moving BLK_MQ_S_INACTIVE check to __blk_mq_alloc_request().
>>
>> This looks correct, but a little ugly.  How about we resurrect my
>> patch to split off blk_mq_get_driver_tag entirely?  Quick untested rebase
> 
> OK, I am fine.
> 
>> below, still needs a better changelog and fixes tg:
>>
>> ---
>>  From e432011e2eb5ac7bd1046bbf936645e9f7b74e64 Mon Sep 17 00:00:00 2001
>> From: Christoph Hellwig <hch@lst.de>
>> Date: Sat, 16 May 2020 08:03:48 +0200
>> Subject: blk-mq: split out a __blk_mq_get_driver_tag helper
>>
>> Allocation of the driver tag in the case of using a scheduler shares very
>> little code with the "normal" tag allocation.  Split out a new helper to
>> streamline this path, and untangle it from the complex normal tag
>> allocation.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-mq-tag.c | 27 +++++++++++++++++++++++++++
>>   block/blk-mq-tag.h |  8 ++++++++
>>   block/blk-mq.c     | 29 -----------------------------
>>   block/blk-mq.h     |  1 -
>>   4 files changed, 35 insertions(+), 30 deletions(-)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 96a39d0724a29..cded7fdcad8ef 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>   	return tag + tag_offset;
>>   }
>>   
>> +bool __blk_mq_get_driver_tag(struct request *rq)
>> +{
>> +	struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
>> +	unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
>> +	bool shared = blk_mq_tag_busy(rq->mq_hctx);
> 
> Not necessary to add 'shared' which is just used once.
> 
>> +	int tag;
>> +
>> +	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
>> +		bt = &rq->mq_hctx->tags->breserved_tags;
> 
> Too many rq->mq_hctx->tags, you can add one local variable to store it.
> 
> Otherwise, looks fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

So I did see this for mq-deadline scheduler:

] Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000040
[  518.688402] Mem abort info:
[  518.691183]ESR = 0x96000004
[  518.694233]EC = 0x25: DABT (current EL), IL = 32 bits
[  518.699568]SET = 0, FnV = 0
[  518.702667] irq_shutdown irq143
[  518.705937] CPU43: shutdown
[  518.706093]EA = 0, S1PTW = 0
[  518.708733] psci: CPU43 killed (polled 0 ms)
[  518.716141] Data abort info:
[  518.719050]ISV = 0, ISS = 0x00000004
[  518.722892]CM = 0, WnR = 0
[  518.725867] user pgtable: 4k pages, 48-bit VAs, pgdp=0000041fa4eae000
[  518.732318] [0000000000000040] pgd=0000000000000000
[  518.737208] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  518.742768] Modules linked in:
[  518.745812] CPU: 0 PID: 1309 Comm: kworker/43:1H Not tainted 
5.7.0-rc2-00125-gf498b5de8a1c #390
[  518.754496] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[  518.763624] Workqueue: kblockd blk_mq_run_work_fn
[  518.768315] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  518.773094] pc : blk_mq_put_tag+0x2c/0x68
[  518.777091] lr : blk_mq_get_tag+0x2ec/0x338
[  518.781260] sp : ffff800021a53ab0
[  518.784562] x29: ffff800021a53ab0 x28: ffff041f9e81d248
[  518.789861] x27: 00000000000002aa x26: ffff041fa3e49300
[  518.795159] x25: ffff001fb0178fc0 x24: ffff800021a53c68
[  518.800458] x23: 0000000000000000 x22: 0000000000000000
[  518.805756] x21: ffff800011a69000 x20: ffff041fa3e49310
[  518.811055] x19: ffff800021a53b90 x18: 0000000000000004
[  518.816354] x17: 0000000000000000 x16: 0000000000000000
[  518.821652] x15: 0000000000000000 x14: 00000000000000ef
[  518.826951] x13: 00000000000000ef x12: 0000000000000001
[  518.832249] x11: 0000000000000000 x10: 00000000000009c0
[  518.837548] x9 : ffff800021a53d50 x8 : ffff041f9e39a620
[  518.842847] x7 : fefefefefefefeff x6 : 0000000000000000
[  518.848146] x5 : 400007ffffffffff x4 : 0000000000001000
[  518.853445] x3 : 00000000000002aa x2 : 0000000000000000
[  518.858743] x1 : 0000000000000000 x0 : ffff041fa3e49300
[  518.864042] Call trace:
[  518.866477]  blk_mq_put_tag+0x2c/0x68
[  518.870126]  blk_mq_get_tag+0x2ec/0x338
[  518.873948]  blk_mq_get_driver_tag+0xf8/0x168
[  518.878292]  blk_mq_dispatch_rq_list+0x118/0x670
[  518.882896]  blk_mq_do_dispatch_sched+0xb0/0x148
[  518.887500]  __blk_mq_sched_dispatch_requests+0xec/0x1d8
[  518.892799]  blk_mq_sched_dispatch_requests+0x3c/0x78
[  518.897837]  __blk_mq_run_hw_queue+0xb4/0x130
[  518.902181]  blk_mq_run_work_fn+0x20/0x30
[  518.906179]  process_one_work+0x1e8/0x360
[  518.910176]  worker_thread+0x44/0x488
[  518.913825]  kthread+0x150/0x158
[  518.917041]  ret_from_fork+0x10/0x1c
[  518.920606] Code: b9400004 4b020063 6b04007f 540001e2 (b9404022)

With Christoph's patch and "blk-mq: get ctx in order to handle 
BLK_MQ_S_INACTIVE in blk_mq_get_tag()" [I didn't test without that 
patch], no issue detected so far.

Thanks,
John
