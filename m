Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v6] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
References: <20180419164353.13561-1-bart.vanassche@wdc.com>
 <18cd85bb-ee41-ce6f-e8c8-dcf6e7fd0504@oracle.com>
 <a47209f74d52d19464f993c11c4a4811271e6348.camel@wdc.com>
 <389cc1a6-6c2a-db08-fec1-1e103a6a9c9e@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7183cb81-5fb5-eea2-afaf-443f26921257@kernel.dk>
Date: Sat, 21 Apr 2018 08:10:37 -0600
MIME-Version: 1.0
In-Reply-To: <389cc1a6-6c2a-db08-fec1-1e103a6a9c9e@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/21/18 7:34 AM, jianchao.wang wrote:
> Hi Bart
> 
> Thanks for your kindly response.
> 
> On 04/20/2018 10:11 PM, Bart Van Assche wrote:
>> On Fri, 2018-04-20 at 14:55 +0800, jianchao.wang wrote:
>>> Hi Bart
>>>
>>> On 04/20/2018 12:43 AM, Bart Van Assche wrote:
>>>> Use the deadline instead of the request generation to detect whether
>>>>   or not a request timer fired after reinitialization of a request
>>>
>>> Maybe use deadline to do this is not suitable.
>>>
>>> Let's think of the following scenario.
>>>
>>> T1/T2 times in nano seconds
>>> J1/J2 times in jiffies
>>>
>>> rq is started at T1,J1
>>> blk_mq_timeout_work
>>>   -> blk_mq_check_expired
>>>     -> save rq->__deadline (J1 + MQ_RQ_IN_FLIGHT)
>>>
>>>                                              rq is completed and freed 
>>>                                              rq is allocated and started again on T2
>>>                                              rq->__deadline = J2 + MQ_RQ_IN_FLIGHT
>>>   -> synchronize srcu/rcu
>>>   -> blk_mq_terminate_expired
>>>     -> rq->__deadline (J2 + MQ_RQ_IN_FLIGHT)
>>>
>>> 1. deadline = rq->__deadline & ~RQ_STATE_MASK (0x3)
>>>    if J2-J1 < 4 jiffies, we will get the same deadline value.
>>>
>>> 2. even if we do some bit shift when save and get deadline
>>>    if T2 - T1 < time of 1 jiffies, we sill get the same deadline.
>>
>> Hello Jianchao,
>>
>> How about using the upper 16 or 32 bits of rq->__deadline to store a generation
>> number? I don't know any block driver for which the product of (deadline in
>> seconds) and HZ exceeds (1 << 32).
>>
> yes, we don't need so long timeout value.
> However, req->__deadline is an absolute time, not a relative one, 
> its type is unsigned long variable which is same with jiffies.
> If we reserve some bits (not just 1 or 2 bits) of req->__deadline for generation number,
> how to handle it when mod_timer ?

We don't need to support timeouts to the full granularity of jiffies.
Most normal commands are in the 30-60s range, and some lower level
commands may take minutes. We're well within the range of chopping
off some bits and not having to worry about that at all.

-- 
Jens Axboe
