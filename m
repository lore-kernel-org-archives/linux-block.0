Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:54672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeAQC4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 21:56:55 -0500
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
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7f5bad86-febc-06fc-67c0-393777d172e4@oracle.com>
Date: Wed, 17 Jan 2018 10:56:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180116153248.GA3018@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi ming

Thanks for your patch and kindly response.

On 01/16/2018 11:32 PM, Ming Lei wrote:
> OK, I got it, and it should have been the only corner case in which
> all CPUs mapped to this hctx become offline, and I believe the following
> patch should address this case, could you give a test?
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c376d1b6309a..23f0f3ddffcf 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1416,21 +1416,44 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   */
>  static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  {
> +	bool tried = false;
> +
>  	if (hctx->queue->nr_hw_queues == 1)
>  		return WORK_CPU_UNBOUND;
>  
>  	if (--hctx->next_cpu_batch <= 0) {
>  		int next_cpu;
> +select_cpu:
>  
>  		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
>  				cpu_online_mask);
>  		if (next_cpu >= nr_cpu_ids)
>  			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
>  
> -		hctx->next_cpu = next_cpu;
> +		/*
> +		 * No online CPU can be found here when running from
> +		 * blk_mq_hctx_notify_dead(), so make sure hctx->next_cpu
> +		 * is set correctly.
> +		 */
> +		if (next_cpu >= nr_cpu_ids)
> +			hctx->next_cpu = cpumask_first_and(hctx->cpumask,
> +					cpu_possible_mask);
> +		else
> +			hctx->next_cpu = next_cpu;
>  		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>  	}
>  
> +	/*
> +	 * Do unbound schedule if we can't find a online CPU for this hctx,
> +	 * and it should happen only if hctx->next_cpu is becoming DEAD.
> +	 */
> +	if (!cpu_online(hctx->next_cpu)) {
> +		if (!tried) {
> +			tried = true;
> +			goto select_cpu;
> +		}
> +		return WORK_CPU_UNBOUND;
> +	}
>  	return hctx->next_cpu;
>  }

I have tested this patch. The panic was gone, but I got the following:

[  231.674464] WARNING: CPU: 0 PID: 263 at /home/will/u04/source_code/linux-block/block/blk-mq.c:1315 __blk_mq_run_hw_queue+0x92/0xa0
[  231.674466] Modules linked in: .....
[  231.674494] CPU: 0 PID: 263 Comm: kworker/2:1H Not tainted 4.15.0-rc7+ #12
[  231.674495] Hardware name: LENOVO 10MLS0E339/3106, BIOS M1AKT22A 06/27/2017
[  231.674496] Workqueue: kblockd blk_mq_run_work_fn
[  231.674498] RIP: 0010:__blk_mq_run_hw_queue+0x92/0xa0
[  231.674499] RSP: 0018:ffffa9c801fcfe60 EFLAGS: 00010202
[  231.674500] RAX: 0000000000000001 RBX: ffff9c7c90231400 RCX: 0000000000000000
[  231.674500] RDX: ffff9c7c9255b0f8 RSI: 0000000000000000 RDI: ffff9c7c90231400
[  231.674500] RBP: ffff9c7ca2ca2140 R08: 0000000000000000 R09: 0000000000000000
[  231.674501] R10: 00000000000003cb R11: 0000000000000000 R12: ffff9c7ca2ca8200
[  231.674501] R13: 0000000000000000 R14: 0ffff9c7ca2ca820 R15: ffff9c7c3df25240
[  231.674502] FS:  0000000000000000(0000) GS:ffff9c7ca2c00000(0000) knlGS:0000000000000000
[  231.674502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  231.674503] CR2: 0000000001727008 CR3: 0000000336409003 CR4: 00000000003606f0
[  231.674504] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  231.674504] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  231.674504] Call Trace:
[  231.674509]  process_one_work+0x14b/0x420
[  231.674510]  worker_thread+0x47/0x420
[  231.674512]  kthread+0xf5/0x130
[  231.674514]  ? process_one_work+0x420/0x420
[  231.674515]  ? kthread_associate_blkcg+0xe0/0xe0
[  231.674517]  ? do_group_exit+0x3a/0xa0
[  231.674518]  ret_from_fork+0x24/0x30
[  231.674520] Code: ff 48 89 df e8 e0 6b 00 00 8b 74 24 04 48 89 df e8 a4 fc ff ff 48 8b 44 24 08 65 48 33 04 25 28 00 00 00 75 0e 48 83 c4 10 5b c3 <0f> ff eb b7 0f ff eb c1 e8 e1 02 c6 ff 90 0f 1f 44 00 00 48 8b 
[  231.674537] ---[ end trace cc2de957e0e0fed4 ]---

It is here.
__blk_mq_run_hw_queue()
....
    WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
        cpu_online(hctx->next_cpu));
....

To eliminate this risk totally, we could blk_mq_hctx_next_cpu return the cpu  even if the cpu is offlined and modify the cpu_online above to cpu_active.
The kworkers of the per-cpu pool must have be migrated back when the cpu is set active.
But there seems to be issues in DASD as your previous comment.
>>>>
That is the original version of this patch, and both Christian and Stefan
reported that system can't boot from DASD in this way[2], and I changed
to AND with cpu_online_mask, then their system can boot well
>>>>

On the other hand, there is also risk in 

@@ -440,7 +440,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		blk_queue_exit(q);
 		return ERR_PTR(-EXDEV);
 	}
-	cpu = cpumask_first(alloc_data.hctx->cpumask);
+	cpu = cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);

what if the cpus in alloc_data.hctx->cpumask are all offlined ?

Thanks
Jianchao
