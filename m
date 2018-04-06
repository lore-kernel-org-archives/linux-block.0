Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
 <20180329104806.GB17537@ming.t460p>
 <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
 <20180329114313.GC17537@ming.t460p>
 <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
 <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p> <20180405161142.GA20972@ming.t460p>
 <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
 <20180406084106.GA8940@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Apr 2018 10:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180406084106.GA8940@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <e3701f81-8616-31b5-cf29-2f788f06aa64@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 04/06/2018 10:41 AM, Ming Lei wrote:
> On Thu, Apr 05, 2018 at 07:39:56PM +0200, Christian Borntraeger wrote:
>>
>>
>> On 04/05/2018 06:11 PM, Ming Lei wrote:
>>>>
>>>> Could you please apply the following patch and provide the dmesg boot log?
>>>
>>> And please post out the 'lscpu' log together from the test machine too.
>>
>> attached.
>>
>> As I said before this seems to go way with CONFIG_NR_CPUS=64 or smaller.
>> We have 282 nr_cpu_ids here (max 141CPUs on that z13 with SMT2) but only 8 Cores
>> == 16 threads.
> 
> OK, thanks!
> 
> The most weird thing is that hctx->next_cpu is computed as 512 since
> nr_cpu_id is 282, and hctx->next_cpu should have pointed to one of
> possible CPU.
> 
> Looks like it is a s390 specific issue, since I can setup one queue
> which has same mapping with yours:
> 
> 	- nr_cpu_id is 282
> 	- CPU 0~15 is online
> 	- 64 queues null_blk
> 	- still run all hw queues in .complete handler
> 
> But can't reproduce this issue at all.
> 
> So please test the following patch, which may tell us why hctx->next_cpu
> is computed wrong:

I see things like

[    8.196907] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196910] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196912] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196913] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196914] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196915] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196917] wrong next_cpu 512, blk_mq_map_swqueue, first_and
[    8.196918] wrong next_cpu 512, blk_mq_map_swqueue, first_and

which is exactly what happens if the find and and operation fails (returns size of bitmap).

FWIW, I added a dump stack for the case when we run unbound before I tested your patch:

Apr 06 10:47:41 s38lp39 kernel: CPU: 15 PID: 86 Comm: ksoftirqd/15 Not tainted 4.16.0-07249-g864f9fc031e4-dirty #2
Apr 06 10:47:41 s38lp39 kernel: Hardware name: IBM 2964 NC9 704 (LPAR)
Apr 06 10:47:41 s38lp39 kernel: Call Trace:
Apr 06 10:47:41 s38lp39 kernel: ([<0000000000113946>] show_stack+0x56/0x80)
Apr 06 10:47:41 s38lp39 kernel:  [<00000000009d8132>] dump_stack+0x82/0xb0 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000006a05de>] blk_mq_hctx_next_cpu+0x12e/0x138 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000006a084c>] __blk_mq_delay_run_hw_queue+0x94/0xd8 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000006a097a>] blk_mq_run_hw_queue+0x82/0x180 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000006a0ae0>] blk_mq_run_hw_queues+0x68/0x88 
Apr 06 10:47:41 s38lp39 kernel:  [<000000000069fc4e>] __blk_mq_complete_request+0x11e/0x1d8 
Apr 06 10:47:41 s38lp39 kernel:  [<000000000069fd94>] blk_mq_complete_request+0x8c/0xc8 
Apr 06 10:47:41 s38lp39 kernel:  [<0000000000824c50>] dasd_block_tasklet+0x158/0x490 
Apr 06 10:47:41 s38lp39 kernel:  [<000000000014a952>] tasklet_action_common.isra.5+0x7a/0x100 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000009f8248>] __do_softirq+0x98/0x368 
Apr 06 10:47:41 s38lp39 kernel:  [<000000000014a322>] run_ksoftirqd+0x4a/0x68 
Apr 06 10:47:41 s38lp39 kernel:  [<000000000016dc20>] smpboot_thread_fn+0x108/0x1b0 
Apr 06 10:47:41 s38lp39 kernel:  [<0000000000168e70>] kthread+0x148/0x160 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000009f727a>] kernel_thread_starter+0x6/0xc 
Apr 06 10:47:41 s38lp39 kernel:  [<00000000009f7274>] kernel_thread_starter+0x0/0xc
