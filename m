Return-Path: <prvs=0626c35109=borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
 <20180328152617.GA6071@ming.t460p>
 <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
 <20180329020021.GA29317@ming.t460p>
 <b3f7e1b5-2de4-80d3-8125-c2a1da8ba9a6@de.ibm.com>
 <d3a45ead-7d6c-a7b2-0d7a-9d54f9e66e4a@de.ibm.com>
 <20180329094016.GA17190@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Mar 2018 12:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180329094016.GA17190@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 03/29/2018 11:40 AM, Ming Lei wrote:
> On Thu, Mar 29, 2018 at 11:09:08AM +0200, Christian Borntraeger wrote:
>>
>>
>> On 03/29/2018 09:23 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 03/29/2018 04:00 AM, Ming Lei wrote:
>>>> On Wed, Mar 28, 2018 at 05:36:53PM +0200, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 03/28/2018 05:26 PM, Ming Lei wrote:
>>>>>> Hi Christian,
>>>>>>
>>>>>> On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
>>>>>>> FWIW, this patch does not fix the issue for me:
>>>>>>>
>>>>>>> ostname=? addr=? terminal=? res=success'
>>>>>>> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
>>>>>>> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
>>>>>>> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
>>>>>>> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
>>>>>>> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
>>>>>>> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>>>>>> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
>>>>>>> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
>>>>>>> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
>>>>>>> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
>>>>>>> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
>>>>>>>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
>>>>>>>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
>>>>>>>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>                           000000000069c5b2: 07f4		bcr	15,%r4
>>>>>>>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
>>>>>>>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
>>>>>>> [   21.455067] Call Trace:
>>>>>>> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
>>>>>>> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
>>>>>>> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
>>>>>>> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
>>>>>>> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
>>>>>>> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
>>>>>>> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
>>>>>>> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
>>>>>>> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
>>>>>>> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
>>>>>>> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
>>>>>>> [   21.455136] Last Breaking-Event-Address:
>>>>>>> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
>>>>>>> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
>>>>>>> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring
>>>>>>
>>>>>> Thinking about this issue further, I can't understand the root cause for
>>>>>> this issue.
>>
>> FWIW, Limiting CONFIG_NR_CPUS to 64 seems to make the problem go away.
> 
> I think the following patch is needed, and this way aligns to the mapping
> created via managed IRQ at least.
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9f8cffc8a701..638ab5c11b3c 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -14,13 +14,12 @@
>  #include "blk.h"
>  #include "blk-mq.h"
> 
> +/*
> + * Given there isn't CPU hotplug handler in blk-mq, map all possible CPUs to
> + * queues even it isn't present yet.
> + */
>  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>  {
> -	/*
> -	 * Non present CPU will be mapped to queue index 0.
> -	 */
> -	if (!cpu_present(cpu))
> -		return 0;
>  	return cpu % nr_queues;
>  }
> 
> Thanks,
> Ming
> 

With that I no longer see the WARN_ON but the other warning instead:

[   31.903096] audit: type=1130 audit(1522318064.439:41): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   31.903100] audit: type=1131 audit(1522318064.439:42): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   31.985756] systemd-journald[379]: Received SIGTERM from PID 1 (systemd).
[   32.000543] systemd: 18 output lines suppressed due to ratelimiting
[   32.209496] EXT4-fs (dasdc1): re-mounted. Opts: (null)
[   32.234808] systemd-journald[2490]: Received request to flush runtime journal from PID 1
[   32.359832] tun: Universal TUN/TAP device driver, 1.6
[   32.470841] run queue from wrong CPU 18, hctx active
[   32.470845] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470847] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470856] Workqueue: kblockd blk_mq_run_work_fn
[   32.470857] Call Trace:
[   32.470862] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470867]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470869]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470873]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470875]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470877]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470880]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470882]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470889] run queue from wrong CPU 18, hctx active
[   32.470891] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470892] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470894] Workqueue: kblockd blk_mq_run_work_fn
[   32.470895] Call Trace:
[   32.470897] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470898]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470900]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470902]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470903]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470905]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470906]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470908]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470910] run queue from wrong CPU 18, hctx active
[   32.470911] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470913] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470914] Workqueue: kblockd blk_mq_run_work_fn
[   32.470916] Call Trace:
[   32.470918] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470919]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470921]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470922]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470924]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470925]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470927]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470929]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470930] run queue from wrong CPU 18, hctx active
[   32.470932] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470933] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470935] Workqueue: kblockd blk_mq_run_work_fn
[   32.470936] Call Trace:
[   32.470938] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470939]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470941]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470943]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470944]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470946]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470947]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470949]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470950] run queue from wrong CPU 18, hctx active
[   32.470952] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470953] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470955] Workqueue: kblockd blk_mq_run_work_fn
[   32.470956] Call Trace:
[   32.470958] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470959]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470961]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470963]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470964]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470966]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470967]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470969]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470971] run queue from wrong CPU 18, hctx active
[   32.470972] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470973] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470975] Workqueue: kblockd blk_mq_run_work_fn
[   32.470976] Call Trace:
[   32.470978] ([<0000000000113b86>] show_stack+0x56/0x80)
[   32.470979]  [<0000000000a5cd02>] dump_stack+0x82/0xb0 
[   32.470981]  [<000000000069c40a>] __blk_mq_run_hw_queue+0x12a/0x130 
[   32.470983]  [<0000000000163906>] process_one_work+0x1be/0x420 
[   32.470985]  [<0000000000163bc0>] worker_thread+0x58/0x458 
[   32.470986]  [<000000000016a9d0>] kthread+0x148/0x160 
[   32.470988]  [<0000000000a7bea2>] kernel_thread_starter+0x6/0xc 
[   32.470989]  [<0000000000a7be9c>] kernel_thread_starter+0x0/0xc 
[   32.470991] run queue from wrong CPU 18, hctx active
[   32.470992] CPU: 18 PID: 2131 Comm: kworker/18:1H Not tainted 4.16.0-rc7+ #31
[   32.470993] Hardware name: IBM 2964 NC9 704 (LPAR)
[   32.470995] Workqueue: kblockd blk_mq_run_work_fn
