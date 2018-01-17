Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:37182 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeAQFZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jan 2018 00:25:25 -0500
Subject: Re: [PATCH 2/2] blk-mq: simplify queue mapping & schedule with each
 possisble CPU
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180112025306.28004-1-ming.lei@redhat.com>
 <20180112025306.28004-3-ming.lei@redhat.com>
 <0d36c16b-cb4b-6088-fdf3-2fe5d8f33cd7@oracle.com>
 <20180116121010.GA26429@ming.t460p>
 <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
 <20180116153248.GA3018@ming.t460p>
 <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
 <20180117035159.GA9487@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8c8efce8-ea02-0a9e-8369-44c885f4731d@oracle.com>
Date: Wed, 17 Jan 2018 13:24:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180117035159.GA9487@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi ming

Thanks for your kindly response.

On 01/17/2018 11:52 AM, Ming Lei wrote:
>> It is here.
>> __blk_mq_run_hw_queue()
>> ....
>>     WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>>         cpu_online(hctx->next_cpu));
> I think this warning is triggered after the CPU of hctx->next_cpu becomes
> online again, and it should have been dealt with by the following trick,
> and this patch is against the previous one, please test it and see if
> the warning can be fixed.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 23f0f3ddffcf..0620ccb65e4e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1452,6 +1452,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  			tried = true;
>  			goto select_cpu;
>  		}
> +
> +		/* handle after this CPU of hctx->next_cpu becomes online again */
> +		hctx->next_cpu_batch = 1;
>  		return WORK_CPU_UNBOUND;
>  	}
>  	return hctx->next_cpu;
> 

The WARNING still could be triggered.

[  282.194532] WARNING: CPU: 0 PID: 222 at /home/will/u04/source_code/linux-block/block/blk-mq.c:1315 __blk_mq_run_hw_queue+0x92/0xa0
[  282.194534] Modules linked in: ....
[  282.194561] CPU: 0 PID: 222 Comm: kworker/2:1H Tainted: G        W        4.15.0-rc7+ #17
[  282.194562] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[  282.194563] Workqueue: kblockd blk_mq_run_work_fn
[  282.194565] RIP: 0010:__blk_mq_run_hw_queue+0x92/0xa0
[  282.194565] RSP: 0018:ffff96c50223be60 EFLAGS: 00010202
[  282.194566] RAX: 0000000000000001 RBX: ffff8a7110233800 RCX: 0000000000000000
[  282.194567] RDX: ffff8a711255f2d0 RSI: 0000000000000000 RDI: ffff8a7110233800
[  282.194567] RBP: ffff8a7122ca2140 R08: 0000000000000000 R09: 0000000000000000
[  282.194568] R10: 0000000000000263 R11: 0000000000000000 R12: ffff8a7122ca8200
[  282.194568] R13: 0000000000000000 R14: 0ffff8a7122ca820 R15: ffff8a70bcef0780
[  282.194569] FS:  0000000000000000(0000) GS:ffff8a7122c00000(0000) knlGS:0000000000000000
[  282.194569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  282.194570] CR2: 0000555e14d89d60 CR3: 000000003c809002 CR4: 00000000003606f0
[  282.194571] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  282.194571] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  282.194571] Call Trace:
[  282.194576]  process_one_work+0x14b/0x420
[  282.194577]  worker_thread+0x47/0x420
[  282.194579]  kthread+0xf5/0x130
[  282.194581]  ? process_one_work+0x420/0x420
[  282.194581]  ? kthread_associate_blkcg+0xe0/0xe0
[  282.194583]  ret_from_fork+0x24/0x30
[  282.194585] Code: ff 48 89 df e8 e0 6b 00 00 8b 74 24 04 48 89 df e8 a4 fc ff ff 48 8b 44 24 08 65 48 33 04 25 28 00 00 00 75 0e 48 83 c4 10 5b c3 <0f> ff eb b7 0f ff eb c1 e8 e1 02 c6 ff 90 0f 1f 44 00 00 48 8b 
[  282.194601] ---[ end trace c104f0a63d3df31b ]---

>> ....
>>
>> To eliminate this risk totally, we could blk_mq_hctx_next_cpu return the cpu  even if the cpu is offlined and modify the cpu_online above to cpu_active.
>> The kworkers of the per-cpu pool must have be migrated back when the cpu is set active.
>> But there seems to be issues in DASD as your previous comment.
> Yes, we can't break DASD.
> 
>> That is the original version of this patch, and both Christian and Stefan
>> reported that system can't boot from DASD in this way[2], and I changed
>> to AND with cpu_online_mask, then their system can boot well
>> On the other hand, there is also risk in 
>>
>> @@ -440,7 +440,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>>  		blk_queue_exit(q);
>>  		return ERR_PTR(-EXDEV);
>>  	}
>> -	cpu = cpumask_first(alloc_data.hctx->cpumask);
>> +	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
>>  	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
>>
>> what if the cpus in alloc_data.hctx->cpumask are all offlined ?
> This one is crazy, and is used by NVMe only, it should be fine if
> the passed 'hctx_idx' is retrieved by the current running CPU, such
> as the way of blk_mq_map_queue(). But if not, bad thing may happen.
Even if retrieved by current running cpu, the task still could be migrated away when the cpu is offlined.

Thanks
Jianchao
