Return-Path: <axboe@kernel.dk>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
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
 <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ae02b9c5-9a2e-cb8b-7828-475b3c0b1cb9@kernel.dk>
Date: Tue, 21 Nov 2017 12:30:31 -0700
MIME-Version: 1.0
In-Reply-To: <ba994ec6-8db6-f77e-ac73-92e3f6b0135a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/21/2017 12:15 PM, Christian Borntraeger wrote:
> 
> 
> On 11/21/2017 07:39 PM, Jens Axboe wrote:
>> On 11/21/2017 11:27 AM, Jens Axboe wrote:
>>> On 11/21/2017 11:12 AM, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 11/21/2017 07:09 PM, Jens Axboe wrote:
>>>>> On 11/21/2017 10:27 AM, Jens Axboe wrote:
>>>>>> On 11/21/2017 03:14 AM, Christian Borntraeger wrote:
>>>>>>> Bisect points to
>>>>>>>
>>>>>>> 1b5a7455d345b223d3a4658a9e5fce985b7998c1 is the first bad commit
>>>>>>> commit 1b5a7455d345b223d3a4658a9e5fce985b7998c1
>>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>>> Date:   Mon Jun 26 12:20:57 2017 +0200
>>>>>>>
>>>>>>>     blk-mq: Create hctx for each present CPU
>>>>>>>     
>>>>>>>     commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
>>>>>>>     
>>>>>>>     Currently we only create hctx for online CPUs, which can lead to a lot
>>>>>>>     of churn due to frequent soft offline / online operations.  Instead
>>>>>>>     allocate one for each present CPU to avoid this and dramatically simplify
>>>>>>>     the code.
>>>>>>>     
>>>>>>>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>>>     Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>     Cc: Keith Busch <keith.busch@intel.com>
>>>>>>>     Cc: linux-block@vger.kernel.org
>>>>>>>     Cc: linux-nvme@lists.infradead.org
>>>>>>>     Link: http://lkml.kernel.org/r/20170626102058.10200-3-hch@lst.de
>>>>>>>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>     Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
>>>>>>>     Cc: Mike Galbraith <efault@gmx.de>
>>>>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>
>>>>>> I wonder if we're simply not getting the masks updated correctly. I'll
>>>>>> take a look.
>>>>>
>>>>> Can't make it trigger here. We do init for each present CPU, which means
>>>>> that if I offline a few CPUs here and register a queue, those still show
>>>>> up as present (just offline) and get mapped accordingly.
>>>>>
>>>>> From the looks of it, your setup is different. If the CPU doesn't show
>>>>> up as present and it gets hotplugged, then I can see how this condition
>>>>> would trigger. What environment are you running this in? We might have
>>>>> to re-introduce the cpu hotplug notifier, right now we just monitor
>>>>> for a dead cpu and handle that.
>>>>
>>>> I am not doing a hot unplug and the replug, I use KVM and add a previously
>>>> not available CPU.
>>>>
>>>> in libvirt/virsh speak:
>>>>   <vcpu placement='static' current='1'>4</vcpu>
>>>
>>> So that's why we run into problems. It's not present when we load the device,
>>> but becomes present and online afterwards.
>>>
>>> Christoph, we used to handle this just fine, your patch broke it.
>>>
>>> I'll see if I can come up with an appropriate fix.
>>
>> Can you try the below?
> 
> 
> It does prevent the crash but it seems that the new CPU is not "used " after the hotplug for mq:
> 
> 
> output with 2 cpus:
> /sys/kernel/debug/block/vda
> /sys/kernel/debug/block/vda/hctx0
> /sys/kernel/debug/block/vda/hctx0/cpu0
> /sys/kernel/debug/block/vda/hctx0/cpu0/completed
> /sys/kernel/debug/block/vda/hctx0/cpu0/merged
> /sys/kernel/debug/block/vda/hctx0/cpu0/dispatched
> /sys/kernel/debug/block/vda/hctx0/cpu0/rq_list
> /sys/kernel/debug/block/vda/hctx0/active
> /sys/kernel/debug/block/vda/hctx0/run
> /sys/kernel/debug/block/vda/hctx0/queued
> /sys/kernel/debug/block/vda/hctx0/dispatched
> /sys/kernel/debug/block/vda/hctx0/io_poll
> /sys/kernel/debug/block/vda/hctx0/sched_tags_bitmap
> /sys/kernel/debug/block/vda/hctx0/sched_tags
> /sys/kernel/debug/block/vda/hctx0/tags_bitmap
> /sys/kernel/debug/block/vda/hctx0/tags
> /sys/kernel/debug/block/vda/hctx0/ctx_map
> /sys/kernel/debug/block/vda/hctx0/busy
> /sys/kernel/debug/block/vda/hctx0/dispatch
> /sys/kernel/debug/block/vda/hctx0/flags
> /sys/kernel/debug/block/vda/hctx0/state
> /sys/kernel/debug/block/vda/sched
> /sys/kernel/debug/block/vda/sched/dispatch
> /sys/kernel/debug/block/vda/sched/starved
> /sys/kernel/debug/block/vda/sched/batching
> /sys/kernel/debug/block/vda/sched/write_next_rq
> /sys/kernel/debug/block/vda/sched/write_fifo_list
> /sys/kernel/debug/block/vda/sched/read_next_rq
> /sys/kernel/debug/block/vda/sched/read_fifo_list
> /sys/kernel/debug/block/vda/write_hints
> /sys/kernel/debug/block/vda/state
> /sys/kernel/debug/block/vda/requeue_list
> /sys/kernel/debug/block/vda/poll_stat

