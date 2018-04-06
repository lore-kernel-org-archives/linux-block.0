Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <b3f7e1b5-2de4-80d3-8125-c2a1da8ba9a6@de.ibm.com>
 <d3a45ead-7d6c-a7b2-0d7a-9d54f9e66e4a@de.ibm.com>
 <20180329094016.GA17190@ming.t460p>
 <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
 <20180329104806.GB17537@ming.t460p>
 <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
 <20180329114313.GC17537@ming.t460p>
 <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
 <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Apr 2018 10:35:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180405160503.GA20818@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <31e00fef-6311-24d1-c18d-a2d6fb2961b7@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 04/05/2018 06:05 PM, Ming Lei wrote:
[...]
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 90838e998f66..996f8a963026 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1324,9 +1324,18 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
>  		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> +		int cpu;
> +		printk(KERN_WARNING "run queue from wrong CPU %d/%d, hctx-%d %s\n",
> +			raw_smp_processor_id(), hctx->next_cpu,
> +			hctx->queue_num,
>  			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> +		printk("dump CPUs mapped to this hctx:\n");
> +		for_each_cpu(cpu, hctx->cpumask)
> +			printk("%d ", cpu);
> +		printk("\n");
> +		printk("nr_cpu_ids is %d, and dump online cpus:\n", nr_cpu_ids);
> +		for_each_cpu(cpu, cpu_online_mask)
> +			printk("%d ", cpu);
>  		dump_stack();
>  	}
> 

FWIW, with things like

[    4.049828] dump CPUs mapped to this hctx:
[    4.049829] 18 
[    4.049829] 82 
[    4.049830] 146 
[    4.049830] 210 
[    4.049831] 274 

[    4.049832] nr_cpu_ids is 282, and dump online cpus:
[    4.049833] 0 
[    4.049833] 1 
[    4.049834] 2 
[    4.049834] 3 
[    4.049835] 4 
[    4.049835] 5 
[    4.049836] 6 
[    4.049836] 7 
[    4.049837] 8 
[    4.049837] 9 
[    4.049838] 10 
[    4.049839] 11 
[    4.049839] 12 
[    4.049840] 13 
[    4.049840] 14 
[    4.049841] 15 

So the hctx has only "possible CPUs", but all are offline.

Doesnt that always make this run unbound? See blk_mq_hctx_next_cpu  below.

/*
 * It'd be great if the workqueue API had a way to pass
 * in a mask and had some smarts for more clever placement.
 * For now we just round-robin here, switching for every
 * BLK_MQ_CPU_WORK_BATCH queued items.
 */
static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
{
        bool tried = false;

        if (hctx->queue->nr_hw_queues == 1)
                return WORK_CPU_UNBOUND;

        if (--hctx->next_cpu_batch <= 0) {
                int next_cpu;
select_cpu:     
                next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
                                cpu_online_mask);
                if (next_cpu >= nr_cpu_ids)
                        next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);

                /*
                 * No online CPU is found, so have to make sure hctx->next_cpu
                 * is set correctly for not breaking workqueue.
                 */
                if (next_cpu >= nr_cpu_ids)
                        hctx->next_cpu = cpumask_first(hctx->cpumask);
                else
                        hctx->next_cpu = next_cpu;
                hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
        }
        
        /*
         * Do unbound schedule if we can't find a online CPU for this hctx,
         * and it should only happen in the path of handling CPU DEAD.
         */
        if (!cpu_online(hctx->next_cpu)) {
                if (!tried) {
                        tried = true;
                        goto select_cpu;
                }

                /*
                 * Make sure to re-select CPU next time once after CPUs
                 * in hctx->cpumask become online again.
                 */
                hctx->next_cpu_batch = 1;
                return WORK_CPU_UNBOUND;
        }
        return hctx->next_cpu;
}
