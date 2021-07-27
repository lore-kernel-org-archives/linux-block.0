Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C72C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274A4617E5
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 10:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbhG0KaX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 06:30:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3499 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhG0KaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 06:30:23 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYt2t2lZFz6GDBh;
        Tue, 27 Jul 2021 18:15:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Jul 2021 12:30:20 +0200
Received: from [10.47.80.220] (10.47.80.220) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Jul
 2021 11:30:20 +0100
Subject: Re: [PATCH] blk-mq-sched: Fix blk_mq_sched_alloc_tags() error
 handling
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <osandov@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1627378373-148090-1-git-send-email-john.garry@huawei.com>
 <YP/atlyuacbHF/sp@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e0c47dfe-4774-358d-6e1d-22fa98865d57@huawei.com>
Date:   Tue, 27 Jul 2021 11:30:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YP/atlyuacbHF/sp@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.220]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/07/2021 11:06, Ming Lei wrote:
> On Tue, Jul 27, 2021 at 05:32:53PM +0800, John Garry wrote:
>> If the blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() call fails, then we
>> call blk_mq_sched_free_tags() -> blk_mq_free_rqs().
>>
>> It is incorrect to do so, as any rqs would have already been freed in the
>> blk_mq_alloc_rqs() call.
>>
>> Fix by calling blk_mq_free_rq_map() only directly.
>>
>> Fixes: 6917ff0b5bd41 ("blk-mq-sched: refactor scheduler initialization")
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Not sure it is one fix, because blk_mq_free_rqs() does nothing when
> ->static_rqs[] isn't filled, so 'Fixes' tag isn't needed, IMO.

I actually experimented by returning an error from 
blk_mq_sched_alloc_tags() -> blk_mq_alloc_rqs() at the function entry 
point, and it crashes:

