Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7989C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C036020738
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgFDKZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728486AbgFDKZq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1FB94C51FED94A507D35;
        Thu,  4 Jun 2020 11:25:44 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 4 Jun 2020
 11:25:43 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
Date:   Thu, 4 Jun 2020 11:24:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.172.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>>>
>>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>>> index 96a39d0724a29..cded7fdcad8ef 100644
>>>> --- a/block/blk-mq-tag.c
>>>> +++ b/block/blk-mq-tag.c
>>>> @@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>>>        return tag + tag_offset;
>>>>    }
>>>>    +bool __blk_mq_get_driver_tag(struct request *rq)
>>>> +{
>>>> +    struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
>>>> +    unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
>>>> +    bool shared = blk_mq_tag_busy(rq->mq_hctx);
>>>
>>> Not necessary to add 'shared' which is just used once.
>>>
>>>> +    int tag;
>>>> +
>>>> +    if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
>>>> +        bt = &rq->mq_hctx->tags->breserved_tags;
>>>
>>> Too many rq->mq_hctx->tags, you can add one local variable to store it.
>>>
>>> Otherwise, looks fine:
>>>
>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Unfortunately this looks to still have problems. So, for a start, this 
stackframe is pumped out a lot (which I removed, for below):

[  697.464058] Workqueue: kblockd blk_mq_run_work_fn
[  697.468749] Call trace:
[  697.471184]  dump_backtrace+0x0/0x1c0
[  697.474833]  show_stack+0x18/0x28
[  697.478136]  dump_stack+0xc8/0x114
[  697.481524]  __blk_mq_run_hw_queue+0x124/0x130
[  697.485954]  blk_mq_run_work_fn+0x20/0x30
[  697.489951]  process_one_work+0x1e8/0x360
[  697.493947]  worker_thread+0x238/0x478
[  697.497683]  kthread+0x150/0x158
[  697.500898]  ret_from_fork+0x10/0x1c
[  697.504480] run queue from wrong CPU 32, hctx active
[  697.509444] CPU: 32 PID: 1477 Comm: kworker/21:2H Not tainted 5.7.0-

And then other time I get SCSI timeouts:

[95.170616] psci: CPU21 killed (polled 0 ms)
[95.419832] CPU22: shutdown
[95.422630] psci: CPU22 killed (polled 0 ms)
[95.683772] irq_shutdown irq1384MiB/s,w=0KiB/s][r=380k,w=0 IOPS][eta 
00m:50s]
[95.687013] CPU23: shutdown
[95.689829] psci: CPU23 killed (polled 0 ms)
[96.379817] CPU24: shutdown
[96.382617] psci: CPU24 killed (polled 0 ms)
[96.703823] CPU25: shutdown=1902MiB/s,w=0KiB/s][r=487k,w=0 IOPS][eta 
00m:49s]
[96.706667] psci: CPU25 killed (polled 0 ms)
[97.299845] CPU26: shutdown
[97.302647] psci: CPU26 killed (polled 0 ms)
[97.331737] irq_shutdown irq139
[97.334969] CPU27: shutdown
[97.337774] psci: CPU27 killed (polled 0 ms)
[  102.308329] CPU28: shutdown=1954MiB/s,w=0KiB/s][r=500k,w=0 IOPS][eta 
00m:44s]
[  102.311137] psci: CPU28 killed (polled 0 ms)
[  102.663877] CPU29: shutdown=1755MiB/s,w=0KiB/s][r=449k,w=0 IOPS][eta 
00m:43s]
[  102.666679] psci: CPU29 killed (polled 0 ms)
[  104.459867] CPU30: shutdown=1552MiB/s,w=0KiB/s][r=397k,w=0 IOPS][eta 
00m:42s]
[  104.462668] psci: CPU30 killed (polled 0 ms)
[  106.259909] IRQ 43: no longer affine to CPU31s][r=414k,w=0 IOPS][eta 
00m:40s]
[  106.264273] IRQ 114: no longer affine to CPU31
[  106.268707] IRQ 118: no longer affine to CPU31
[  106.273141] IRQ 123: no longer affine to CPU31
[  106.277579] irq_shutdown irq140
[  106.280757] IRQ 332: no longer affine to CPU31
[  106.285190] IRQ 336: no longer affine to CPU31
[  106.289623] IRQ 338: no longer affine to CPU31
[  106.294056] IRQ 340: no longer affine to CPU31
[  106.298489] IRQ 344: no longer affine to CPU31
[  106.302922] IRQ 348: no longer affine to CPU31
[  106.307450] CPU31: shutdown
[  106.310251] psci: CPU31 killed (polled 0 ms)
[  108.367884] CPU32: shutdown=1693MiB/s,w=0KiB/s][r=434k,w=0 IOPS][eta 
00m:38s]
[  108.370683] psci: CPU32 killed (polled 0 ms)
[  110.808471] CPU33: shutdown=1747MiB/s,w=0KiB/s][r=447k,w=0 IOPS][eta 
00m:35s]
[  110.811269] psci: CPU33 killed (polled 0 ms)
[  110.871804] CPU34: shutdown
[  110.874598] psci: CPU34 killed (polled 0 ms)
[  111.767879] irq_shutdown irq1412MiB/s,w=0KiB/s][r=418k,w=0 IOPS][eta 
00m:34s]
[  111.771171] CPU35: shutdown
[  111.773975] psci: CPU35 killed (polled 0 ms)
[  113.167866] CPU36: shutdown=1680MiB/s,w=0KiB/s][r=430k,w=0 IOPS][eta 
00m:33s]
[  113.170673] psci: CPU36 killed (polled 0 ms)
[  115.783879] CPU37: shutdown=1839MiB/s,w=0KiB/s][r=471k,w=0 IOPS][eta 
00m:30s]
[  115.786675] psci: CPU37 killed (polled 0 ms)
[  117.111877] CPU38: shutdown=2032MiB/s,w=0KiB/s][r=520k,w=0 IOPS][eta 
00m:29s]
[  117.114670] psci: CPU38 killed (polled 0 ms)
[  121.263701] irq_shutdown irq1423MiB/s,w=0KiB/s][r=428k,w=0 IOPS][eta 
00m:25s]
[  121.266996] CPU39: shutdown
[  121.269797] psci: CPU39 killed (polled 0 ms)
[  121.364122] CPU40: shutdown
[  121.366918] psci: CPU40 killed (polled 0 ms)
[  121.448256] CPU41: shutdown
[  121.451058] psci: CPU41 killed (polled 0 ms)
[  121.515785] CPU42: shutdown=1711MiB/s,w=0KiB/s][r=438k,w=0 IOPS][eta 
00m:24s]
[  121.518586] psci: CPU42 killed (polled 0 ms)
[  121.563659] irq_shutdown irq143
[  121.566922] CPU43: shutdown
[  121.569732] psci: CPU43 killed (polled 0 ms)
[  122.619423] scsi_times_out req=0xffff001faf906900=371k,w=0 IOPS][eta 
00m:23s]
[  122.624131] scsi_times_out req=0xffff001faf90ed00
[  122.628842] scsi_times_out req=0xffff001faf90fc00
[  122.633547] scsi_times_out req=0xffff001faf906000
[  122.638259] scsi_times_out req=0xffff001faf906300
[  122.642969] scsi_times_out req=0xffff001faf906600
[  122.647676] scsi_times_out req=0xffff001faf906c00
[  122.652381] scsi_times_out req=0xffff001faf906f00
[  122.657086] scsi_times_out req=0xffff001faf907200
[  122.661791] scsi_times_out req=0xffff001faf907500
[  122.666498] scsi_times_out req=0xffff001faf907800
[  122.671203] scsi_times_out req=0xffff001faf907b00
[  122.675909] scsi_times_out req=0xffff001faf907e00
[  122.680615] scsi_times_out req=0xffff001faf908100
[  122.685319] scsi_times_out req=0xffff001faf908400
[  122.690025] scsi_times_out req=0xffff001faf908700
[  122.694731] scsi_times_out req=0xffff001faf908a00
[  122.699439] scsi_times_out req=0xffff001faf908d00
[  122.704145] scsi_times_out req=0xffff001faf909000
[  122.708849] scsi_times_out req=0xffff001faf909300


