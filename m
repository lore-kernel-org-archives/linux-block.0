Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:58918 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeAPOch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 09:32:37 -0500
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
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <7c24e321-2d3b-cdec-699a-f58c34300aa9@oracle.com>
Date: Tue, 16 Jan 2018 22:31:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180116121010.GA26429@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi minglei

On 01/16/2018 08:10 PM, Ming Lei wrote:
>>> -		next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
>>> +		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
>>> +				cpu_online_mask);
>>>  		if (next_cpu >= nr_cpu_ids)
>>> -			next_cpu = cpumask_first(hctx->cpumask);
>>> +			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
>> the next_cpu here could be >= nr_cpu_ids when the none of on hctx->cpumask is online.
> That supposes not happen because storage device(blk-mq hw queue) is
> generally C/S model, that means the queue becomes only active when
> there is online CPU mapped to it.
> 
> But it won't be true for non-block-IO queue, such as HPSA's queues[1], and
> network controller RX queues.
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dkernel-26m-3D151601867018444-26w-3D2&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=tCZdQH6JUW1dkNCN92ycoUoKfDU_qWj-7EsUoYpOeJ0&s=vgHC9sbjYQb7mtY9MUJzbVXyVEyjoNJPWEx4_rfrHxU&e=
> 
> One thing I am still not sure(but generic irq affinity supposes to deal with
> well) is that the CPU may become offline after the IO is just submitted,
> then where the IRQ controller delivers the interrupt of this hw queue
> to?
> 
>> This could be reproduced on NVMe with a patch that could hold some rqs on ctx->rq_list,
>> meanwhile a script online and offline the cpus. Then a panic occurred in __queue_work().
> That shouldn't happen, when CPU offline happens the rqs in ctx->rq_list
> are dispatched directly, please see blk_mq_hctx_notify_dead().

Yes, I know. The  blk_mq_hctx_notify_dead will be invoked after the cpu has been set offlined.
Please refer to the following diagram.

CPU A                      CPU T
                 kick  
  _cpu_down()     ->       cpuhp_thread_fun (cpuhpT kthread)
                               AP_ACTIVE           (clear cpu_active_mask)
                                 |
                                 v
                               AP_WORKQUEUE_ONLINE (unbind workers)
                                 |
                                 v
                               TEARDOWN_CPU        (stop_machine)
                                    ,                   | execute
                                     \_ _ _ _ _ _       v
                                        preempt  V  take_cpu_down ( migration kthread)
                                                    set_cpu_online(smp_processor_id(), false) (__cpu_disable)  ------> Here !!!
                                                    TEARDOWN_CPU
                                                        |
             cpuhpT kthead is    |                      v
             migrated away       ,                    AP_SCHED_STARTING (migrate_tasks)
                 _ _ _ _ _ _ _ _/                       |
                V                                       v
              CPU X                                   AP_OFFLINE
                                                        
                                                        |
                                                        ,
                                             _ _ _ _ _ /
                                            V
                                      do_idle (idle task)
 <_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ cpuhp_report_idle_dead
                         complete st->done_down
           __cpu_die (cpuhpT kthread, teardown_cpu) 

 AP_OFFLINE
   |
   v
 BRINGUP_CPU
   |
   v
 BLK_MQ_DEAD    -------> Here !!!
   |
   v
 OFFLINE

The cpu has been cleared in cpu_online_mask when blk_mq_hctx_notify_dead is invoked.
If the device is NVMe which only has one cpu mapped on the hctx, 
cpumask_first_and(hctx->cpumask,cpu_online_mask) will return a bad value.

I even got a backtrace showed that the panic occurred in blk_mq_hctx_notify_dead -> kblocked_schedule_delayed_work_on -> __queue_work.
Kdump doesn't work well on my machine, so I cannot share the backtrace here, that's really sad.
I even added BUG_ON as following, it could be triggered.
>>>>
	if (next_cpu >= nr_cpu_ids)
		next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
	BUG_ON(next_cpu >= nr_cpu_ids);
>>>>

Thanks
Jianchao
> 
>> maybe cpu_possible_mask here, the workers in the pool of the offlined cpu has been unbound.
>> It should be ok to queue on them.