Try this, basically just a revert.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11097477eeab..bc1950fa9ef6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -37,6 +37,9 @@
 #include "blk-wbt.h"
 #include "blk-mq-sched.h"
 
+static DEFINE_MUTEX(all_q_mutex);
+static LIST_HEAD(all_q_list);
+
 static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
@@ -2114,8 +2117,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
 
-		/* If the cpu isn't present, the cpu is mapped to first hctx */
-		if (!cpu_present(i))
+		/* If the cpu isn't online, the cpu is mapped to first hctx */
+		if (!cpu_online(i))
 			continue;
 
 		hctx = blk_mq_map_queue(q, i);
@@ -2158,7 +2161,8 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 	}
 }
 
-static void blk_mq_map_swqueue(struct request_queue *q)
+static void blk_mq_map_swqueue(struct request_queue *q,
+			       const struct cpumask *online_mask)
 {
 	unsigned int i, hctx_idx;
 	struct blk_mq_hw_ctx *hctx;
@@ -2176,11 +2180,13 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	}
 
 	/*
-	 * Map software to hardware queues.
-	 *
-	 * If the cpu isn't present, the cpu is mapped to first hctx.
+	 * Map software to hardware queues
 	 */
-	for_each_present_cpu(i) {
+	for_each_possible_cpu(i) {
+		/* If the cpu isn't online, the cpu is mapped to first hctx */
+		if (!cpumask_test_cpu(i, online_mask))
+			continue;
+
 		hctx_idx = q->mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
@@ -2495,8 +2501,16 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		blk_queue_softirq_done(q, set->ops->complete);
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
+
+	get_online_cpus();
+	mutex_lock(&all_q_mutex);
+
+	list_add_tail(&q->all_q_node, &all_q_list);
 	blk_mq_add_queue_tag_set(set, q);
-	blk_mq_map_swqueue(q);
+	blk_mq_map_swqueue(q, cpu_online_mask);
+
+	mutex_unlock(&all_q_mutex);
+	put_online_cpus();
 
 	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
 		int ret;
@@ -2522,12 +2536,18 @@ void blk_mq_free_queue(struct request_queue *q)
 {
 	struct blk_mq_tag_set	*set = q->tag_set;
 
+	mutex_lock(&all_q_mutex);
+	list_del_init(&q->all_q_node);
+	mutex_unlock(&all_q_mutex);
+
 	blk_mq_del_queue_tag_set(q);
+
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
 /* Basically redo blk_mq_init_queue with queue frozen */
-static void blk_mq_queue_reinit(struct request_queue *q)
+static void blk_mq_queue_reinit(struct request_queue *q,
+				const struct cpumask *online_mask)
 {
 	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
 
@@ -2539,12 +2559,76 @@ static void blk_mq_queue_reinit(struct request_queue *q)
 	 * we should change hctx numa_node according to the new topology (this
 	 * involves freeing and re-allocating memory, worth doing?)
 	 */
-	blk_mq_map_swqueue(q);
+	blk_mq_map_swqueue(q, online_mask);
 
 	blk_mq_sysfs_register(q);
 	blk_mq_debugfs_register_hctxs(q);
 }
 
+/*
+ * New online cpumask which is going to be set in this hotplug event.
+ * Declare this cpumasks as global as cpu-hotplug operation is invoked
+ * one-by-one and dynamically allocating this could result in a failure.
+ */
+static struct cpumask cpuhp_online_new;
+
+static void blk_mq_queue_reinit_work(void)
+{
+	struct request_queue *q;
+
+	mutex_lock(&all_q_mutex);
+	/*
+	 * We need to freeze and reinit all existing queues.  Freezing
+	 * involves synchronous wait for an RCU grace period and doing it
+	 * one by one may take a long time.  Start freezing all queues in
+	 * one swoop and then wait for the completions so that freezing can
+	 * take place in parallel.
+	 */
+	list_for_each_entry(q, &all_q_list, all_q_node)
+		blk_freeze_queue_start(q);
+	list_for_each_entry(q, &all_q_list, all_q_node)
+		blk_mq_freeze_queue_wait(q);
+
+	list_for_each_entry(q, &all_q_list, all_q_node)
+		blk_mq_queue_reinit(q, &cpuhp_online_new);
+
+	list_for_each_entry(q, &all_q_list, all_q_node)
+		blk_mq_unfreeze_queue(q);
+
+	mutex_unlock(&all_q_mutex);
+}
+
+static int blk_mq_queue_reinit_dead(unsigned int cpu)
+{
+	cpumask_copy(&cpuhp_online_new, cpu_online_mask);
+	blk_mq_queue_reinit_work();
+	return 0;
+}
+
+/*
+ * Before hotadded cpu starts handling requests, new mappings must be
+ * established.  Otherwise, these requests in hw queue might never be
+ * dispatched.
+ *
+ * For example, there is a single hw queue (hctx) and two CPU queues (ctx0
+ * for CPU0, and ctx1 for CPU1).
+ *
+ * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
+ * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
+ *
+ * And then while running hw queue, blk_mq_flush_busy_ctxs() finds bit0 is set
+ * in pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
+ * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list is
+ * ignored.
+ */
+static int blk_mq_queue_reinit_prepare(unsigned int cpu)
+{
+	cpumask_copy(&cpuhp_online_new, cpu_online_mask);
+	cpumask_set_cpu(cpu, &cpuhp_online_new);
+	blk_mq_queue_reinit_work();
+	return 0;
+}
+
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
@@ -2757,7 +2841,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
-		blk_mq_queue_reinit(q);
+		blk_mq_queue_reinit(q, cpu_online_mask);
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
@@ -2966,6 +3050,16 @@ static bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 	return __blk_mq_poll(hctx, rq);
 }
 
+void blk_mq_disable_hotplug(void)
+{
+	mutex_lock(&all_q_mutex);
+}
+
+void blk_mq_enable_hotplug(void)
+{
+	mutex_unlock(&all_q_mutex);
+}
+
 static int __init blk_mq_init(void)
 {
 	/*
@@ -2976,6 +3070,10 @@ static int __init blk_mq_init(void)
 
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
+
+	cpuhp_setup_state_nocalls(CPUHP_BLK_MQ_PREPARE, "block/mq:prepare",
+				  blk_mq_queue_reinit_prepare,
+				  blk_mq_queue_reinit_dead);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6c7c3ff5bf62..83b13ef1915e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -59,6 +59,11 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
+/*
+ * CPU hotplug helpers
+ */
+void blk_mq_enable_hotplug(void);
+void blk_mq_disable_hotplug(void);
 
 /*
  * CPU -> queue mappings
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 201ab7267986..c31d4e3bf6d0 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -76,6 +76,7 @@ enum cpuhp_state {
 	CPUHP_XEN_EVTCHN_PREPARE,
 	CPUHP_ARM_SHMOBILE_SCU_PREPARE,
 	CPUHP_SH_SH3X_PREPARE,
+	CPUHP_BLK_MQ_PREPARE,
 	CPUHP_NET_FLOW_PREPARE,
 	CPUHP_TOPOLOGY_PREPARE,
 	CPUHP_NET_IUCV_PREPARE,

-- 
Jens Axboe
