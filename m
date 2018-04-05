Return-Path: <ming.lei@redhat.com>
Date: Fri, 6 Apr 2018 00:05:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
Message-ID: <20180405160503.GA20818@ming.t460p>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 04, 2018 at 10:18:13AM +0200, Christian Borntraeger wrote:
> 
> 
> On 03/30/2018 04:53 AM, Ming Lei wrote:
> > On Thu, Mar 29, 2018 at 01:49:29PM +0200, Christian Borntraeger wrote:
> >>
> >>
> >> On 03/29/2018 01:43 PM, Ming Lei wrote:
> >>> On Thu, Mar 29, 2018 at 12:49:55PM +0200, Christian Borntraeger wrote:
> >>>>
> >>>>
> >>>> On 03/29/2018 12:48 PM, Ming Lei wrote:
> >>>>> On Thu, Mar 29, 2018 at 12:10:11PM +0200, Christian Borntraeger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 03/29/2018 11:40 AM, Ming Lei wrote:
> >>>>>>> On Thu, Mar 29, 2018 at 11:09:08AM +0200, Christian Borntraeger wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 03/29/2018 09:23 AM, Christian Borntraeger wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 03/29/2018 04:00 AM, Ming Lei wrote:
> >>>>>>>>>> On Wed, Mar 28, 2018 at 05:36:53PM +0200, Christian Borntraeger wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On 03/28/2018 05:26 PM, Ming Lei wrote:
> >>>>>>>>>>>> Hi Christian,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
> >>>>>>>>>>>>> FWIW, this patch does not fix the issue for me:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ostname=? addr=? terminal=? res=success'
> >>>>>>>>>>>>> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
> >>>>>>>>>>>>> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
> >>>>>>>>>>>>> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
> >>>>>>>>>>>>> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
> >>>>>>>>>>>>> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
> >>>>>>>>>>>>> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> >>>>>>>>>>>>> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
> >>>>>>>>>>>>> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
> >>>>>>>>>>>>> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
> >>>>>>>>>>>>> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
> >>>>>>>>>>>>> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
> >>>>>>>>>>>>>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
> >>>>>>>>>>>>>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
> >>>>>>>>>>>>>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
> >>>>>>>>>>>>>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
> >>>>>>>>>>>>>                           000000000069c5b2: 07f4		bcr	15,%r4
> >>>>>>>>>>>>>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
> >>>>>>>>>>>>>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
> >>>>>>>>>>>>> [   21.455067] Call Trace:
> >>>>>>>>>>>>> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
> >>>>>>>>>>>>> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
> >>>>>>>>>>>>> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
> >>>>>>>>>>>>> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
> >>>>>>>>>>>>> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
> >>>>>>>>>>>>> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
> >>>>>>>>>>>>> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
> >>>>>>>>>>>>> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
> >>>>>>>>>>>>> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
> >>>>>>>>>>>>> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
> >>>>>>>>>>>>> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
> >>>>>>>>>>>>> [   21.455136] Last Breaking-Event-Address:
> >>>>>>>>>>>>> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
> >>>>>>>>>>>>> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
> >>>>>>>>>>>>> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thinking about this issue further, I can't understand the root cause for
> >>>>>>>>>>>> this issue.
> >>>>>>>>
> >>>>>>>> FWIW, Limiting CONFIG_NR_CPUS to 64 seems to make the problem go away.
> >>>>>>>
> >>>>>>> I think the following patch is needed, and this way aligns to the mapping
> >>>>>>> created via managed IRQ at least.
> >>>>>>>
> >>>>>>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> >>>>>>> index 9f8cffc8a701..638ab5c11b3c 100644
> >>>>>>> --- a/block/blk-mq-cpumap.c
> >>>>>>> +++ b/block/blk-mq-cpumap.c
> >>>>>>> @@ -14,13 +14,12 @@
> >>>>>>>  #include "blk.h"
> >>>>>>>  #include "blk-mq.h"
> >>>>>>>
> >>>>>>> +/*
> >>>>>>> + * Given there isn't CPU hotplug handler in blk-mq, map all possible CPUs to
> >>>>>>> + * queues even it isn't present yet.
> >>>>>>> + */
> >>>>>>>  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
> >>>>>>>  {
> >>>>>>> -	/*
> >>>>>>> -	 * Non present CPU will be mapped to queue index 0.
> >>>>>>> -	 */
> >>>>>>> -	if (!cpu_present(cpu))
> >>>>>>> -		return 0;
> >>>>>>>  	return cpu % nr_queues;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Ming
> >>>>>>>
> >>>>>>
> >>>>>> With that I no longer see the WARN_ON but the other warning instead:
> >>>>>>
> >>>>>> [   31.903096] audit: type=1130 audit(1522318064.439:41): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> >>>>>> [   31.903100] audit: type=1131 audit(1522318064.439:42): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> >>>>>> [   31.985756] systemd-journald[379]: Received SIGTERM from PID 1 (systemd).
> >>>>>> [   32.000543] systemd: 18 output lines suppressed due to ratelimiting
> >>>>>> [   32.209496] EXT4-fs (dasdc1): re-mounted. Opts: (null)
> >>>>>> [   32.234808] systemd-journald[2490]: Received request to flush runtime journal from PID 1
> >>>>>> [   32.359832] tun: Universal TUN/TAP device driver, 1.6
> >>>>>> [   32.470841] run queue from wrong CPU 18, hctx active
> >>>>>
> >>>>> But your 'lscpu' log showed that you only have 16 CPUs online(0~15) and
> >>>>> you also said CPU hotplug isn't involved in your test, so I am just
> >>>>> wondering where the CPU 18 is from?
> >>>>
> >>>>
> >>>> I have 2 test systems. One with 44CPU the other with 16.
> >>>> The one  with 16 now has the same flood of messages:
> >>>>
> >>>>
> >>>>     4.454510]  dasdc:VOL1/  0X3F77: dasdc1
> >>>> [    4.454592]  dasdd:VOL1/  0X3F74: dasdd1
> >>>> [    4.593711] run queue from wrong CPU 0, hctx active
> >>>
> >>> Still can't reproduce your issue, could you please collect debugfs
> >>> log again on your 16-core system after applying the patch on blk_mq_cpumap.c?
> >>
> >> done.
> > 
> > OK, thanks, from the dumped mapping, looks everything is fine, each hctx
> > is mapped to 4 CPUs, and only one of them is online.
> > 
> > But still don't know why hctx is run from wrong CPU, looks we need more
> > info to dump, could you apply the following debug patch and post the
> > log?
> > 
> > ---
> > diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> > index 9f8cffc8a701..638ab5c11b3c 100644
> > --- a/block/blk-mq-cpumap.c
> > +++ b/block/blk-mq-cpumap.c
> > @@ -14,13 +14,12 @@
> >  #include "blk.h"
> >  #include "blk-mq.h"
> > 
> > +/*
> > + * Given there isn't CPU hotplug handler in blk-mq, map all CPUs to
> > + * queues even it isn't present yet.
> > + */
> >  static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
> >  {
> > -	/*
> > -	 * Non present CPU will be mapped to queue index 0.
> > -	 */
> > -	if (!cpu_present(cpu))
> > -		return 0;
> >  	return cpu % nr_queues;
> >  }
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 16e83e6df404..65767be7927d 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1325,9 +1325,14 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> >  	 */
> >  	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> >  		cpu_online(hctx->next_cpu)) {
> > -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> > -			raw_smp_processor_id(),
> > +		int cpu;
> > +		printk(KERN_WARNING "run queue from wrong CPU %d/%d, hctx-%d %s\n",
> > +			raw_smp_processor_id(), hctx->next_cpu,
> > +			hctx->queue_num,
> >  			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> > +		for_each_cpu(cpu, hctx->cpumask)
> > +			printk("%d ", cpu);
> > +		printk("\n");
> >  		dump_stack();
> >  	}
> > 
> 
> 
> attached. FWIW, it looks like these messages happen mostly during boot and come less
> and less often the longer the system runs. Could it be that the workqeue is misplaced
> before it runs for the first time, but then it is ok?

Looks not workqueue's issue, and it shows that hctx->next_cpu is figured
out as wrong by blk_mq_hctx_next_cpu(), maybe on your ARCH, either 'nr_cpu_ids'
or 'cpu_online_mask' is too strange during booting and breaks blk_mq_hctx_next_cpu().

Could you please apply the following patch and provide the dmesg boot log?

---
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9f8cffc8a701..638ab5c11b3c 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -14,13 +14,12 @@
 #include "blk.h"
 #include "blk-mq.h"
 
+/*
+ * Given there isn't CPU hotplug handler in blk-mq, map all CPUs to
+ * queues even it isn't present yet.
+ */
 static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
 {
-	/*
-	 * Non present CPU will be mapped to queue index 0.
-	 */
-	if (!cpu_present(cpu))
-		return 0;
 	return cpu % nr_queues;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90838e998f66..996f8a963026 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1324,9 +1324,18 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
 		cpu_online(hctx->next_cpu)) {
-		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
-			raw_smp_processor_id(),
+		int cpu;
+		printk(KERN_WARNING "run queue from wrong CPU %d/%d, hctx-%d %s\n",
+			raw_smp_processor_id(), hctx->next_cpu,
+			hctx->queue_num,
 			cpumask_empty(hctx->cpumask) ? "inactive": "active");
+		printk("dump CPUs mapped to this hctx:\n");
+		for_each_cpu(cpu, hctx->cpumask)
+			printk("%d ", cpu);
+		printk("\n");
+		printk("nr_cpu_ids is %d, and dump online cpus:\n", nr_cpu_ids);
+		for_each_cpu(cpu, cpu_online_mask)
+			printk("%d ", cpu);
 		dump_stack();
 	}
 

Thanks,
Ming
