Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
        "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com"
 <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <9c5eec5d-f542-4d76-6933-6fe31203ce09@de.ibm.com>
 <1511205644.2396.32.camel@wdc.com>
 <04526c98-ffc5-1eca-3aa8-50f9212c4323@de.ibm.com>
 <5c9f2228-0a8b-8225-7038-e6cb3f31ca0b@kernel.dk>
 <2e44dbd3-2f90-c267-560c-91d1d4b0e892@de.ibm.com>
 <823b9dd5-7781-5a72-03ff-bc931433fc19@kernel.dk>
 <bd928410-4d38-603e-00c9-4c4db20d8e86@de.ibm.com>
 <15f232d2-2aaa-df7c-57e8-2f710e051e84@de.ibm.com>
 <c8bd769e-9742-205d-11b0-469428a8579c@de.ibm.com>
 <b7b3cf4b-837e-f9ba-61c0-4f9ddd8b9a95@kernel.dk>
 <055f040d-3f9a-a8fd-e8e2-326c6b9094a1@kernel.dk>
 <1aeecf2e-a68e-4c18-5912-2473f457e6ea@de.ibm.com>
 <8fedc2ad-d775-7789-742c-92ca928a3aee@kernel.dk>
 <ebf96f76-3f53-283d-042d-8ea3f5eddb3d@kernel.dk>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 21 Nov 2017 20:15:40 +0100
MIME-Version: 1.0
In-Reply-To: <ebf96f76-3f53-283d-042d-8ea3f5eddb3d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Message-Id: <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 11/21/2017 07:39 PM, Jens Axboe wrote:
> On 11/21/2017 11:27 AM, Jens Axboe wrote:
>> On 11/21/2017 11:12 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 11/21/2017 07:09 PM, Jens Axboe wrote:
>>>> On 11/21/2017 10:27 AM, Jens Axboe wrote:
>>>>> On 11/21/2017 03:14 AM, Christian Borntraeger wrote:
>>>>>> Bisect points to
>>>>>>
>>>>>> 1b5a7455d345b223d3a4658a9e5fce985b7998c1 is the first bad commit
>>>>>> commit 1b5a7455d345b223d3a4658a9e5fce985b7998c1
>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>> Date:   Mon Jun 26 12:20:57 2017 +0200
>>>>>>
>>>>>>     blk-mq: Create hctx for each present CPU
>>>>>>     
>>>>>>     commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
>>>>>>     
>>>>>>     Currently we only create hctx for online CPUs, which can lead to a lot
>>>>>>     of churn due to frequent soft offline / online operations.  Instead
>>>>>>     allocate one for each present CPU to avoid this and dramatically simplify
>>>>>>     the code.
>>>>>>     
>>>>>>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>>     Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>>>>>     Cc: Keith Busch <keith.busch@intel.com>
>>>>>>     Cc: linux-block@vger.kernel.org
>>>>>>     Cc: linux-nvme@lists.infradead.org
>>>>>>     Link: http://lkml.kernel.org/r/20170626102058.10200-3-hch@lst.de
>>>>>>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>     Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>>>>     Cc: Mike Galbraith <efault@gmx.de>
>>>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>
>>>>> I wonder if we're simply not getting the masks updated correctly. I'll
>>>>> take a look.
>>>>
>>>> Can't make it trigger here. We do init for each present CPU, which means
>>>> that if I offline a few CPUs here and register a queue, those still show
>>>> up as present (just offline) and get mapped accordingly.
>>>>
>>>> From the looks of it, your setup is different. If the CPU doesn't show
>>>> up as present and it gets hotplugged, then I can see how this condition
>>>> would trigger. What environment are you running this in? We might have
>>>> to re-introduce the cpu hotplug notifier, right now we just monitor
>>>> for a dead cpu and handle that.
>>>
>>> I am not doing a hot unplug and the replug, I use KVM and add a previously
>>> not available CPU.
>>>
>>> in libvirt/virsh speak:
>>>   <vcpu placement='static' current='1'>4</vcpu>
>>
>> So that's why we run into problems. It's not present when we load the device,
>> but becomes present and online afterwards.
>>
>> Christoph, we used to handle this just fine, your patch broke it.
>>
>> I'll see if I can come up with an appropriate fix.
> 
> Can you try the below?


It does prevent the crash but it seems that the new CPU is not "used " after the hotplug for mq:


