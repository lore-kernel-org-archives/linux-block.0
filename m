Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
 <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
 <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
 <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
 <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
 <CACVXFVPKdqb7p-xMQ_8c7Wa26s6O-36Pi0xNHMRDDR1Ar+bDhA@mail.gmail.com>
 <ee4c1872-e78d-d41c-6d57-284ca1d37592@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1212b1b8-d901-f2ab-25a6-9d42b08c680a@kernel.dk>
Date: Wed, 30 May 2018 08:58:58 -0600
MIME-Version: 1.0
In-Reply-To: <ee4c1872-e78d-d41c-6d57-284ca1d37592@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/30/18 8:55 AM, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your kindly and detailed response. :)
> 
> On 05/30/2018 05:44 PM, Ming Lei wrote:
>> On Wed, May 30, 2018 at 5:20 PM, jianchao.wang
>> <jianchao.w.wang@oracle.com> wrote:
>>> Hi ming
>>>
>>> On 05/30/2018 05:13 PM, Ming Lei wrote:
>>>>> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
>>>>> lists, and not need to iterate the whole rq_list any more.
>>>>> But what's about the dispatch when there is no io scheduler.
>>>> blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
>>>> fine in case of 'none' if per-domain list is added to ctx. Then we can make
>>>> none to be a bit fair on READ/WRITE.
>>>>
>>>
>>> But how to determine when to dispatch READ, WRITE or other more, when there is no io scheduler ?
>>>
>>
>> For blk-mq, no io scheduler means 'none' actually, and it works like a
>> scheduler too, but just shares driver tags, IMO.
>>> Wrt. the current code of 'none', blk-mq just picks up one request from
>> ctx->rq_list
>> directly in FIFO style. If READ/WRITE lists are introduced, only
>> blk_mq_dequeue_from_ctx() is effected, there are several choices
>> left for us:
>>
>> 1) keep the FIFO style of current behaviour by using req->start_time_ns
>>
>> 2) READ/WRIRE fair style by picking up request from the lists in round-robin
>> order
>>
>> 3) or others
>>
>> It just will make more choices for us, :-)
> 
> OK, I got the point.
> 
> But is it necessary to introduce kind of dispatch policy which is more complicated 
> than current simple FIFO style in ctx rq_list dispatching ? 
> If we have this kind of requirement, why not introduce an io scheduler ?
> ITOW, shouldn't we keep the blk-mq core code as simple as possible, and put most of the policy
> into io scheduler ?

That is indeed the point, we're not going to introducing further logic
or merging to 'none'. With that comes various other heuristics, like
being discussed here, and that takes it even further away from the
light weight and non-intrusive nature of it.

-- 
Jens Axboe