And another:

51.336698] CPU53: shutdown
[  251.336737] run queue from wrong CPU 0, hctx active
[  251.339545] run queue from wrong CPU 0, hctx active
[  251.344695] psci: CPU53 killed (polled 0 ms)
[  251.349302] run queue from wrong CPU 0, hctx active
[  251.358447] run queue from wrong CPU 0, hctx active
[  251.363336] run queue from wrong CPU 0, hctx active
[  251.368222] run queue from wrong CPU 0, hctx active
[  251.373108] run queue from wrong CPU 0, hctx active
[  252.488831] CPU54: shutdown=1094MiB/s,w=0KiB/s][r=280k,w=0 IOPS][eta 
00m:04s]
[  252.491629] psci: CPU54 killed (polled 0 ms)
[  252.536533] irq_shutdown irq146
[  252.540007] CPU55: shutdown
[  252.543273] psci: CPU55 killed (polled 0 ms)
[  252.656656] CPU56: shutdown
[  252.659446] psci: CPU56 killed (polled 0 ms)
[  252.704576] CPU57: shutdown=947MiB/s,w=0KiB/s][r=242k,w=0 IOPS][eta 
00m:02s]
[  252.707369] psci: CPU57 killed (polled 0 ms)
[  254.352646] CPU58: shutdown=677MiB/s,w=0KiB/s][r=173k,w=0 IOPS][eta 
00m:02s]
[  254.355442] psci: CPU58 killed (polled 0 ms)
long sleep 1
[  279.288227] scsi_times_out req=0xffff041fa10b6600[r=0,w=0 IOPS][eta 
04m:37s]
[  279.320281] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[  279.326144] sas: trying to find task 0x00000000e8dca422
[  279.331379] sas: sas_scsi_find_task: aborting task 0x00000000e8dca422

