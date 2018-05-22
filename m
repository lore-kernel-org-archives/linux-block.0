Return-Path: <axboe@kernel.dk>
Subject: Re: softirq->blk_mq_make_request deadlocks
To: Vitaly Mayatskih <v.mayatskih@gmail.com>, linux-block@vger.kernel.org
References: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5bcc18e8-8d4c-2128-e119-20571e008cc0@kernel.dk>
Date: Tue, 22 May 2018 08:32:13 -0600
MIME-Version: 1.0
In-Reply-To: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/22/18 8:29 AM, Vitaly Mayatskih wrote:
> Hi,
> 
> I'm working on a new network block device and see occasional deadlocks
> when trying to submit_bio from softirq (network rcv handler). This may
> be a new use case for blk-mq, but I think context spinlock should be
> really taken with bh disabled. I *seem* can avoid the deadlock if bio
> has BIO_NOMERGE set, but I need to merge bios for better network
> utilization (no merge costs about 15% of bandwidth). Did I miss
> something, or the lock indeed needs no bh for that case (recursive
> ctx->lock in softirq)?

You can't call submit_bio() from irq/soft irq context, it will
potentially sleep for a new request. The various locks for blk-mq
have been carefully designed _not_ to need irq/bh disabling, but
that's really orthogonal to the previous comment which is your
main issue.

-- 
Jens Axboe
