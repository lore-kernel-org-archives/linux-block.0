Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
 <20170503150351.GA7927@ming.t460p>
 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
 <1493831309.3901.17.camel@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8fae4386-bb9a-ee42-2e7e-174080bb63bb@kernel.dk>
Date: Wed, 3 May 2017 11:11:46 -0600
MIME-Version: 1.0
In-Reply-To: <1493831309.3901.17.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/03/2017 11:08 AM, Bart Van Assche wrote:
> On Thu, 2017-05-04 at 00:52 +0800, Ming Lei wrote:
>> Looks v4.11 plus your for-linus often triggers the following hang during
>> boot, and it seems caused by the change in (blk-mq: unify hctx delayed_run_work
>> and run_work)
>>
>>
>> BUG: scheduling while atomic: kworker/0:1H/704/0x00000002
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
> Callers of blk_mq_quiesce_queue() really need blk_mq_stop_hw_queue() to
> cancel delayed work synchronously.

Right.

> The above call stack shows that we have to do something about the
> blk_mq_stop_hw_queue() calls from inside .queue_rq() functions for
> queues for which BLK_MQ_F_BLOCKING has not been set. I'm not sure what
> the best approach would be: setting BLK_MQ_F_BLOCKING for queues that
> call blk_mq_stop_hw_queue() from inside .queue_rq() or creating two
> versions of blk_mq_stop_hw_queue().

Regardless of whether BLOCKING is set or not, we don't have to hard
guarantee the flush from the drivers. If they do happen to get a 2nd
invocation before being stopped, that doesn't matter. So I think we're
fine with the patch I sent out 5 minutes ago, would be great if Ming
could test it though.

-- 
Jens Axboe
