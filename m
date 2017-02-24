Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
 <20170220073539.GA17687@lst.de>
 <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <f9b3b2ca-b19b-7c4a-52bb-789c3e2b39e5@kernel.dk>
 <1487957968.2575.6.camel@sandisk.com>
 <CA+55aFw7T8hsZpMfWuo5e=DnsuRjp8cfQzGb8Qeng=RRR61fYA@mail.gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0af4ed69-a9d0-44be-701c-ced76b84bfef@kernel.dk>
Date: Fri, 24 Feb 2017 13:00:39 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFw7T8hsZpMfWuo5e=DnsuRjp8cfQzGb8Qeng=RRR61fYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/24/2017 12:43 PM, Linus Torvalds wrote:
> On Fri, Feb 24, 2017 at 9:39 AM, Bart Van Assche
> <Bart.VanAssche@sandisk.com> wrote:
>>
>> So the crash is caused by an attempt to dereference address 0x6b6b6b6b6b6b6b6b
>> at offset 0x270. I think this means the crash is caused by a use-after-free.
> 
> Yeah, that's POISON_FREE, and that might explain why you see crashes
> that others don't - you obviously have SLAB poisoning enabled. Jens
> may not have.
> 
> %rdi is "struct mapped_device *md", which came from dm_softirq_done() doing
> 
>         struct dm_rq_target_io *tio = tio_from_request(rq);
>         struct request *clone = tio->clone;
>         int rw;
> 
>         if (!clone) {
>                 rq_end_stats(tio->md, rq);
>                 rw = rq_data_dir(rq);
>                 if (!rq->q->mq_ops)
>                         blk_end_request_all(rq, tio->error);
>                 else
>                         blk_mq_end_request(rq, tio->error);
>                 rq_completed(tio->md, rw, false);
>                 return;
>         }
> 
> so it's the 'tio' pointer that has been free'd. But it's worth noting
> that we did apparently successfully dereference "tio" earlier in that
> dm_softirq_done() *without* getting the poison value, so what I think
> might be going on is that the 'tio' thing gets free'd when the code
> does the blk_end_request_all()/blk_mq_end_request() call.
> 
> Which makes sense - that ends the lifetime of the request, which in
> turn also ends the lifetime of the "tio_from_request()", no?
> 
> So the fix may be as simple as just doing
> 
>         if (!clone) {
>                 struct mapped_device *md = tio->md;
> 
>                 rq_end_stats(md, rq);
>                 ...
>                 rq_completed(md, rw, false);
>                 return;
>         }
> 
> because the 'mapped_device' pointer hopefully is still valid, it's
> just 'tio' that has been freed.
> 
> Jens? Bart? Christoph? Somebody who knows this code should
> double-check my thinking above. I don't actually know the tio
> lifetimes, I'm just going by looking at how earlier accesses seemed to
> be fine (eg that "tio->clone" got us NULL, not a POISON_FREE pointer,
> for example).

I think that is spot on. With the request changes for CDBs, for non
blk-mq, we know also carry the payload after the request. But since
blk-mq never frees the request, the above use-after-free with poison
will only happen for !mq. Caching 'md' and avoiding a dereference of
'tio' after calling blk_end_request_all() will likely fix it.

Bart, can you test that?

-- 
Jens Axboe
