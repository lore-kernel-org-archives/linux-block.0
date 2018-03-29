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
 <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
 <20180329104806.GB17537@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Mar 2018 12:49:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180329104806.GB17537@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 03/29/2018 12:48 PM, Ming Lei wrote:
> On Thu, Mar 29, 2018 at 12:10:11PM +0200, Christian Borntraeger wrote:
>>
>>
>> On 03/29/2018 11:40 AM, Ming Lei wrote:
>>> On Thu, Mar 29, 2018 at 11:09:08AM +0200, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 03/29/2018 09:23 AM, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 03/29/2018 04:00 AM, Ming Lei wrote:
>>>>>> On Wed, Mar 28, 2018 at 05:36:53PM +0200, Christian Borntraeger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 03/28/2018 05:26 PM, Ming Lei wrote:
>>>>>>>> Hi Christian,
>>>>>>>>
>>>>>>>> On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
>>>>>>>>> FWIW, this patch does not fix the issue for me:
>>>>>>>>>
>>>>>>>>> ostname=? addr=? terminal=? res=success'
>>>>>>>>> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
>>>>>>>>> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
>>>>>>>>> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
>>>>>>>>> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
>>>>>>>>> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
>>>>>>>>> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>>>>>>>> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
>>>>>>>>> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
>>>>>>>>> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
>>>>>>>>> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
>>>>>>>>> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>>>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
>>>>>>>>>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
>>>>>>>>>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
>>>>>>>>>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>>>                           000000000069c5b2: 07f4		bcr	15,%r4
>>>>>>>>>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
>>>>>>>>>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
>>>>>>>>> [   21.455067] Call Trace:
>>>>>>>>> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
>>>>>>>>> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
>>>>>>>>> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
>>>>>>>>> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
>>>>>>>>> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
>>>>>>>>> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
>>>>>>>>> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
>>>>>>>>> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
>>>>>>>>> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
>>>>>>>>> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
>>>>>>>>> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
>>>>>>>>> [   21.455136] Last Breaking-Event-Address:
>>>>>>>>> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
>>>>>>>>> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
>>>>>>>>> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring
>>>>>>>>
>>>>>>>> Thinking about this issue further, I can't understand the root cause for
>>>>>>>> this issue.
>>>>
>>>> FWIW, Limiting CONFIG_NR_CPUS to 64 seems to make the problem go away.
>>>
>>> I think the following patch is needed, and this way aligns to the mapping
>>> created via managed IRQ at least.
>>>
>>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>>> index 9f8cffc8a701..638ab5c11b3c 100644
>>> --- a/block/blk-mq-cpumap.c
>>> +++ b/block/blk-mq-cpumap.c
>>> @@ -14,13 +14,12 @@
>>>  #include "blk.h"
>>>  #include "blk-mq.h"
>>>
>>> +/*
>>> + * Given there isn't CPU hotplug handler in blk-mq, map all possible CPUs to
>>> + * queues even it isn't present yet.
>>> + */
>>>  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>>>  {
>>> -	/*
>>> -	 * Non present CPU will be mapped to queue index 0.
>>> -	 */
>>> -	if (!cpu_present(cpu))
>>> -		return 0;
>>>  	return cpu % nr_queues;
>>>  }
>>>
>>> Thanks,
>>> Ming
>>>
>>
>> With that I no longer see the WARN_ON but the other warning instead:
>>
>> [   31.903096] audit: type=1130 audit(1522318064.439:41): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>> [   31.903100] audit: type=1131 audit(1522318064.439:42): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>> [   31.985756] systemd-journald[379]: Received SIGTERM from PID 1 (systemd).
>> [   32.000543] systemd: 18 output lines suppressed due to ratelimiting
>> [   32.209496] EXT4-fs (dasdc1): re-mounted. Opts: (null)
>> [   32.234808] systemd-journald[2490]: Received request to flush runtime journal from PID 1
>> [   32.359832] tun: Universal TUN/TAP device driver, 1.6
>> [   32.470841] run queue from wrong CPU 18, hctx active
> 
> But your 'lscpu' log showed that you only have 16 CPUs online(0~15) and
> you also said CPU hotplug isn't involved in your test, so I am just
> wondering where the CPU 18 is from?


I have 2 test systems. One with 44CPU the other with 16.
The one  with 16 now has the same flood of messages:


    4.454510]  dasdc:VOL1/  0X3F77: dasdc1
