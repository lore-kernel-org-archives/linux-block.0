Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader> <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 30 May 2018 16:22:02 +0800
Message-ID: <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 9:47 AM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Omar
>
> Thanks for your kindly response.
>
> On 05/23/2018 04:02 AM, Omar Sandoval wrote:
>> On Tue, May 22, 2018 at 10:48:29PM +0800, Jianchao Wang wrote:
>>> Currently, kyber is very unfriendly with merging. kyber depends
>>> on ctx rq_list to do merging, however, most of time, it will not
>>> leave any requests in ctx rq_list. This is because even if tokens
>>> of one domain is used up, kyber will try to dispatch requests
>>> from other domain and flush the rq_list there.
>>
>> That's a great catch, I totally missed this.
>>
>> This approach does end up duplicating a lot of code with the blk-mq core
>> even after Jens' change, so I'm curious if you tried other approaches.
>> One idea I had is to try the bio merge against the kqd->rqs lists. Since
>> that's per-queue, the locking overhead might be too high. Alternatively,
>
> Yes, I used to make a patch as you say, try the bio merge against kqd->rqs directly.
> The patch looks even simpler. However, because the khd->lock is needed every time
> when try bio merge, there maybe high contending overhead on hkd->lock when cpu-hctx
> mapping is not 1:1.
>
>> you could keep the software queues as-is but add our own version of
>> flush_busy_ctxs() that only removes requests of the domain that we want.
>> If one domain gets backed up, that might get messy with long iterations,
>> though.
>
> Yes, I also considered this approach :)
> But the long iterations on every ctx->rq_list looks really inefficient.

Right, this list can be quite long if dispatch token is used up.

You might try to introduce per-domain list into ctx directly, then 'none'
may benefit from this change too since bio merge should be done
on the per-domain list actually.


Thanks,
Ming Lei
