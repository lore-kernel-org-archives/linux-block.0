Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 1/2] blk-mq: init hctx sched after update cpu &
 nr_hw_queues mapping
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVO+NoU2YcuhchYOzAbxu9CfY7VCE5moRrH47kWmX_JD7A@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3c8077f8-9793-3992-29f4-0cdbc7aafffc@oracle.com>
Date: Thu, 16 Aug 2018 17:52:06 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVO+NoU2YcuhchYOzAbxu9CfY7VCE5moRrH47kWmX_JD7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


On 08/15/2018 07:32 PM, Ming Lei wrote:
> On Wed, Aug 15, 2018 at 3:25 PM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> Kyber depends on the mapping between cpu and nr_hw_queues. When
>> update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
>> invoked before the mapping is adapted correctly, this would cause
>> terrible result. A simply way to fix this is switch the io scheduler
>> to none before update the nr_hw_queues, and then get it back after
>> update nr_hw_queues. To achieve this, we add a new member elv_type
>> in request_queue to save the original elevator and adapt and export
>> elevator_switch_mq.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>  block/blk-mq.c         | 37 +++++++++++++++++++++++++++++--------
>>  block/blk.h            |  2 ++
>>  block/elevator.c       | 20 ++++++++++++--------
>>  include/linux/blkdev.h |  3 +++
>>  4 files changed, 46 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 5efd789..89904cc 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -112,6 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
>>         struct mq_inflight mi = { .part = part, .inflight = inflight, };
>>
>>         inflight[0] = inflight[1] = 0;
>> +
> 
> Not necessary to do that.

Yes, I will discard this.

> 
>>         blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
>>  }
>>
>> @@ -2147,8 +2148,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>>         if (set->ops->exit_request)
>>                 set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
>>
>> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
>> -
>>         if (set->ops->exit_hctx)
>>                 set->ops->exit_hctx(hctx, hctx_idx);
>>
>> @@ -2216,12 +2215,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>             set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
>>                 goto free_bitmap;
>>
>> -       if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
>> -               goto exit_hctx;
>> -
>>         hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
>>         if (!hctx->fq)
>> -               goto sched_exit_hctx;
>> +               goto exit_hctx;
>>
>>         if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
>>                 goto free_fq;
>> @@ -2235,8 +2231,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
>>
>>   free_fq:
>>         kfree(hctx->fq);
>> - sched_exit_hctx:
>> -       blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
> 
> Seems both blk_mq_sched_init_hctx() and blk_mq_sched_exit_hctx() may be
> removed now.

Yes, I will remove them in V2.

Thanks
Jianchao
