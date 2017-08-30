Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq: add requests in the tail of hctx->dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20170830151935.24253-1-ming.lei@redhat.com>
 <20170830151935.24253-3-ming.lei@redhat.com>
 <567ad683-d577-1817-cf96-eff5aaf47db6@kernel.dk>
 <20170830153929.GB14684@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b2058354-f466-b1d4-1a55-6233ddd0f3ac@kernel.dk>
Date: Wed, 30 Aug 2017 09:51:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170830153929.GB14684@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/30/2017 09:39 AM, Ming Lei wrote:
> On Wed, Aug 30, 2017 at 09:22:42AM -0600, Jens Axboe wrote:
>> On 08/30/2017 09:19 AM, Ming Lei wrote:
>>> It is more reasonable to add requests to ->dispatch in way
>>> of FIFO style, instead of LIFO style.
>>>
>>> Also in this way, we can allow to insert request at the front
>>> of hw queue, which function is needed to fix one bug
>>> in blk-mq's implementation of blk_execute_rq()
>>>
>>> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>>> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq-sched.c | 2 +-
>>>  block/blk-mq.c       | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>> index 4ab69435708c..8d97df40fc28 100644
>>> --- a/block/blk-mq-sched.c
>>> +++ b/block/blk-mq-sched.c
>>> @@ -272,7 +272,7 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
>>>  	 * the dispatch list.
>>>  	 */
>>>  	spin_lock(&hctx->lock);
>>> -	list_add(&rq->queuelist, &hctx->dispatch);
>>> +	list_add_tail(&rq->queuelist, &hctx->dispatch);
>>>  	spin_unlock(&hctx->lock);
>>>  	return true;
>>>  }
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 4603b115e234..fed3d0c16266 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1067,7 +1067,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
>>>  		blk_mq_put_driver_tag(rq);
>>>  
>>>  		spin_lock(&hctx->lock);
>>> -		list_splice_init(list, &hctx->dispatch);
>>> +		list_splice_tail_init(list, &hctx->dispatch);
>>>  		spin_unlock(&hctx->lock);
>>
>> I'm not convinced this is safe, there's actually a reason why the
>> request is added to the front and not the back. We do have
>> reorder_tags_to_front() as a safe guard, but I'd much rather get rid of
> 
> reorder_tags_to_front() is for reordering the requests in current list,
> this patch is for splicing list into hctx->dispatch, so I can't see
> it isn't safe, or could you explain it a bit?

If we can get the ordering right, then down the line we won't need to
have the tags reordering at all. It's an ugly hack that I'd love to see
go away.

>> that than make this change.
>>
>> What's your reasoning here? Your changelog doesn't really explain why
> 
> Firstly the 2nd patch need to add one rq(such as RQF_PM) to the
> front of the hw queue, the simple way is to add it to the front
> of hctx->dispatch. Without this change, the 2nd patch can't work
> at all.
> 
> Secondly this way is still reasonable:
> 
> 	- one rq is added to hctx->dispatch because queue is busy
> 	- another rq is added to hctx->dispatch too because of same reason
>
> so it is reasonable to to add list into hctx->dispatch in FIFO style.

Not disagreeing with the logic. But it also begs the question of why we
don't apply the same treatment to when we splice leftovers to the
dispatch list, currently we front splice that.

All I'm saying is that you need to tread very carefully with this, and
throw it through some careful testing to ensure that we don't introduce
conditions that now livelock. NVMe is the easy test case, that will
generally always work since we never run out of tags. The problematic
test case is usually things like SATA with 31 tags, and especially SATA
with flushes that don't queue. One good test case is the one where you
end up having all tags (or almost all) consumed by flushes, and still
ensuring that we're making forward progress.

-- 
Jens Axboe
