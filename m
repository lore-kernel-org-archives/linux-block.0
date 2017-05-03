Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
To: Ming Lei <ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
 <20170503150351.GA7927@ming.t460p>
 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
 <20170503170315.GD9706@ming.t460p>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Omar Sandoval <osandov@fb.com>, Bart Van Assche <Bart.VanAssche@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <24ff7ca6-73d6-f8a5-b7d9-e92d0bfdb4b0@kernel.dk>
Date: Wed, 3 May 2017 11:07:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170503170315.GD9706@ming.t460p>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/03/2017 11:03 AM, Ming Lei wrote:
> On Thu, May 04, 2017 at 12:52:06AM +0800, Ming Lei wrote:
>> On Wed, May 03, 2017 at 11:38:09PM +0800, Ming Lei wrote:
>>> On Wed, May 03, 2017 at 09:08:34AM -0600, Jens Axboe wrote:
>>>> On 05/03/2017 09:03 AM, Ming Lei wrote:
>>>>> On Wed, May 03, 2017 at 08:10:58AM -0600, Jens Axboe wrote:
>>>>>> On 05/03/2017 08:08 AM, Jens Axboe wrote:
>>>>>>> On 05/02/2017 10:03 PM, Ming Lei wrote:
>>>>>>>> On Fri, Apr 28, 2017 at 02:29:18PM -0600, Jens Axboe wrote:
>>>>>>>>> On 04/28/2017 09:15 AM, Ming Lei wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> This patchset introduces flag of BLK_MQ_F_SCHED_USE_HW_TAG and
>>>>>>>>>> allows to use hardware tag directly for IO scheduling if the queue's
>>>>>>>>>> depth is big enough. In this way, we can avoid to allocate extra tags
>>>>>>>>>> and request pool for IO schedule, and the schedule tag allocation/release
>>>>>>>>>> can be saved in I/O submit path.
>>>>>>>>>
>>>>>>>>> Ming, I like this approach, it's pretty clean. It'd be nice to have a
>>>>>>>>> bit of performance data to back up that it's useful to add this code,
>>>>>>>>> though.  Have you run anything on eg kyber on nvme that shows a
>>>>>>>>> reduction in overhead when getting rid of separate scheduler tags?
>>>>>>>>
>>>>>>>> I can observe small improvement in the following tests:
>>>>>>>>
>>>>>>>> 1) fio script
>>>>>>>> # io scheduler: kyber
>>>>>>>>
>>>>>>>> RWS="randread read randwrite write"
>>>>>>>> for RW in $RWS; do
>>>>>>>>         echo "Running test $RW"
>>>>>>>>         sudo echo 3 > /proc/sys/vm/drop_caches
>>>>>>>>         sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=20 --numjobs=1 --ioengine=libaio --iodepth=10240 --group_reporting=1 --filename=$DISK --name=$DISK-test-$RW --rw=$RW --output-format=json
>>>>>>>> done
>>>>>>>>
>>>>>>>> 2) results
>>>>>>>>
>>>>>>>> ---------------------------------------------------------
>>>>>>>> 			|sched tag(iops/lat)	| use hw tag to sched(iops/lat)
>>>>>>>> ----------------------------------------------------------
>>>>>>>> randread	|188940/54107			| 193865/52734
>>>>>>>> ----------------------------------------------------------
>>>>>>>> read		|192646/53069			| 199738/51188
>>>>>>>> ----------------------------------------------------------
>>>>>>>> randwrite	|171048/59777			| 179038/57112
>>>>>>>> ----------------------------------------------------------
>>>>>>>> write		|171886/59492			| 181029/56491
>>>>>>>> ----------------------------------------------------------
>>>>>>>>
>>>>>>>> I guess it may be a bit more obvious when running the test on one slow
>>>>>>>> NVMe device, and will try to find one and run the test again.
>>>>>>>
>>>>>>> Thanks for running that. As I said in my original reply, I think this
>>>>>>> is a good optimization, and the implementation is clean. I'm fine with
>>>>>>> the current limitations of when to enable it, and it's not like we
>>>>>>> can't extend this later, if we want.
>>>>>>>
>>>>>>> I do agree with Bart that patch 1+4 should be combined. I'll do that.
>>>>>>
>>>>>> Actually, can you do that when reposting? Looks like you needed to
>>>>>> do that anyway.
>>>>>
>>>>> Yeah, I will do that in V1.
>>>>
>>>> V2? :-)
>>>>
>>>> Sounds good. I just wanted to check the numbers here, with the series
>>>> applied on top of for-linus crashes when switching to kyber. A few hunks
>>>
>>> Yeah, I saw that too, it has been fixed in my local tree, :-)
>>>
>>>> threw fuzz, but it looked fine to me. But I bet I fat fingered
>>>> something.  So it'd be great if you could respin against my for-linus
>>>> branch.
>>>
>>> Actually, that is exactly what I am doing, :-)
>>
>> Looks v4.11 plus your for-linus often triggers the following hang during
>> boot, and it seems caused by the change in (blk-mq: unify hctx delayed_run_work
>> and run_work)
>>
>>
>> UG: scheduling while atomic: kworker/0:1H/704/0x00000002
>> Modules linked in:
>> Preemption disabled at:
>> [<ffffffffaf5607bb>] virtio_queue_rq+0xdb/0x350
>> CPU: 0 PID: 704 Comm: kworker/0:1H Not tainted 4.11.0-04508-ga1f35f46164b #132
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.9.3-1.fc25 04/01/2014
>> Workqueue: kblockd blk_mq_run_work_fn
>> Call Trace:
>>  dump_stack+0x65/0x8f
>>  ? virtio_queue_rq+0xdb/0x350
>>  __schedule_bug+0x76/0xc0
>>  __schedule+0x610/0x820
>>  ? new_slab+0x2c9/0x590
>>  schedule+0x40/0x90
>>  schedule_timeout+0x273/0x320
>>  ? ___slab_alloc+0x3cb/0x4f0
>>  wait_for_completion+0x97/0x100
>>  ? wait_for_completion+0x97/0x100
>>  ? wake_up_q+0x80/0x80
>>  flush_work+0x104/0x1a0
>>  ? flush_workqueue_prep_pwqs+0x130/0x130
>>  __cancel_work_timer+0xeb/0x160
>>  ? vp_notify+0x16/0x20
>>  ? virtqueue_add_sgs+0x23c/0x4a0
>>  cancel_delayed_work_sync+0x13/0x20
>>  blk_mq_stop_hw_queue+0x16/0x20
>>  virtio_queue_rq+0x316/0x350
>>  blk_mq_dispatch_rq_list+0x194/0x350
>>  blk_mq_sched_dispatch_requests+0x118/0x170
>>  ? finish_task_switch+0x80/0x1e0
>>  __blk_mq_run_hw_queue+0xa3/0xc0
>>  blk_mq_run_work_fn+0x2c/0x30
>>  process_one_work+0x1e0/0x400
>>  worker_thread+0x48/0x3f0
>>  kthread+0x109/0x140
>>  ? process_one_work+0x400/0x400
>>  ? kthread_create_on_node+0x40/0x40
>>  ret_from_fork+0x2c/0x40
> 
> Looks we can't call cancel_delayed_work_sync() here.
> 
> Last time, I asked why the _sync is required, looks not
> get anwser, or I might forget that.
> 
> Bart, could you explain it a bit why the _sync version of
> cancel work is required?

Yeah, that patch was buggy, we definitely can't use the sync variants
from a drivers ->queue_rq(). How about something like the below? For
the important internal callers, we should be able to pass _sync just
fine.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bf90684a007a..1e230a864129 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -41,6 +41,7 @@ static LIST_HEAD(all_q_list);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
+static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync);
 
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
@@ -166,7 +167,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_stop_hw_queues(q);
+	__blk_mq_stop_hw_queues(q, true);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
@@ -1218,20 +1219,34 @@ bool blk_mq_queue_stopped(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_queue_stopped);
 
-void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 {
-	cancel_delayed_work_sync(&hctx->run_work);
+	if (sync)
+		cancel_delayed_work_sync(&hctx->run_work);
+	else
+		cancel_delayed_work(&hctx->run_work);
+
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
+
+void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_stop_hw_queue(hctx, false);
+}
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
-void blk_mq_stop_hw_queues(struct request_queue *q)
+void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_stop_hw_queue(hctx);
+		__blk_mq_stop_hw_queue(hctx, sync);
+}
+
+void blk_mq_stop_hw_queues(struct request_queue *q)
+{
+	__blk_mq_stop_hw_queues(q, false);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queues);
 

-- 
Jens Axboe
