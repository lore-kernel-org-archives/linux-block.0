Subject: Re: [PATCH 1/7] block: use legacy path for flush requests for MQ with
 a scheduler
To: Ming Lei <ming.lei@canonical.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-2-git-send-email-axboe@fb.com>
 <CACVXFVOeEmcNGcw8-==2FEOx5r8D90aqj24op+fNfwLr6uR_aw@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 paolo.valente@linaro.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <799949b0-57be-2062-169b-8bdfba7d5530@fb.com>
Date: Mon, 5 Dec 2016 10:09:23 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVOeEmcNGcw8-==2FEOx5r8D90aqj24op+fNfwLr6uR_aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/05/2016 10:00 AM, Ming Lei wrote:
> On Sat, Dec 3, 2016 at 11:15 AM, Jens Axboe <axboe@fb.com> wrote:
>> No functional changes with this patch, it's just in preparation for
>> supporting legacy schedulers on blk-mq.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>> ---
>>  block/blk-core.c  |  2 +-
>>  block/blk-exec.c  |  2 +-
>>  block/blk-flush.c | 26 ++++++++++++++------------
>>  block/blk.h       | 12 +++++++++++-
>>  4 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 3f2eb8d80189..0e23589ab3bf 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1310,7 +1310,7 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
>>
>>  struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
>>  {
>> -       if (q->mq_ops)
>> +       if (blk_use_mq_path(q))
>>                 return blk_mq_alloc_request(q, rw,
>>                         (gfp_mask & __GFP_DIRECT_RECLAIM) ?
>>                                 0 : BLK_MQ_REQ_NOWAIT);
> 
> Another way might be to use mq allocator to allocate rq in case of mq_sched,
> such as: just replace mempool_alloc in __get_request() with
> blk_mq_alloc_request(), in this way, it should be possible to
> avoid one extra rq allocation in blk_mq_sched_dispatch(), and keep mq's benefit
> of rq preallocation, which can avoid to hold queue_lock during the
> allocation too.

One problem with the MQ rq allocation is that it's tied to the device
queue depth. This is a problem for scheduling, since we want to have a
larger pool of requests that the IO scheduler can use, so that we
actually have something that we can schedule with. This is a non-starter
on QD=1 devices, but it's also a problem for SATA with 31 effectively
usable tags.

That's why I split it in two, so we have the "old" requests that we hand
to the scheduler. I know the 'rq' field copy isn't super pretty, though.

-- 
Jens Axboe
