Return-Path: <ming.lei@redhat.com>
Date: Fri, 6 Apr 2018 21:41:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
Message-ID: <20180406134133.GA10791@ming.t460p>
References: <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
 <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p>
 <20180405161142.GA20972@ming.t460p>
 <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
 <20180406084106.GA8940@ming.t460p>
 <e3701f81-8616-31b5-cf29-2f788f06aa64@de.ibm.com>
 <20180406092309.GB9605@ming.t460p>
 <e2dbf168-8583-2011-6520-02bf17051cd2@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e2dbf168-8583-2011-6520-02bf17051cd2@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 06, 2018 at 12:19:19PM +0200, Christian Borntraeger wrote:
> 
> 
> On 04/06/2018 11:23 AM, Ming Lei wrote:
> > On Fri, Apr 06, 2018 at 10:51:28AM +0200, Christian Borntraeger wrote:
> >>
> >>
> >> On 04/06/2018 10:41 AM, Ming Lei wrote:
> >>> On Thu, Apr 05, 2018 at 07:39:56PM +0200, Christian Borntraeger wrote:
> >>>>
> >>>>
> >>>> On 04/05/2018 06:11 PM, Ming Lei wrote:
> >>>>>>
> >>>>>> Could you please apply the following patch and provide the dmesg boot log?
> >>>>>
> >>>>> And please post out the 'lscpu' log together from the test machine too.
> >>>>
> >>>> attached.
> >>>>
> >>>> As I said before this seems to go way with CONFIG_NR_CPUS=64 or smaller.
> >>>> We have 282 nr_cpu_ids here (max 141CPUs on that z13 with SMT2) but only 8 Cores
> >>>> == 16 threads.
> >>>
> >>> OK, thanks!
> >>>
> >>> The most weird thing is that hctx->next_cpu is computed as 512 since
> >>> nr_cpu_id is 282, and hctx->next_cpu should have pointed to one of
> >>> possible CPU.
> >>>
> >>> Looks like it is a s390 specific issue, since I can setup one queue
> >>> which has same mapping with yours:
> >>>
> >>> 	- nr_cpu_id is 282
> >>> 	- CPU 0~15 is online
> >>> 	- 64 queues null_blk
> >>> 	- still run all hw queues in .complete handler
> >>>
> >>> But can't reproduce this issue at all.
> >>>
> >>> So please test the following patch, which may tell us why hctx->next_cpu
> >>> is computed wrong:
> >>
> >> I see things like
> >>
> >> [    8.196907] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196910] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196912] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196913] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196914] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196915] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196917] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >> [    8.196918] wrong next_cpu 512, blk_mq_map_swqueue, first_and
> >>
> >> which is exactly what happens if the find and and operation fails (returns size of bitmap).
> > 
> > Given both 'cpu_online_mask' and 'hctx->cpumask' are shown as correct
> > in your previous debug log, it means the following function returns
> > totally wrong result on S390.
> > 
> > 	cpumask_first_and(hctx->cpumask, cpu_online_mask);
> > 
> > The debugfs log shows that each hctx->cpumask includes one online
> > CPU(0~15).
> 
> Really? the last log (with the latest patch applied  shows a lot of contexts
> that do not have CPUs in 0-15:
> 
> e.g. 
> [    4.049828] dump CPUs mapped to this hctx:
> [    4.049829] 18 
> [    4.049829] 82 
> [    4.049830] 146 
> [    4.049830] 210 
> [    4.049831] 274 

That won't be an issue, since no IO can be submitted from these offline
CPUs, then these hctx shouldn't have been run at all.

But hctx->next_cpu can be set as 512 for these inactive hctx in
blk_mq_map_swqueue(), then please test the attached patch, and if
hctx->next_cpu is still set as 512, something is still wrong.

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
index 90838e998f66..1a834d96a718 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1343,6 +1343,13 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	hctx_unlock(hctx, srcu_idx);
 }
 
+static void check_next_cpu(int next_cpu, const char *str1, const char *str2)
+{
+	if (next_cpu > nr_cpu_ids)
+		printk_ratelimited("wrong next_cpu %d, %s, %s\n",
+				next_cpu, str1, str2);
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -1352,26 +1359,29 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
 	bool tried = false;
+	int next_cpu = hctx->next_cpu;
 
 	if (hctx->queue->nr_hw_queues == 1)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
-		int next_cpu;
 select_cpu:
-		next_cpu = cpumask_next_and(hctx->next_cpu, hctx->cpumask,
+		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
 				cpu_online_mask);
-		if (next_cpu >= nr_cpu_ids)
+		check_next_cpu(next_cpu, __func__, "next_and");
+		if (next_cpu >= nr_cpu_ids) {
 			next_cpu = cpumask_first_and(hctx->cpumask,cpu_online_mask);
+			check_next_cpu(next_cpu, __func__, "first_and");
+		}
 
 		/*
 		 * No online CPU is found, so have to make sure hctx->next_cpu
 		 * is set correctly for not breaking workqueue.
 		 */
-		if (next_cpu >= nr_cpu_ids)
-			hctx->next_cpu = cpumask_first(hctx->cpumask);
-		else
-			hctx->next_cpu = next_cpu;
+		if (next_cpu >= nr_cpu_ids) {
+			next_cpu = cpumask_first(hctx->cpumask);
+			check_next_cpu(next_cpu, __func__, "first");
+		}
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 
@@ -1379,7 +1389,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	 * Do unbound schedule if we can't find a online CPU for this hctx,
 	 * and it should only happen in the path of handling CPU DEAD.
 	 */
-	if (!cpu_online(hctx->next_cpu)) {
+	if (!cpu_online(next_cpu)) {
 		if (!tried) {
 			tried = true;
 			goto select_cpu;
@@ -1392,7 +1402,9 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 		hctx->next_cpu_batch = 1;
 		return WORK_CPU_UNBOUND;
 	}
-	return hctx->next_cpu;
+
+	hctx->next_cpu = next_cpu;
+	return next_cpu;
 }
 
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
@@ -2408,6 +2420,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
+		int next_cpu;
+
 		/*
 		 * If no software queues are mapped to this hardware queue,
 		 * disable it and free the request entries.
@@ -2437,8 +2451,12 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		/*
 		 * Initialize batch roundrobin counts
 		 */
-		hctx->next_cpu = cpumask_first_and(hctx->cpumask,
+		next_cpu = cpumask_first_and(hctx->cpumask,
 				cpu_online_mask);
+		if (next_cpu >= nr_cpu_ids)
+			next_cpu = cpumask_first(hctx->cpumask);
+		check_next_cpu(next_cpu, __func__, "first_and");
+		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 }
Thanks,
Ming
