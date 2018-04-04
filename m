Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
 <20180329020021.GA29317@ming.t460p>
 <b3f7e1b5-2de4-80d3-8125-c2a1da8ba9a6@de.ibm.com>
 <d3a45ead-7d6c-a7b2-0d7a-9d54f9e66e4a@de.ibm.com>
 <20180329094016.GA17190@ming.t460p>
 <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
 <20180329104806.GB17537@ming.t460p>
 <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
 <20180329114313.GC17537@ming.t460p>
 <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Apr 2018 10:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180330025340.GB12412@ming.t460p>
Content-Type: multipart/mixed;
 boundary="------------923F99EAFA55DBC935E009F9"
Message-Id: <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

This is a multi-part message in MIME format.
--------------923F99EAFA55DBC935E009F9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



On 03/30/2018 04:53 AM, Ming Lei wrote:
> On Thu, Mar 29, 2018 at 01:49:29PM +0200, Christian Borntraeger wrote:
>>
>>
>> On 03/29/2018 01:43 PM, Ming Lei wrote:
>>> On Thu, Mar 29, 2018 at 12:49:55PM +0200, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 03/29/2018 12:48 PM, Ming Lei wrote:
>>>>> On Thu, Mar 29, 2018 at 12:10:11PM +0200, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 03/29/2018 11:40 AM, Ming Lei wrote:
>>>>>>> On Thu, Mar 29, 2018 at 11:09:08AM +0200, Christian Borntraeger wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 03/29/2018 09:23 AM, Christian Borntraeger wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 03/29/2018 04:00 AM, Ming Lei wrote:
>>>>>>>>>> On Wed, Mar 28, 2018 at 05:36:53PM +0200, Christian Borntraeger wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 03/28/2018 05:26 PM, Ming Lei wrote:
>>>>>>>>>>>> Hi Christian,
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
>>>>>>>>>>>>> FWIW, this patch does not fix the issue for me:
>>>>>>>>>>>>>
>>>>>>>>>>>>> ostname=? addr=? terminal=? res=success'
>>>>>>>>>>>>> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
>>>>>>>>>>>>> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
>>>>>>>>>>>>> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
>>>>>>>>>>>>> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
>>>>>>>>>>>>> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
>>>>>>>>>>>>> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>>>>>>>>>>>> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
>>>>>>>>>>>>> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
>>>>>>>>>>>>> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
>>>>>>>>>>>>> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
>>>>>>>>>>>>> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>>>>>>>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
>>>>>>>>>>>>>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
>>>>>>>>>>>>>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
>>>>>>>>>>>>>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>>>>>>>>>>>                           000000000069c5b2: 07f4		bcr	15,%r4
>>>>>>>>>>>>>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
>>>>>>>>>>>>>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
>>>>>>>>>>>>> [   21.455067] Call Trace:
>>>>>>>>>>>>> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
>>>>>>>>>>>>> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
>>>>>>>>>>>>> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
>>>>>>>>>>>>> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
>>>>>>>>>>>>> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
>>>>>>>>>>>>> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
>>>>>>>>>>>>> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
>>>>>>>>>>>>> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
>>>>>>>>>>>>> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
>>>>>>>>>>>>> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
>>>>>>>>>>>>> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
>>>>>>>>>>>>> [   21.455136] Last Breaking-Event-Address:
>>>>>>>>>>>>> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
>>>>>>>>>>>>> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
>>>>>>>>>>>>> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring
>>>>>>>>>>>>
>>>>>>>>>>>> Thinking about this issue further, I can't understand the root cause for
>>>>>>>>>>>> this issue.
>>>>>>>>
>>>>>>>> FWIW, Limiting CONFIG_NR_CPUS to 64 seems to make the problem go away.
>>>>>>>
>>>>>>> I think the following patch is needed, and this way aligns to the mapping
>>>>>>> created via managed IRQ at least.
>>>>>>>
>>>>>>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>>>>>>> index 9f8cffc8a701..638ab5c11b3c 100644
>>>>>>> --- a/block/blk-mq-cpumap.c
>>>>>>> +++ b/block/blk-mq-cpumap.c
>>>>>>> @@ -14,13 +14,12 @@
>>>>>>>  #include "blk.h"
>>>>>>>  #include "blk-mq.h"
>>>>>>>
>>>>>>> +/*
>>>>>>> + * Given there isn't CPU hotplug handler in blk-mq, map all possible CPUs to
>>>>>>> + * queues even it isn't present yet.
>>>>>>> + */
>>>>>>>  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>>>>>>>  {
>>>>>>> -	/*
>>>>>>> -	 * Non present CPU will be mapped to queue index 0.
>>>>>>> -	 */
>>>>>>> -	if (!cpu_present(cpu))
>>>>>>> -		return 0;
>>>>>>>  	return cpu % nr_queues;
>>>>>>>  }
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Ming
>>>>>>>
>>>>>>
>>>>>> With that I no longer see the WARN_ON but the other warning instead:
>>>>>>
>>>>>> [   31.903096] audit: type=1130 audit(1522318064.439:41): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>>>>> [   31.903100] audit: type=1131 audit(1522318064.439:42): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
>>>>>> [   31.985756] systemd-journald[379]: Received SIGTERM from PID 1 (systemd).
>>>>>> [   32.000543] systemd: 18 output lines suppressed due to ratelimiting
>>>>>> [   32.209496] EXT4-fs (dasdc1): re-mounted. Opts: (null)
>>>>>> [   32.234808] systemd-journald[2490]: Received request to flush runtime journal from PID 1
>>>>>> [   32.359832] tun: Universal TUN/TAP device driver, 1.6
>>>>>> [   32.470841] run queue from wrong CPU 18, hctx active
>>>>>
>>>>> But your 'lscpu' log showed that you only have 16 CPUs online(0~15) and
>>>>> you also said CPU hotplug isn't involved in your test, so I am just
>>>>> wondering where the CPU 18 is from?
>>>>
>>>>
>>>> I have 2 test systems. One with 44CPU the other with 16.
>>>> The one  with 16 now has the same flood of messages:
>>>>
>>>>
>>>>     4.454510]  dasdc:VOL1/  0X3F77: dasdc1
>>>> [    4.454592]  dasdd:VOL1/  0X3F74: dasdd1
>>>> [    4.593711] run queue from wrong CPU 0, hctx active
>>>
>>> Still can't reproduce your issue, could you please collect debugfs
>>> log again on your 16-core system after applying the patch on blk_mq_cpumap.c?
>>
>> done.
> 
> OK, thanks, from the dumped mapping, looks everything is fine, each hctx
> is mapped to 4 CPUs, and only one of them is online.
> 
> But still don't know why hctx is run from wrong CPU, looks we need more
> info to dump, could you apply the following debug patch and post the
> log?
> 
> ---
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9f8cffc8a701..638ab5c11b3c 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -14,13 +14,12 @@
>  #include "blk.h"
>  #include "blk-mq.h"
> 
> +/*
> + * Given there isn't CPU hotplug handler in blk-mq, map all CPUs to
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
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 16e83e6df404..65767be7927d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1325,9 +1325,14 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
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
> +		for_each_cpu(cpu, hctx->cpumask)
> +			printk("%d ", cpu);
> +		printk("\n");
>  		dump_stack();
>  	}
> 


attached. FWIW, it looks like these messages happen mostly during boot and come less
and less often the longer the system runs. Could it be that the workqeue is misplaced
before it runs for the first time, but then it is ok?



--------------923F99EAFA55DBC935E009F9
Content-Type: application/gzip;
 name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.gz"

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
UBe01TdkDnVBX30biAqkBqcehCnoyS/HzCkeGo899IveQ7/oPfTLJA/9Yhrj/6SYNc5lSjDT
euiXCR76ZYKHfkGnzj7MDO+bFXTrJPrFGqrXhP6hLFZFiGVIQbNOSyxDagyqIolu12yZWuOv
6ylq/DVLQR6aYLbJc6uaPKeekFscuzfqyHPDE3LrEiPFx5qunJBbM4eLj4VbYMrJc/03OMNb
aQWtL4mksYbqZ5QoGovDGTHERWSLWeIiUmMgyUp0B4fmkhPJc5q5MQWNJsXk+aMmdn1JK8mq
qdqyf3FzTqXVdYYfLbmxpIw87am0mjm+g2s7QgrJS92FEsO7awXNIA29JqA5JiLHLWSIsUhB
g0dr6EWBLopNdFO3uSROJC9rSpQuy8WQxZUjMWR9SU8ec1fsJ4+5KurI4yaJYvK4R6KIPL9q
73mej5UTk+fZfDk5ed703/N4w62m425t2YeI7rGg96EhXiMFTQ8t8RqpMSinJLrP83ZuOcVr
7HuKV9j3FH9o31PQeVBHnuca2F7yPNNhKMljBXY5eY1h8xLytPY9NXNYUVLXGG8O+NhdtbSN
5gCa+VmKD9SSiUarhqDC4imgsMG0hhIKtzebEiUvT/VAqOspRCYFXe3E5JUjkUlB6zolefxk
cC953NpOR15gXXQxeS2LOwF5odE87yMvTLjncXc8KXm57rbqO7i+vL++evP61Yv7H5a/Xd69
vnn9j4tlfbG+cK/qDejmfrm8hXV+W968vr15ffq35XX9iEPCzT/e39V/+Gm9gBM+nlsvSdaD
ltD6/HpRsF4o1kN7/Z+ndz+8OOXVX/ltnZNf14vl67ubN3c3735b/gKfupqH69y/f/v2Tb18
10+rbDKpf17fvHlMt8tXLz+tP395+dli/ffL+3vI//TLC7P85Ys/vPzTxbp8/Q38v28//7z+
98sv//jpxfK35dOvP6warUfrBfzd4uX1K1/Of7dvfzgt16efb65Oy93p7d3p/vT6XX3fyx/u
bq7/cap4v738/va0fF1/06cVA9qH44pXV+tVSOcr/unTz5bL6+u61P2y2osagv+Yi5O/qE8n
9++vAKBX729vf6s/8R839/UDVL/Q6jt8+DXqqubpR8UVHkDxR9l4XW/25z/q8y0D/lD1Mn2+
fPHrW/yxV/X7b/no9vTz6fZiCfVe/vHvFvqvX27e/bDUv+mPy7vf3p4g+Tuz/vHLP744+8l4
E8Of/Gq19d/nP/kvn3/5Vf34vLuEj8PrU71x1Ddwc//m9vLhf9V3g7eTy7M/cKwPOFAA//T6
Gv6Itn4lxGjXH5f7Xy7fwhX4fb0Ev4cP5aV5sTx+bC4+scvp13fwh7mAm9Tdm/v7i6fkly//
4+WHn5CsxRNA8Fs//rbL6fXV1S9Pv/vdCW4L19vd8PxqZ6DCn2W/CufZ8P949orZxrzwLhTQ
M1zevr+8+PDH/OHy9fXt6e7sL/30j2+SlNNPVz3/tLc41PHu+rLrHw+b/mz7Bz/56fLt29Pd
xfK+fiJev7tYfj7d3cOfyQDqTzmbHmOXc/Pm6l39FPkXLtUbLv6/5SO7mvTJWj6x68fLzeub
dzeXtzf3p+v6m/30yTV87P5v/WV+uHz34urNTx/WD36rpHzx92/9J6/ul4/w28d8fLH89OY9
3tRf3dye7n+r7+Sn7fP55u4a2cDP2U9vrk8vlq/e1g/B8tHris/HjwunFVUMZOHvJyycXAnQ
Kfrm688ulm+eWN0+AH/985d/X+7rY8KpPpbcXb6+h28zWO397enF+RLgY7Bf4v3123+R5HjS
u6t/leTbSX/+j5c/1yem5fv66HBVPzX1Fna0kH2RQ8DjYl9+/XO8WD79/PNvPvvqz//x0Z+/
+PbzL/7fd3/9ul7XHVD4PVKRh291vF88LZUDiCp6ltroOl4qFvTa6vvSdfnCFfjeLbn+d8+X
7vk7evyZya1+bfzM7Xc9+pkpCn8mLPe7/w+3C9+iPKsCAA==
--------------923F99EAFA55DBC935E009F9--
