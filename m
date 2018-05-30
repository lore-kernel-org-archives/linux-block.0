Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader> <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com> <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 30 May 2018 17:13:00 +0800
Message-ID: <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 4:36 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi ming
>
> Thanks for your kindly response.
>
> On 05/30/2018 04:22 PM, Ming Lei wrote:
>>>> you could keep the software queues as-is but add our own version of
>>>> flush_busy_ctxs() that only removes requests of the domain that we want.
>>>> If one domain gets backed up, that might get messy with long iterations,
>>>> though.
>>> Yes, I also considered this approach :)
>>> But the long iterations on every ctx->rq_list looks really inefficient.
>> Right, this list can be quite long if dispatch token is used up.
>>
>> You might try to introduce per-domain list into ctx directly, then 'none'
>> may benefit from this change too since bio merge should be done
>> on the per-domain list actually.
>
> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
> lists, and not need to iterate the whole rq_list any more.
> But what's about the dispatch when there is no io scheduler.

blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
fine in case of 'none' if per-domain list is added to ctx. Then we can make
none to be a bit fair on READ/WRITE.

> We will dispatch request from ctx one by one at the moment.
> If we have per-domain list in ctx, we have to introduce some policies to determine
> which domain to dispatch, and these policies should be in io scheduler actually.

The policy is done by IO scheduler, and you can just pick up request
from ctx/domain list easily by introducing one blk-mq core API.

Thanks,
Ming Lei
