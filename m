Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] block: add accessors for setting/querying request
 deadline
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1515522422-21596-1-git-send-email-axboe@kernel.dk>
 <1515522422-21596-3-git-send-email-axboe@kernel.dk>
 <1515523233.2721.16.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <63166fe3-b595-1919-87ad-2eb734596323@kernel.dk>
Date: Tue, 9 Jan 2018 11:41:21 -0700
MIME-Version: 1.0
In-Reply-To: <1515523233.2721.16.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 11:40 AM, Bart Van Assche wrote:
> On Tue, 2018-01-09 at 11:27 -0700, Jens Axboe wrote:
>> +static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
>> +{
>> +	rq->__deadline = time & ~0x1;
>> +}
>> +
>> +static inline unsigned long blk_rq_deadline(struct request *rq)
>> +{
>> +	return rq->__deadline & ~0x1;
>> +}
> 
> Hello Jens,
> 
> The type of rq->__deadline is "unsigned long" but the type of the right-hand
> side constant is int. Shouldn't an "UL" suffix be added to the RHS constant?

Good catch, yeah you're right. I'll make that change, thanks.

-- 
Jens Axboe