[8.118419] 
==================================================================
[8.125677] BUG: KASAN: null-ptr-deref in blk_mq_free_rqs+0x170/0x380
[8.132158] Read of size 8 at addr 0000000000000020 by task swapper/0/1
[8.138806]
[8.140297] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 
5.14.0-rc3-gf17b9ea98148 #113
[8.147997] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 
IT21 Nemo 2.0 RC0 04/18/2018
[8.157177] Call trace:
[8.159628]  dump_backtrace+0x0/0x2bc
[8.163312]  show_stack+0x1c/0x2c
[8.166643]  dump_stack_lvl+0x68/0x84
[8.170325]  kasan_report+0x12c/0x24c
[8.174005]  __asan_load8+0x98/0xd4
[8.177508]  blk_mq_free_rqs+0x170/0x380
[8.181450]  blk_mq_init_sched+0x604/0x6e0
[8.185567]  elevator_init_mq+0x134/0x220
[8.189596]  __device_add_disk+0x28c/0x520
[8.193714]  device_add_disk+0x18/0x24
[8.197481]  loop_add+0x300/0x360
[8.200811]  loop_init+0xf4/0x120
[8.204142]  do_one_initcall+0xa8/0x270
[8.207995]  kernel_init_freeable+0x2c4/0x34c
[8.212376]  kernel_init+0x28/0x140
[8.215880]  ret_from_fork+0x10/0x18
[8.219472] 
==================================================================
[8.226728] Disabling lock debugging due to kernel taint
[8.232074] Unable to handle kernel NULL pointer dereference at virtual 
address 0000000000000020
[8.240919] Mem abort info:
[8.243727]   ESR = 0x96000004
[8.246797]   EC = 0x25: DABT (current EL), IL = 32 bits
[8.252141]   SET = 0, FnV = 0
[8.255210]   EA = 0, S1PTW = 0
[8.258367]   FSC = 0x04: level 0 translation fault
[8.263272] Data abort info:
[8.266165]   ISV = 0, ISS = 0x00000004
[8.270021]   CM = 0, WnR = 0
[8.272998] [0000000000000020] user address but active_mm is swapper
[8.279387] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[8.284987] Modules linked in:
[8.288055] CPU: 9 PID: 1 Comm: swapper/0 Tainted: GB 
5.14.0-rc3-gf17b9ea98148 #113
[8.297149] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 
IT21 Nemo 2.0 RC0 04/18/2018
[8.306329] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[8.312366] pc : blk_mq_free_rqs+0x170/0x380
[8.316657] lr : blk_mq_free_rqs+0x170/0x380
[8.320947] sp : ffff8000164f7ae0
[8.324273] x29: ffff8000164f7ae0 x28: ffff00105340e960 x27: ffff001053418650
[8.331455] x26: ffff00105340c1e4 x25: ffff00105340c1a0 x24: ffff8000116e0860
[8.338636] x23: ffff00104a679400 x22: ffff00104a6b4c00 x21: fffffffffffff000
[8.345817] x20: 0000000000000000 x19: fffffffffffffff8 x18: 0000000000000000
[8.352996] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[8.360175] x14: 0000000000000000 x13: 746e696174206c65 x12: ffff6002db693ff9
[8.367355] x11: 1fffe002db693ff8 x10: ffff6002db693ff8 x9 : dfff800000000000
[8.374536] x8 : ffff0016db49ffc0 x7 : 0000000000000001 x6 : 00009ffd2496c008
[8.381716] x5 : ffff0016db49ffc0 x4 : dfff800000000000 x3 : ffff8000115b29d4
[8.388896] x2 : 0000000000000007 x1 : ffff0410019e8000 x0 : 0000000000000001
[8.396076] Call trace:
[8.398528]  blk_mq_free_rqs+0x170/0x380
[8.402470]  blk_mq_init_sched+0x604/0x6e0
[8.406587]  elevator_init_mq+0x134/0x220
[8.410614]  __device_add_disk+0x28c/0x520
[8.414732]  device_add_disk+0x18/0x24
[8.418500]  loop_add+0x300/0x360
[8.421828]  loop_init+0xf4/0x120
[8.425157]  do_one_initcall+0xa8/0x270
[8.429009]  kernel_init_freeable+0x2c4/0x34c
[8.433388]  kernel_init+0x28/0x140
[8.436891]  ret_from_fork+0x10/0x18
[8.440487] Code: 9100a260 d346feb5 8b153035 97f287e9 (f9401676)
[8.446710] ---[ end trace 66db82d449431dd1 ]--

That's even if I include "blk-mq: Change rqs check in blk_mq_free_rqs()" 
in my other series.

The crash seems to be in blk_mq_clear_rq_mapping(), which much newer 
than 6917ff0b5bd41. But I'd still leave the Fixes tag.

> 
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index c838d81ac058..0f006cabfd91 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -515,17 +515,6 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
>>   	percpu_ref_put(&q->q_usage_counter);
>>   }
>>   
>> -static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
>> -				   struct blk_mq_hw_ctx *hctx,
>> -				   unsigned int hctx_idx)
>> -{
>> -	if (hctx->sched_tags) {
>> -		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
>> -		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
>> -		hctx->sched_tags = NULL;
>> -	}
>> -}
>> -
>>   static int blk_mq_sched_alloc_tags(struct request_queue *q,
>>   				   struct blk_mq_hw_ctx *hctx,
>>   				   unsigned int hctx_idx)
>> @@ -539,8 +528,10 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
>>   		return -ENOMEM;
>>   
>>   	ret = blk_mq_alloc_rqs(set, hctx->sched_tags, hctx_idx, q->nr_requests);
>> -	if (ret)
>> -		blk_mq_sched_free_tags(set, hctx, hctx_idx);
>> +	if (ret) {
>> +		blk_mq_free_rq_map(hctx->sched_tags, set->flags);
>> +		hctx->sched_tags = NULL;
>> +	}
> 
> The patch itself looks fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> 
> 

cheers

> .
> 

