Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-throttle: fix null pointer dereference while
 throttling writeback IOs
To: Shaohua Li <shli@kernel.org>
Cc: xuejiufei <xuejiufei@gmail.com>, linux-block@vger.kernel.org,
 Shaohua Li <shli@fb.com>, wenqing.lz@taobao.com, boyu.mt@taobao.com,
 jiufei.xjf@alibaba-inc.com
References: <9fdd7f4b-91b5-7612-bf91-7b18defffb58@gmail.com>
 <5e5b83db-6f78-9869-fe9c-b1f6a09281ca@gmail.com>
 <20171010181357.ymdqxzwnvon5jo5y@kernel.org>
 <6e1bc8fa-4d5e-32e2-3cd8-d958c10cb33f@kernel.dk>
 <20171010190556.6y6spemhdlmqf7ie@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e8c7cb80-38cb-925a-9a2d-f639ba7d767a@kernel.dk>
Date: Tue, 10 Oct 2017 13:09:10 -0600
MIME-Version: 1.0
In-Reply-To: <20171010190556.6y6spemhdlmqf7ie@kernel.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/10/2017 01:05 PM, Shaohua Li wrote:
> On Tue, Oct 10, 2017 at 12:48:38PM -0600, Jens Axboe wrote:
>> On 10/10/2017 12:13 PM, Shaohua Li wrote:
>>> On Tue, Oct 10, 2017 at 11:13:32AM +0800, xuejiufei wrote:
>>>> From: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
>>>>
>>>> A null pointer dereference can occur when blkcg is removed manually
>>>> with writeback IOs inflight. This is caused by the following case:
>>>>
>>>> Writeback kworker submit the bio and set bio->bi_cg_private to tg
>>>> in blk_throtl_assoc_bio.
>>>> Then we remove the block cgroup manually, the blkg and tg would be
>>>> freed if there is no request inflight.
>>>> When the submitted bio come back, blk_throtl_bio_endio() fetch the tg
>>>> which was already freed.
>>>>
>>>> Fix this by increasing the refcount of blkg in funcion
>>>> blk_throtl_assoc_bio() so that the blkg will not be freed until the
>>>> bio_endio called.
>>>>
>>>> Signed-off-by: Jiufei Xue <jiufei.xjf@alibaba-inc.com>
>>>> ---
>>>>  block/blk-throttle.c | 12 ++++++++++--
>>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>>>> index 17816a0..d80c3f0 100644
>>>> --- a/block/blk-throttle.c
>>>> +++ b/block/blk-throttle.c
>>>> @@ -2112,8 +2112,12 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>>>>  static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
>>>>  {
>>>>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>>>> -	if (bio->bi_css)
>>>> +	if (bio->bi_css) {
>>>> +		if (bio->bi_cg_private)
>>>> +			blkg_put(tg_to_blkg(bio->bi_cg_private));
>>>>  		bio->bi_cg_private = tg;
>>>> +		blkg_get(tg_to_blkg(tg));
>>>> +	}
>>>>  	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
>>>>  #endif
>>>>  }
>>>> @@ -2283,8 +2287,10 @@ void blk_throtl_bio_endio(struct bio *bio)
>>>>  
>>>>  	start_time = blk_stat_time(&bio->bi_issue_stat) >> 10;
>>>>  	finish_time = __blk_stat_time(finish_time_ns) >> 10;
>>>> -	if (!start_time || finish_time <= start_time)
>>>> +	if (!start_time || finish_time <= start_time) {
>>>> +		blkg_put(tg_to_blkg(tg));
>>>>  		return;
>>>> +	}
>>>>  
>>>>  	lat = finish_time - start_time;
>>>>  	/* this is only for bio based driver */
>>>> @@ -2314,6 +2320,8 @@ void blk_throtl_bio_endio(struct bio *bio)
>>>>  		tg->bio_cnt /= 2;
>>>>  		tg->bad_bio_cnt /= 2;
>>>>  	}
>>>> +
>>>> +	blkg_put(tg_to_blkg(tg));
>>>>  }
>>>>  #endif
>>>
>>> Reviewed-by: Shaohua Li <shli@fb.com>
>>
>> I was going to queue this up for 4.15, but was wondering if there's a
>> strong reason to include it for 4.14 instead?
> 
> Either is ok to me, this isn't easy to trigger, but on the other hand it's
> quite safe.

OK, let's just stick with 4.15 then.

-- 
Jens Axboe
