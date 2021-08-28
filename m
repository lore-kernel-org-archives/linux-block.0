Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27303C432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2ED360F14
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 02:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhH1CPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:15:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15265 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1CPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 22:15:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GxKsN0NPNz8BlF;
        Sat, 28 Aug 2021 10:14:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 10:14:49 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 28 Aug 2021 10:14:49 +0800
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <cf006b37fbf620c00a655cfa16ca9f9205f0c2a4.camel@wdc.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <27d0ff33-7668-8a97-72e4-16e702193150@huawei.com>
Date:   Sat, 28 Aug 2021 10:14:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cf006b37fbf620c00a655cfa16ca9f9205f0c2a4.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/8/27 10:30, Damien Le Moal wrote:
> On Thu, 2021-08-26 at 22:40 +0800, Zhen Lei wrote:
>> dd_queued() traverses the percpu variable for summation. The more cores,
>> the higher the performance overhead. I currently have a 128-core board and
>> this function takes 2.5 us. If the number of high-priority requests is
>> small and the number of low- and medium-priority requests is large, the
>> performance impact is significant.
>>
>> Let's maintain a non-percpu member variable 'nr_queued', which is
>> incremented by 1 immediately following "inserted++" and decremented by 1
>> immediately following "completed++". Because both the judgment dd_queued()
>> in dd_dispatch_request() and operation "inserted++" in dd_insert_request()
>> are protected by dd->lock, lock protection needs to be added only in
>> dd_finish_request(), which is unlikely to cause significant performance
>> side effects.
>>
>> Tested on my 128-core board with two ssd disks.
>> fio bs=4k rw=read iodepth=128 cpus_allowed=0-95 <others>
>> Before:
>> [183K/0/0 iops]
>> [172K/0/0 iops]
>>
>> After:
>> [258K/0/0 iops]
>> [258K/0/0 iops]
>>
>> Fixes: fb926032b320 ("block/mq-deadline: Prioritize high-priority requests")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  block/mq-deadline.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index a09761cbdf12e58..d8f6aa12de80049 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -79,6 +79,7 @@ struct dd_per_prio {
>>  	struct list_head fifo_list[DD_DIR_COUNT];
>>  	/* Next request in FIFO order. Read, write or both are NULL. */
>>  	struct request *next_rq[DD_DIR_COUNT];
>> +	unsigned int nr_queued;
>>  };
>>  
>>  struct deadline_data {
>> @@ -277,9 +278,9 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>>  }
>>  
>>  /* Number of requests queued for a given priority level. */
>> -static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>> +static __always_inline u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>>  {
>> -	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
>> +	return dd->per_prio[prio].nr_queued;
>>  }
>>  
>>  /*
>> @@ -711,6 +712,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>  
>>  	prio = ioprio_class_to_prio[ioprio_class];
>>  	dd_count(dd, inserted, prio);
>> +	per_prio = &dd->per_prio[prio];
>> +	per_prio->nr_queued++;
>>  
>>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>>  		blk_mq_free_requests(&free);
>> @@ -719,7 +722,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>  
>>  	trace_block_rq_insert(rq);
>>  
>> -	per_prio = &dd->per_prio[prio];
>>  	if (at_head) {
>>  		list_add(&rq->queuelist, &per_prio->dispatch);
>>  	} else {
>> @@ -790,12 +792,14 @@ static void dd_finish_request(struct request *rq)
>>  	const u8 ioprio_class = dd_rq_ioclass(rq);
>>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];
>> +	unsigned long flags;
>>  
>>  	dd_count(dd, completed, prio);
>> +	spin_lock_irqsave(&dd->lock, flags);
>> +	per_prio->nr_queued--;
>> +	spin_unlock_irqrestore(&dd->lock, flags);
> 
> dd->lock is not taken with irqsave everywhere else. This leads to hard lockups
> which I hit right away on boot. To avoid this, we need a spin_lock_irqsave()
> everywhere.

Yes, it's safer to add interrupt protection. I noticed that too. But I thought
there was a convention for upper-layer functions to turn off interrupts. So I
didn't touch it.

> 
> Of note is that without this patch, testing on nullblk with Bart's script on
> 5.14.0-rc7, I get this splat:
> 
>  [  198.726920] watchdog: BUG: soft lockup - CPU#20 stuck for 26s!
> [kworker/20:1H:260]
> [  198.734550] Modules linked in: null_blk rpcsec_gss_krb5 auth_rpcgss nfsv4
> dns_resolver nfs lockd grace fscache netfs nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
> nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables libcrc32c nfnetlink sunrpc vfat fat iTCO_wdt iTCO_vendor_support
> ipmi_ssif x86_pkg_temp_thermal acpi_ipmi coretemp ipmi_si ioatdma i2c_i801 bfq
> i2c_smbus lpc_ich intel_pch_thermal dca ipmi_devintf ipmi_msghandler
> acpi_power_meter fuse ip_tables sd_mod ast i2c_algo_bit drm_vram_helper
> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm
> drm i40e crct10dif_pclmul mpt3sas crc32_pclmul ahci ghash_clmulni_intel libahci
> libata raid_class scsi_transport_sas pkcs8_key_parser
> [  198.805375] irq event stamp: 25378690
> [  198.809063] hardirqs last  enabled at (25378689): [<ffffffff81149959>]
> ktime_get+0x109/0x120
> [  198.817545] hardirqs last disabled at (25378690): [<ffffffff8190519b>]
> sysvec_apic_timer_interrupt+0xb/0x90
> [  198.827327] softirqs last  enabled at (25337302): [<ffffffff810b331f>]
> __irq_exit_rcu+0xbf/0xe0
> [  198.836066] softirqs last disabled at (25337297): [<ffffffff810b331f>]
> __irq_exit_rcu+0xbf/0xe0
> [  198.844802] CPU: 20 PID: 260 Comm: kworker/20:1H Not tainted 5.14.0-rc7+
> #1324
> [  198.852059] Hardware name: Supermicro Super Server/X11DPL-i, BIOS 3.3
> 02/21/2020
> [  198.859487] Workqueue: kblockd blk_mq_run_work_fn
> [  198.864222] RIP: 0010:__list_add_valid+0x33/0x40
> [  198.868868] Code: f2 0f 85 ec 44 44 00 4c 8b 0a 4d 39 c1 0f 85 08 45 44 00
> 48 39 d7 0f 84 e8 44 44 00 4c 39 cf 0f 84 df 44 44 00 b8 01 00 00 00 <c3> 66 66
> 2e 0f 1f 84 00 00 00 00 00 90 48 8b 17 4c 8b 47 08 48 b8
> [  198.887712] RSP: 0018:ffff8883f1337d68 EFLAGS: 00000206
> [  198.892963] RAX: 0000000000000001 RBX: ffff88857dae0840 RCX:
> 0000000000000000
> [  198.900132] RDX: ffff8885387e2bc8 RSI: ffff8885387e2bc8 RDI:
> ffff8885387e2d48
> [  198.907300] RBP: ffff8883f1337d90 R08: ffff8883f1337d90 R09:
> ffff8883f1337d90
> [  198.914467] R10: 0000000000000020 R11: 0000000000000001 R12:
> 000000000000000a
> [  198.921632] R13: ffff88857dae0800 R14: ffff8885bd3f3400 R15:
> ffff8885bd276200
> [  198.928801] FS:  0000000000000000(0000) GS:ffff888860100000(0000)
> knlGS:0000000000000000
> [  198.936929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  198.942703] CR2: 0000000002204440 CR3: 0000000107322004 CR4:
> 00000000007706e0
> [  198.949871] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [  198.957036] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [  198.964203] PKRU: 55555554
> [  198.966933] Call Trace:
> [  198.969401]  __blk_mq_do_dispatch_sched+0x234/0x2f0
> [  198.974314]  __blk_mq_sched_dispatch_requests+0xf4/0x140
> [  198.979662]  blk_mq_sched_dispatch_requests+0x30/0x60
> [  198.984744]  __blk_mq_run_hw_queue+0x49/0x90
> [  198.989041]  process_one_work+0x26c/0x570
> [  198.993083]  worker_thread+0x55/0x3c0
> [  198.996776]  ? process_one_work+0x570/0x570
> [  199.000993]  kthread+0x140/0x160
> [  199.004243]  ? set_kthread_struct+0x40/0x40
> [  199.008452]  ret_from_fork+0x1f/0x30
> 
> 
> 
> 
>>  
>>  	if (blk_queue_is_zoned(q)) {
>> -		unsigned long flags;
>> -
>>  		spin_lock_irqsave(&dd->zone_lock, flags);
>>  		blk_req_zone_write_unlock(rq);
>>  		if (!list_empty(&per_prio->fifo_list[DD_WRITE]))
> 
