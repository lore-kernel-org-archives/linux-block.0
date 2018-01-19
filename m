Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2197d5a1-0e93-e554-4645-2220e2a0b3ae@kernel.dk>
References: <20180119174053.GA967@localhost.didichuxing.com> <2197d5a1-0e93-e554-4645-2220e2a0b3ae@kernel.dk>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 20 Jan 2018 07:35:51 +0800
Message-ID: <CAA70yB6_GFfkyoAP-bqr9bH7df8teNLif2PSjuHOTNXOXOtDpQ@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: use queue_is_rq_based
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

2018-01-20 3:58 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
> On 1/19/18 10:40 AM, weiping zhang wrote:
>> use queue_is_rq_based instead of open code.
>>
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> ---
>>  block/blk-throttle.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 96ad326..457e985 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -2456,7 +2456,7 @@ void blk_throtl_register_queue(struct request_queue *q)
>>       td->throtl_slice = DFL_THROTL_SLICE_HD;
>>  #endif
>>
>> -     td->track_bio_latency = !q->mq_ops && !q->request_fn;
>> +     td->track_bio_latency = !(queue_is_rq_based(q));
>
> Kill the extra parenthesis here.

Oh, kill it at V2.
> --
> Jens Axboe
>
