Return-Path: <v.mayatskih@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5bcc18e8-8d4c-2128-e119-20571e008cc0@kernel.dk>
References: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
 <5bcc18e8-8d4c-2128-e119-20571e008cc0@kernel.dk>
From: Vitaly Mayatskih <v.mayatskih@gmail.com>
Date: Tue, 22 May 2018 10:36:08 -0400
Message-ID: <CAGF4SLj_qETsiXpSgPLDzU63xcXtAJy2ruKR6D88+vAVKfxNfg@mail.gmail.com>
Subject: Re: softirq->blk_mq_make_request deadlocks
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

I submit with BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, that never
locked in my testing done on a couple of different configurations. Of
course, it does not say it won't lock elsewhere ;)

Unfortunately any queuing is chewing up performance, so I'm trying to
find ways around.

On Tue, May 22, 2018 at 10:32 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 5/22/18 8:29 AM, Vitaly Mayatskih wrote:
>> Hi,
>>
>> I'm working on a new network block device and see occasional deadlocks
>> when trying to submit_bio from softirq (network rcv handler). This may
>> be a new use case for blk-mq, but I think context spinlock should be
>> really taken with bh disabled. I *seem* can avoid the deadlock if bio
>> has BIO_NOMERGE set, but I need to merge bios for better network
>> utilization (no merge costs about 15% of bandwidth). Did I miss
>> something, or the lock indeed needs no bh for that case (recursive
>> ctx->lock in softirq)?
>
> You can't call submit_bio() from irq/soft irq context, it will
> potentially sleep for a new request. The various locks for blk-mq
> have been carefully designed _not_ to need irq/bh disabling, but
> that's really orthogonal to the previous comment which is your
> main issue.
>
> --
> Jens Axboe
>



-- 
wbr, Vitaly