output with 2 cpus:
/sys/kernel/debug/block/vda
/sys/kernel/debug/block/vda/hctx0
/sys/kernel/debug/block/vda/hctx0/cpu0
/sys/kernel/debug/block/vda/hctx0/cpu0/completed
/sys/kernel/debug/block/vda/hctx0/cpu0/merged
/sys/kernel/debug/block/vda/hctx0/cpu0/dispatched
/sys/kernel/debug/block/vda/hctx0/cpu0/rq_list
/sys/kernel/debug/block/vda/hctx0/active
/sys/kernel/debug/block/vda/hctx0/run
/sys/kernel/debug/block/vda/hctx0/queued
/sys/kernel/debug/block/vda/hctx0/dispatched
/sys/kernel/debug/block/vda/hctx0/io_poll
/sys/kernel/debug/block/vda/hctx0/sched_tags_bitmap
/sys/kernel/debug/block/vda/hctx0/sched_tags
/sys/kernel/debug/block/vda/hctx0/tags_bitmap
/sys/kernel/debug/block/vda/hctx0/tags
/sys/kernel/debug/block/vda/hctx0/ctx_map
/sys/kernel/debug/block/vda/hctx0/busy
/sys/kernel/debug/block/vda/hctx0/dispatch
/sys/kernel/debug/block/vda/hctx0/flags
/sys/kernel/debug/block/vda/hctx0/state
/sys/kernel/debug/block/vda/sched
/sys/kernel/debug/block/vda/sched/dispatch
/sys/kernel/debug/block/vda/sched/starved
/sys/kernel/debug/block/vda/sched/batching
/sys/kernel/debug/block/vda/sched/write_next_rq
/sys/kernel/debug/block/vda/sched/write_fifo_list
/sys/kernel/debug/block/vda/sched/read_next_rq
/sys/kernel/debug/block/vda/sched/read_fifo_list
/sys/kernel/debug/block/vda/write_hints
/sys/kernel/debug/block/vda/state
/sys/kernel/debug/block/vda/requeue_list
/sys/kernel/debug/block/vda/poll_stat

> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b600463791ec..ab3a66e7bd03 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -40,6 +40,7 @@
>  static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
>  static void blk_mq_poll_stats_start(struct request_queue *q);
>  static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
> +static void blk_mq_map_swqueue(struct request_queue *q);
> 
>  static int blk_mq_poll_stats_bkt(const struct request *rq)
>  {
> @@ -1947,6 +1950,15 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
> 
> +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp);
> +	blk_mq_map_swqueue(hctx->queue);
> +	return 0;
> +}
> +
>  /*
>   * 'cpu' is going away. splice any existing rq_list entries from this
>   * software queue to the hw queue dispatch list, and ensure that it
> @@ -1958,7 +1970,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	struct blk_mq_ctx *ctx;
>  	LIST_HEAD(tmp);
> 
> -	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp);
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
> 
>  	spin_lock(&ctx->lock);
> @@ -1981,8 +1993,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> 
>  static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
>  {
> -	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_DEAD,
> -					    &hctx->cpuhp_dead);
> +	cpuhp_state_remove_instance_nocalls(CPUHP_BLK_MQ_PREPARE, &hctx->cpuhp);
>  }
> 
>  /* hctx->ctxs will be freed in queue's release handler */
> @@ -2039,7 +2050,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
>  	hctx->queue = q;
>  	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
> 
> -	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
> +	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_PREPARE, &hctx->cpuhp);
> 
>  	hctx->tags = set->tags[hctx_idx];
> 
> @@ -2974,7 +2987,8 @@ static int __init blk_mq_init(void)
>  	BUILD_BUG_ON((REQ_ATOM_STARTED / BITS_PER_BYTE) !=
>  			(REQ_ATOM_COMPLETE / BITS_PER_BYTE));
> 
> -	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
> +	cpuhp_setup_state_multi(CPUHP_BLK_MQ_PREPARE, "block/mq:prepare",
> +				blk_mq_hctx_notify_prepare,
>  				blk_mq_hctx_notify_dead);
>  	return 0;
>  }
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 95c9a5c862e2..a6f03e9464fb 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -52,7 +52,7 @@ struct blk_mq_hw_ctx {
> 
>  	atomic_t		nr_active;
> 
> -	struct hlist_node	cpuhp_dead;
> +	struct hlist_node	cpuhp;
>  	struct kobject		kobj;
> 
>  	unsigned long		poll_considered;
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index ec32c4c5eb30..28b0fc9229c8 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -48,7 +48,7 @@ enum cpuhp_state {
>  	CPUHP_BLOCK_SOFTIRQ_DEAD,
>  	CPUHP_ACPI_CPUDRV_DEAD,
>  	CPUHP_S390_PFAULT_DEAD,
> -	CPUHP_BLK_MQ_DEAD,
> +	CPUHP_BLK_MQ_PREPARE,
>  	CPUHP_FS_BUFF_DEAD,
>  	CPUHP_PRINTK_DEAD,
>  	CPUHP_MM_MEMCQ_DEAD,
> 