none scheduler seems ok.

>> So I did see this for mq-deadline scheduler:
>>
>> ] Unable to handle kernel NULL pointer dereference at virtual address
>> 0000000000000040
>> [  518.688402] Mem abort info:
>> [  518.691183]ESR = 0x96000004
>> [  518.694233]EC = 0x25: DABT (current EL), IL = 32 bits
>> [  518.699568]SET = 0, FnV = 0
>> [  518.702667] irq_shutdown irq143
>> [  518.705937] CPU43: shutdown
>> [  518.706093]EA = 0, S1PTW = 0
>> [  518.708733] psci: CPU43 killed (polled 0 ms)
>> [  518.716141] Data abort info:
>> [  518.719050]ISV = 0, ISS = 0x00000004
>> [  518.722892]CM = 0, WnR = 0
>> [  518.725867] user pgtable: 4k pages, 48-bit VAs, pgdp=0000041fa4eae000
>> [  518.732318] [0000000000000040] pgd=0000000000000000
>> [  518.737208] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [  518.742768] Modules linked in:
>> [  518.745812] CPU: 0 PID: 1309 Comm: kworker/43:1H Not tainted
>> 5.7.0-rc2-00125-gf498b5de8a1c #390
>> [  518.754496] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21
>> Nemo 2.0 RC0 04/18/2018
>> [  518.763624] Workqueue: kblockd blk_mq_run_work_fn
>> [  518.768315] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> [  518.773094] pc : blk_mq_put_tag+0x2c/0x68
>> [  518.777091] lr : blk_mq_get_tag+0x2ec/0x338
>> [  518.781260] sp : ffff800021a53ab0
>> [  518.784562] x29: ffff800021a53ab0 x28: ffff041f9e81d248
>> [  518.789861] x27: 00000000000002aa x26: ffff041fa3e49300
>> [  518.795159] x25: ffff001fb0178fc0 x24: ffff800021a53c68
>> [  518.800458] x23: 0000000000000000 x22: 0000000000000000
>> [  518.805756] x21: ffff800011a69000 x20: ffff041fa3e49310
>> [  518.811055] x19: ffff800021a53b90 x18: 0000000000000004
>> [  518.816354] x17: 0000000000000000 x16: 0000000000000000
>> [  518.821652] x15: 0000000000000000 x14: 00000000000000ef
>> [  518.826951] x13: 00000000000000ef x12: 0000000000000001
>> [  518.832249] x11: 0000000000000000 x10: 00000000000009c0
>> [  518.837548] x9 : ffff800021a53d50 x8 : ffff041f9e39a620
>> [  518.842847] x7 : fefefefefefefeff x6 : 0000000000000000
>> [  518.848146] x5 : 400007ffffffffff x4 : 0000000000001000
>> [  518.853445] x3 : 00000000000002aa x2 : 0000000000000000
>> [  518.858743] x1 : 0000000000000000 x0 : ffff041fa3e49300
>> [  518.864042] Call trace:
>> [  518.866477]  blk_mq_put_tag+0x2c/0x68
>> [  518.870126]  blk_mq_get_tag+0x2ec/0x338
>> [  518.873948]  blk_mq_get_driver_tag+0xf8/0x168
>> [  518.878292]  blk_mq_dispatch_rq_list+0x118/0x670
>> [  518.882896]  blk_mq_do_dispatch_sched+0xb0/0x148
>> [  518.887500]  __blk_mq_sched_dispatch_requests+0xec/0x1d8
>> [  518.892799]  blk_mq_sched_dispatch_requests+0x3c/0x78
>> [  518.897837]  __blk_mq_run_hw_queue+0xb4/0x130
>> [  518.902181]  blk_mq_run_work_fn+0x20/0x30
>> [  518.906179]  process_one_work+0x1e8/0x360
>> [  518.910176]  worker_thread+0x44/0x488
>> [  518.913825]  kthread+0x150/0x158
>> [  518.917041]  ret_from_fork+0x10/0x1c
>> [  518.920606] Code: b9400004 4b020063 6b04007f 540001e2 (b9404022)
>>
>> With Christoph's patch and "blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE
>> in blk_mq_get_tag()" [I didn't test without that patch], no issue detected so far.
>>
> 
> I think my patch is no longer required with Christoph's patch.
> 

ah, of course.

> Dongli Zhang

Thanks,
John
