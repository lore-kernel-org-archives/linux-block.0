Return-Path: <axboe@kernel.dk>
Subject: Re: for-4.12/block branch
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
 <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
 <1492792278.2550.5.camel@sandisk.com>
 <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
 <1492792852.2550.7.camel@sandisk.com>
 <5e5870a4-bbff-8486-f28c-49127a9c60a5@fb.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fae5b2be-b18e-cb1c-675e-79869f678c7e@kernel.dk>
Date: Fri, 21 Apr 2017 10:56:28 -0600
MIME-Version: 1.0
In-Reply-To: <5e5870a4-bbff-8486-f28c-49127a9c60a5@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 10:48 AM, Jens Axboe wrote:
> On 04/21/2017 10:40 AM, Bart Van Assche wrote:
>> On Fri, 2017-04-21 at 10:33 -0600, Jens Axboe wrote:
>>> On 04/21/2017 10:31 AM, Bart Van Assche wrote:
>>>> On Fri, 2017-04-21 at 10:25 -0600, Jens Axboe wrote:
>>>>> On 04/21/2017 09:32 AM, Bart Van Assche wrote:
>>>>>> Hello Jens,
>>>>>>
>>>>>> Since yesterday the following complaint is reported frequently after having
>>>>>> installed the for-4.12/block branch on my test setup. Unless someone has a
>>>>>> better proposal, I will run a bisect.
>>>>>>
>>>>>> BUG: sleeping function called from invalid context at ./include/linux/buffer_head.h:349
>>>>>> in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
>>>>>> CPU: 10 PID: 8019 Comm: find Tainted: G        W I     4.11.0-rc4-dbg+ #2
>>>>>> Call Trace:
>>>>>>  dump_stack+0x68/0x93
>>>>>>  ___might_sleep+0x16e/0x230
>>>>>>  __might_sleep+0x4a/0x80
>>>>>>  __ext4_get_inode_loc+0x1e0/0x4e0
>>>>>>  ext4_iget+0x70/0xbc0
>>>>>>  ext4_iget_normal+0x2f/0x40
>>>>>>  ext4_lookup+0xb6/0x1f0
>>>>>>  lookup_slow+0x104/0x1e0
>>>>>>  walk_component+0x19a/0x330
>>>>>>  path_lookupat+0x4b/0x100
>>>>>>  filename_lookup+0x9a/0x110
>>>>>>  user_path_at_empty+0x36/0x40
>>>>>>  vfs_statx+0x67/0xc0
>>>>>>  SYSC_newfstatat+0x20/0x40
>>>>>>  SyS_newfstatat+0xe/0x10
>>>>>>  entry_SYSCALL_64_fastpath+0x18/0xad
>>>>>
>>>>> How are you reproducing this? I've been running testing on the test box
>>>>> and I run it on my laptop as well, but I haven't seen anything odd.
>>>>
>>>> Hello Jens,
>>>>
>>>> All I have to do to reproduce this is to build, install and boot the kernel.
>>>> Maybe we are using a different kernel config?
>>>
>>> I'd say odds are good we are not using an identical kernel config :-)
>>> What is your root device? Is it using mq and scheduling, or what's
>>> the config?
>>
>> Hello Jens,
>>
>> The boot device is a SATA disk:
>> # lsscsi
>> [0:0:0:0]    disk    ATA      ST1000NM0033-9ZM GA67  /dev/sda 
>>
>> SCSI-mq is enabled and the default I/O scheduler is the deadline scheduler.
>> From the kernel .config:
>> CONFIG_DEFAULT_IOSCHED="deadline"
>> CONFIG_SCSI_MQ_DEFAULT=y
> 
> I wonder if it's an imbalance in the preempt count. Looking at it, it
> looks like we're not clearing the alloc data. But I would think that
> would potentially cause much worse problems, but maybe we got lucky?
> 
> Let me generate a cleanup patch for that.

Something like the below.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0b2f60407748..519e5a08c0c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -279,7 +279,7 @@ EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags };
+	struct blk_mq_alloc_data alloc_data;
 	struct request *rq;
 	int ret;
 
@@ -287,6 +287,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
+	blk_mq_init_alloc_data(&alloc_data, flags);
 	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
 
 	blk_mq_put_ctx(alloc_data.ctx);
@@ -305,7 +306,7 @@ EXPORT_SYMBOL(blk_mq_alloc_request);
 struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 		unsigned int flags, unsigned int hctx_idx)
 {
-	struct blk_mq_alloc_data alloc_data = { .flags = flags };
+	struct blk_mq_alloc_data alloc_data;
 	struct request *rq;
 	unsigned int cpu;
 	int ret;
@@ -326,6 +327,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
+	blk_mq_init_alloc_data(&alloc_data, flags);
+
 	/*
 	 * Check if the hardware context is actually mapped to anything.
 	 * If not tell the caller that it should skip this queue.
@@ -1531,7 +1534,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = { .flags = 0 };
+	struct blk_mq_alloc_data data;
 	struct request *rq;
 	unsigned int request_count = 0;
 	struct blk_plug *plug;
@@ -1559,6 +1562,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	trace_block_getrq(q, bio, bio->bi_opf);
 
+	blk_mq_init_alloc_data(&data, 0);
 	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 524f44742816..36cfc21c7cc6 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -148,6 +148,16 @@ struct blk_mq_alloc_data {
 	struct blk_mq_hw_ctx *hctx;
 };
 
+static inline void blk_mq_init_alloc_data(struct blk_mq_alloc_data *data,
+					  unsigned int flags)
+{
+	data->q = NULL;
+	data->flags = flags;
+	data->shallow_depth = 0;
+	data->ctx = NULL;
+	data->hctx = NULL;
+}
+
 static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data *data)
 {
 	if (data->flags & BLK_MQ_REQ_INTERNAL)

-- 
Jens Axboe
