Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Jens Axboe <axboe@kernel.dk>, Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <163c5760-cf0e-faea-ee4e-ac5d688310fe@applied-asynchrony.com>
 <00e5dfd4-d3a2-b008-3d8b-390a788f61c9@kernel.dk>
 <7c93b85f-6a02-bdcf-5e92-a9533500df20@kernel.dk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <fc26ef08-2e2a-3b2d-2190-8419307b243e@applied-asynchrony.com>
Date: Tue, 22 May 2018 20:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <7c93b85f-6a02-bdcf-5e92-a9533500df20@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/22/18 19:46, Jens Axboe wrote:
> On 5/22/18 10:20 AM, Jens Axboe wrote:
>> On 5/22/18 10:17 AM, Holger Hoffstätte wrote:
>>> On 05/22/18 16:48, Jianchao Wang wrote:
>>>> Currently, kyber is very unfriendly with merging. kyber depends
>>>> on ctx rq_list to do merging, however, most of time, it will not
>>>> leave any requests in ctx rq_list. This is because even if tokens
>>>> of one domain is used up, kyber will try to dispatch requests
>>>> from other domain and flush the rq_list there.
>>>>
>>>> To improve this, we setup kyber_ctx_queue (kcq) which is similar
>>>> with ctx, but it has rq_lists for different domain and build same
>>>> mapping between kcq and khd as the ctx & hctx. Then we could merge,
>>>> insert and dispatch for different domains separately. If one domain
>>>> token is used up, the requests could be left in the rq_list of
>>>> that domain and maybe merged with following io.
>>>>
>>>> Following is my test result on machine with 8 cores and NVMe card
>>>> INTEL SSDPEKKR128G7
>>>>
>>>> fio size=256m ioengine=libaio iodepth=64 direct=1 numjobs=8
>>>> seq/random
>>>> +------+---------------------------------------------------------------+
>>>> |patch?| bw(MB/s) |   iops    | slat(usec) |    clat(usec)   |  merge  |
>>>> +----------------------------------------------------------------------+
>>>> | w/o  |  606/612 | 151k/153k |  6.89/7.03 | 3349.21/3305.40 |   0/0   |
>>>> +----------------------------------------------------------------------+
>>>> | w/   | 1083/616 | 277k/154k |  4.93/6.95 | 1830.62/3279.95 | 223k/3k |
>>>> +----------------------------------------------------------------------+
>>>> When set numjobs to 16, the bw and iops could reach 1662MB/s and 425k
>>>> on my platform.
>>>>
>>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>>
>>> <snip>
>>>
>>> This looks great but prevents kyber from being built as module,
>>> which is AFAIK supposed to work (and works now):
>>>
>>> ..
>>>   CC [M]  block/kyber-iosched.o
>>>   Building modules, stage 2.
>>>   MODPOST 313 modules
>>> ERROR: "bio_attempt_back_merge" [block/kyber-iosched.ko] undefined!
>>> ERROR: "bio_attempt_front_merge" [block/kyber-iosched.ko] undefined!
>>> ERROR: "bio_attempt_discard_merge" [block/kyber-iosched.ko] undefined!
>>> ERROR: "blk_try_merge" [block/kyber-iosched.ko] undefined!
>>> ERROR: "blk_rq_merge_ok" [block/kyber-iosched.ko] undefined!
>>> ..
>>>
>>> It does build fine when compiled in, obviously. :)
>>
>> It's basically duplicating the contents of blk_attempt_plug_merge().
>> I would suggest abstracting out the list loop and merge check
>> into a helper, that could then both be called from kyber and the
>> plug merge function.
> 
> See attached, prep patch and yours rebased on top of it.

That was quick. :)

Applies smoothly on top of my 4.16++ tree, now builds correctly as
module and is reproducibly (slightly) faster even on my pedestrian
SATA SSDs, now on par or occasionally even faster than mq-deadline.
What's not to like? So:

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers,
Holger
