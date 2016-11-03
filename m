Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Ming Lei <tom.leiming@gmail.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <CACVXFVME3jpraUR8cp_i-YFYu4rk4gUCZqOi86PpCHGRrh9c_g@mail.gmail.com>
 <bd83d2b6-3e7f-18c0-45d6-7b9f6c015722@fb.com>
 <CACVXFVM0atkprhvin8CXaxMJhx+p_hJtpbkJfxQDskojSSNHGQ@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f1a797b7-6cbd-d3b9-3b33-d38b554c1227@fb.com>
Date: Thu, 3 Nov 2016 10:55:42 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVM0atkprhvin8CXaxMJhx+p_hJtpbkJfxQDskojSSNHGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/03/2016 08:57 AM, Ming Lei wrote:
> On Thu, Nov 3, 2016 at 9:38 PM, Jens Axboe <axboe@fb.com> wrote:
>> On 11/03/2016 05:17 AM, Ming Lei wrote:
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index 0bfaa54d3e9f..ca77c725b4e5 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -2462,6 +2462,8 @@ void blk_start_request(struct request *req)
>>>>  {
>>>>         blk_dequeue_request(req);
>>>>
>>>> +       blk_stat_set_issue_time(&req->issue_stat);
>>>> +
>>>>         /*
>>>>          * We are now handing the request to the hardware, initialize
>>>>          * resid_len to full count and add the timeout handler.
>>>> @@ -2529,6 +2531,8 @@ bool blk_update_request(struct request *req, int
>>>> error, unsigned int nr_bytes)
>>>>
>>>>         trace_block_rq_complete(req->q, req, nr_bytes);
>>>>
>>>> +       blk_stat_add(&req->q->rq_stats[rq_data_dir(req)], req);
>>>
>>>
>>> blk_update_request() is often called lockless, so it isn't good to
>>> do it here.
>>
>>
>> It's not really a concern, not for the legacy path here nor the mq one
>> where it is per sw context. The collisions are rare enough that it'll
>
> How do you get the conclusion that the collisions are rare enough
> when the counting becomes completely lockless?

Of all the races I can spot, it basically boils down to accounting one
IO to little or too many.

> Even though it is true, the statistics still may become a mess with rare
> collisons.

How so? Not saying we could not improve it, but we're trading off
precision for scalability. My claim is that the existing code is good
enough. I've run a TON of testing on it, since I've used it for multiple
projects, and it's been solid.

>> skew the latencies a bit for that short window, but then go away again.
>> I'd much rather take that, than adding locking for this part.
>
> For legacy case, blk_stat_add() can be moved into blk_finish_request()
> for avoiding the collision.

Yes, that might be a good idea, since it doesn't cost us anything. For
the mq case, I'm hard pressed to think of areas where we could complete
IO in parallel on the same software queue. You'll never have a software
queue mapped to multiple hardware queues. So we should essentially be
serialized.

In short, I don't see any problems with this.

-- 
Jens Axboe
