Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/4] block: convert REQ_ATOM_COMPLETE to stealing
 rq->__deadline bit
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
 <1515522422-21596-4-git-send-email-axboe@kernel.dk>
 <1515523384.2721.18.camel@wdc.com>
 <ccb238ec-d916-a094-1cc9-54970d270640@kernel.dk>
Message-ID: <35e76a1c-f42d-3166-ecb7-97cad0ea78b8@kernel.dk>
Date: Tue, 9 Jan 2018 11:52:26 -0700
MIME-Version: 1.0
In-Reply-To: <ccb238ec-d916-a094-1cc9-54970d270640@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 11:44 AM, Jens Axboe wrote:
> On 1/9/18 11:43 AM, Bart Van Assche wrote:
>> On Tue, 2018-01-09 at 11:27 -0700, Jens Axboe wrote:
>>>  static inline int blk_mark_rq_complete(struct request *rq)
>>>  {
>>> -	return test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
>>> +	return test_and_set_bit(0, &rq->__deadline);
>>>  }
>>>  
>>>  static inline void blk_clear_rq_complete(struct request *rq)
>>>  {
>>> -	clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
>>> +	clear_bit(0, &rq->__deadline);
>>> +}
>>> +
>>> +static inline bool blk_rq_is_complete(struct request *rq)
>>> +{
>>> +	return test_bit(0, &rq->__deadline);
>>>  }
>>
>> Hello Jens,
>>
>> With this change setting or changing the deadline clears the COMPLETE flag.
>> Is that the intended behavior? If so, should perhaps a comment be added above
>> blk_rq_set_deadline()?
> 
> Yeah, it's intentional. I can add a comment to that effect. It's only done
> before queueing - except for the case where we force a timeout, but for that
> it's only on the blk-mq side, which doesn't care.

Since we clear it when we init the request, we could also just leave the
bit intact when setting the deadline. That's probably the safer choice:

static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)  
{                                                                               
        rq->__deadline = (time & ~0x1UL) | (rq->__deadline & 0x1UL);
}

I'll test that, previous testing didn't find anything wrong with clearing
the bit, but this does seem safer.

-- 
Jens Axboe
