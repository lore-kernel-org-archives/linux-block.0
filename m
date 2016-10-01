Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com> <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
 <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 2 Oct 2016 06:56:19 +0800
Message-ID: <CACVXFVMY19vuDjsECg2uX0_y_K7DUaaGqXPX9PYiBy5sfXmAEw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and blk_resume_queue()
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 30, 2016 at 11:55 PM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 09/29/16 14:51, Ming Lei wrote:
>>
>> On Thu, Sep 29, 2016 at 7:59 AM, Bart Van Assche
>> <bart.vanassche@sandisk.com> wrote:
>>>
>>> blk_quiesce_queue() prevents that new queue_rq() invocations
>>
>>
>> blk_mq_quiesce_queue()
>
>
> Thanks, I will update the patch title and patch description.
>
>>> +void blk_mq_quiesce_queue(struct request_queue *q)
>>> +{
>>> +       struct blk_mq_hw_ctx *hctx;
>>> +       unsigned int i;
>>> +       bool res, rcu = false;
>>> +
>>> +       spin_lock_irq(q->queue_lock);
>>> +       WARN_ON_ONCE(blk_queue_quiescing(q));
>>> +       queue_flag_set(QUEUE_FLAG_QUIESCING, q);
>>> +       spin_unlock_irq(q->queue_lock);
>>> +
>>> +       res = __blk_mq_freeze_queue_start(q, false);
>>
>>
>> Looks the implementation is a bit tricky and complicated, if the percpu
>> usage counter isn't killed, it isn't necessary to touch .mq_freeze_depth
>> since you use QUEUE_FLAG_QUIESCING to set/get this status of
>> the queue.
>
>>
>> Then using synchronize_rcu() and rcu_read_lock()/rcu_read_unlock()
>> with the flag of QUIESCING may be enough to wait for completing
>> of ongoing invocations of .queue_rq() and avoid to run new .queue_rq,
>> right?
>
> That's an interesting thought. Can you have a look at the attached patch in
> which blk_mq_quiesce_queue() no longer manipulates the mq_freeze_depth
> counter?

About this part of manipulating 'mq_freeze_depth', your new patch looks
better and cleaner.

>
>>> +       WARN_ON_ONCE(!res);
>>> +       queue_for_each_hw_ctx(q, hctx, i) {
>>> +               if (hctx->flags & BLK_MQ_F_BLOCKING) {
>>> +                       mutex_lock(&hctx->queue_rq_mutex);
>>> +                       mutex_unlock(&hctx->queue_rq_mutex);
>>
>>
>> Could you explain a bit why all BLOCKING is treated so special? And
>> that flag just means the hw queue always need to schedule asynchronously,
>> and of course even though the flag isn't set, it still may be run
>> asynchronously too. So looks it should be enough to just use RCU.
>
>
> The mutex manipulations introduce atomic stores in the hot path. Hence the
> use of synchronize_rcu() and rcu_read_lock()/rcu_read_unlock() when
> possible. Since BLK_MQ_F_BLOCKING indicates that .queue_rq() may sleep and
> since sleeping is not allowed while holding the RCU read lock,
> queue_rq_mutex has been introduced for the BLK_MQ_F_BLOCKING case.

OK, got it.

But this part looks still not good enough:

> +static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> +{
> +       if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
> +               return;
> +
> +       if (hctx->flags & BLK_MQ_F_BLOCKING) {
> +               mutex_lock(&hctx->queue_rq_mutex);
> +               blk_mq_process_rq_list(hctx);
> +               mutex_unlock(&hctx->queue_rq_mutex);

With the new mutex, .queue_rq can't be run concurrently any more, even
though the hw queue can be mapped to more than one CPUs. So maybe
srcu for BLK_MQ_F_BLOCKING?

> +       } else {
> +               rcu_read_lock();
> +               blk_mq_process_rq_list(hctx);
> +               rcu_read_unlock();
>         }

...

> -               if (!blk_mq_direct_issue_request(old_rq, &cookie))
> -                       goto done;
> -               blk_mq_insert_request(old_rq, false, true, true);
> +
> +               if (data.hctx->flags & BLK_MQ_F_BLOCKING) {
> +                       mutex_lock(&data.hctx->queue_rq_mutex);
> +                       if (blk_queue_quiescing(q) ||
> +                           blk_mq_direct_issue_request(old_rq, &cookie) != 0)
> +                               blk_mq_insert_request(old_rq, false, true,
> +                                                     true);
> +                       mutex_unlock(&data.hctx->queue_rq_mutex);
> +               } else {
> +                       rcu_read_lock();
> +                       if (blk_queue_quiescing(q) ||
> +                           blk_mq_direct_issue_request(old_rq, &cookie) != 0)
> +                               blk_mq_insert_request(old_rq, false, true,
> +                                                     true);
> +                       rcu_read_unlock();
> +               }
> +

If we just call the rcu/srcu read lock(or the mutex) around .queue_rq(), the
above code needn't to be duplicated any more.

Thanks,
Ming Lei
