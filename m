Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: provide a helper to check if a queue is busy
To: Laurence Oberman <loberman@redhat.com>, linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
References: <20181108154216.23853-1-axboe@kernel.dk>
 <20181108154216.23853-3-axboe@kernel.dk>
 <1541692483.24444.3.camel@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <881d6a31-7420-6d0d-9762-b18098a48c5d@kernel.dk>
Date: Thu, 8 Nov 2018 08:58:49 -0700
MIME-Version: 1.0
In-Reply-To: <1541692483.24444.3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 8:54 AM, Laurence Oberman wrote:
> On Thu, 2018-11-08 at 08:42 -0700, Jens Axboe wrote:
>> +static bool blk_mq_check_busy(struct blk_mq_hw_ctx *hctx, struct
>> request *rq,
>> +                             void *priv, bool reserved)
>> +{
>> +       bool *busy = (bool *) priv;
>> +
>> +       /*
>> +        * If we find a request, we know the queue is busy. Return
>> false
>> +        * to stop the iteration.
>> +        */
>> +       *busy = true;
>> +       return false;
>> +}
>> +
> 
> Hi Jens,
> 
> Trying to understand the logic, likely just my lack of knowledge
> You return false after setting true because you say we know the queue
> is busy.
> How do we know we found a request here
> I dont see you check the result of 
>  bool *busy = (bool *) priv;
> Is the assumption here because this was called we already knew we had a
> request

Yes, that's absolutely right - if we get into the helper, we know we
already have a request. Hence we know the queue is busy. Actually
thinking about it, for shared tags, we need to check if the request
is for the given queue. Will send a v2...

-- 
Jens Axboe