[    4.454592]  dasdd:VOL1/  0X3F74: dasdd1
[    4.593711] run queue from wrong CPU 0, hctx active
[    4.593715] CPU: 0 PID: 4 Comm: kworker/0:0H Not tainted 4.16.0-rc7+ #1
[    4.593717] Hardware name: IBM 2964 NC9 704 (LPAR)
[    4.593724] Workqueue: kblockd blk_mq_run_work_fn
[    4.593726] Call Trace:
[    4.593731] ([<0000000000113b86>] show_stack+0x56/0x80)
[    4.593735]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    4.593737]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    4.593741]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    4.593742]  [<0000000000163198>] worker_thread+0x58/0x458 
[    4.593745]  [<0000000000169fa8>] kthread+0x148/0x160 
[    4.593748]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    4.593749]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    4.611606] dasdconf.sh Warning: 0.0.3f75 is already online, not configuring
[    4.626454] run queue from wrong CPU 10, hctx active
[    4.626456] CPU: 10 PID: 62 Comm: kworker/10:0H Not tainted 4.16.0-rc7+ #1
[    4.626458] Hardware name: IBM 2964 NC9 704 (LPAR)
[    4.626462] Workqueue: kblockd blk_mq_run_work_fn
[    4.626463] Call Trace:
[    4.626466] ([<0000000000113b86>] show_stack+0x56/0x80)
[    4.626468]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    4.626469]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    4.626471]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    4.626473]  [<0000000000163198>] worker_thread+0x58/0x458 
[    4.626474]  [<0000000000169fa8>] kthread+0x148/0x160 
[    4.626476]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    4.626477]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    4.699514] dasdconf.sh Warning: 0.0.3f76 is already online, not configuring
[    4.709725] random: crng init done
[    4.711200] dasdconf.sh Warning: 0.0.3f74 is already online, not configuring
[    4.718452] dasdconf.sh Warning: 0.0.3f77 is already online, not configuring
[    4.726455] EXT4-fs (dasdd1): mounted filesystem with ordered data mode. Opts: (null)
[    5.075280] systemd-journald[208]: Received SIGTERM from PID 1 (systemd).
[    5.114536] run queue from wrong CPU 8, hctx active
[    5.114539] CPU: 8 PID: 1542 Comm: kworker/8:1H Not tainted 4.16.0-rc7+ #1
[    5.114541] Hardware name: IBM 2964 NC9 704 (LPAR)
[    5.114544] Workqueue: kblockd blk_mq_run_work_fn
[    5.114545] Call Trace:
[    5.114548] ([<0000000000113b86>] show_stack+0x56/0x80)
[    5.114550]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    5.114551]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    5.114553]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    5.114555]  [<0000000000163198>] worker_thread+0x58/0x458 
[    5.114556]  [<0000000000169fa8>] kthread+0x148/0x160 
[    5.114558]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    5.114559]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    5.137222] systemd: 16 output lines suppressed due to ratelimiting
[    5.663932] run queue from wrong CPU 7, hctx active
[    5.663959] CPU: 7 PID: 1574 Comm: kworker/7:1H Not tainted 4.16.0-rc7+ #1
[    5.663972] Hardware name: IBM 2964 NC9 704 (LPAR)
[    5.663999] Workqueue: kblockd blk_mq_run_work_fn
[    5.664012] Call Trace:
[    5.664034] ([<0000000000113b86>] show_stack+0x56/0x80)
[    5.664053]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    5.664064]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    5.664082]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    5.664097]  [<0000000000163198>] worker_thread+0x58/0x458 
[    5.664110]  [<0000000000169fa8>] kthread+0x148/0x160 
[    5.664123]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    5.664136]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    5.796783] run queue from wrong CPU 7, hctx active
[    5.796811] CPU: 7 PID: 1574 Comm: kworker/7:1H Not tainted 4.16.0-rc7+ #1
[    5.796828] Hardware name: IBM 2964 NC9 704 (LPAR)
[    5.796850] Workqueue: kblockd blk_mq_run_work_fn
[    5.796866] Call Trace:
[    5.796874] ([<0000000000113b86>] show_stack+0x56/0x80)
[    5.796878]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    5.796888]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    5.796902]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    5.796917]  [<0000000000163198>] worker_thread+0x58/0x458 
[    5.796931]  [<0000000000169fa8>] kthread+0x148/0x160 
[    5.796944]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    5.796957]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    5.824996] run queue from wrong CPU 7, hctx active
[    5.825017] CPU: 7 PID: 1574 Comm: kworker/7:1H Not tainted 4.16.0-rc7+ #1
[    5.825028] Hardware name: IBM 2964 NC9 704 (LPAR)
[    5.825046] Workqueue: kblockd blk_mq_run_work_fn
[    5.825061] Call Trace:
[    5.825076] ([<0000000000113b86>] show_stack+0x56/0x80)
[    5.825089]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    5.825105]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    5.825119]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    5.825133]  [<0000000000163198>] worker_thread+0x58/0x458 
[    5.825147]  [<0000000000169fa8>] kthread+0x148/0x160 
[    5.825160]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    5.825176]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    5.900186] run queue from wrong CPU 7, hctx active
[    5.900211] CPU: 7 PID: 1574 Comm: kworker/7:1H Not tainted 4.16.0-rc7+ #1
[    5.900246] Hardware name: IBM 2964 NC9 704 (LPAR)
[    5.900269] Workqueue: kblockd blk_mq_run_work_fn
[    5.900280] Call Trace:
[    5.900298] ([<0000000000113b86>] show_stack+0x56/0x80)
[    5.900314]  [<0000000000a5acd2>] dump_stack+0x82/0xb0 
[    5.900318]  [<000000000069a3ea>] __blk_mq_run_hw_queue+0x12a/0x130 
[    5.900322]  [<0000000000162ede>] process_one_work+0x1be/0x420 
[    5.900338]  [<0000000000163198>] worker_thread+0x58/0x458 
[    5.900351]  [<0000000000169fa8>] kthread+0x148/0x160 
[    5.900365]  [<0000000000a79e72>] kernel_thread_starter+0x6/0xc 
[    5.900379]  [<0000000000a79e6c>] kernel_thread_starter+0x0/0xc 
[    6.221462] EXT4-fs (dasdd1): re-mounted. Opts: (null)
[    6.249875] run queue from wrong CPU 4, hctx active
[    6.249883] CPU: 4 PID: 1515 Comm: kworker/4:1H Not tainted 4.16.0-rc7+ #1
[    6.249886] Hardware name: IBM 2964 NC9 704 (LPAR)
[    6.249892] Workqueue: kblockd blk_mq_run_work_fn
[    6.249895] Call Trace:
[    6.249899] ([<0000000000113b86>] sho
