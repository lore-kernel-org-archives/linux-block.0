Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <bd83d2b6-3e7f-18c0-45d6-7b9f6c015722@fb.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com> <CACVXFVME3jpraUR8cp_i-YFYu4rk4gUCZqOi86PpCHGRrh9c_g@mail.gmail.com>
 <bd83d2b6-3e7f-18c0-45d6-7b9f6c015722@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 3 Nov 2016 22:57:36 +0800
Message-ID: <CACVXFVM0atkprhvin8CXaxMJhx+p_hJtpbkJfxQDskojSSNHGQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Jens Axboe <axboe@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 3, 2016 at 9:38 PM, Jens Axboe <axboe@fb.com> wrote:
> On 11/03/2016 05:17 AM, Ming Lei wrote:
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 0bfaa54d3e9f..ca77c725b4e5 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -2462,6 +2462,8 @@ void blk_start_request(struct request *req)
>>>  {
>>>         blk_dequeue_request(req);
>>>
>>> +       blk_stat_set_issue_time(&req->issue_stat);
>>> +
>>>         /*
>>>          * We are now handing the request to the hardware, initialize
>>>          * resid_len to full count and add the timeout handler.
>>> @@ -2529,6 +2531,8 @@ bool blk_update_request(struct request *req, int
>>> error, unsigned int nr_bytes)
>>>
>>>         trace_block_rq_complete(req->q, req, nr_bytes);
>>>
>>> +       blk_stat_add(&req->q->rq_stats[rq_data_dir(req)], req);
>>
>>
>> blk_update_request() is often called lockless, so it isn't good to
>> do it here.
>
>
> It's not really a concern, not for the legacy path here nor the mq one
> where it is per sw context. The collisions are rare enough that it'll

How do you get the conclusion that the collisions are rare enough
when the counting becomes completely lockless?

Even though it is true, the statistics still may become a mess with rare
collisons.

> skew the latencies a bit for that short window, but then go away again.
> I'd much rather take that, than adding locking for this part.

For legacy case, blk_stat_add() can be moved into blk_finish_request()
for avoiding the collision.


-- 
Ming Lei
