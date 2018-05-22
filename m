Return-Path: <v.mayatskih@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6c0ec1c9-7885-98b9-f52a-12f54e2047f7@kernel.dk>
References: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
 <5bcc18e8-8d4c-2128-e119-20571e008cc0@kernel.dk> <CAGF4SLj_qETsiXpSgPLDzU63xcXtAJy2ruKR6D88+vAVKfxNfg@mail.gmail.com>
 <6c0ec1c9-7885-98b9-f52a-12f54e2047f7@kernel.dk>
From: Vitaly Mayatskih <v.mayatskih@gmail.com>
Date: Tue, 22 May 2018 10:50:24 -0400
Message-ID: <CAGF4SLhET4=FuM6KBp+UboF9b2ZAZ_r6xrQM9B+aTG+qB=xF8w@mail.gmail.com>
Subject: Re: softirq->blk_mq_make_request deadlocks
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:44 AM, Jens Axboe <axboe@kernel.dk> wrote:
> Please don't top post, thanks.
>
> On 5/22/18 8:36 AM, Vitaly Mayatskih wrote:
>> I submit with BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, that never
>> locked in my testing done on a couple of different configurations. Of
>> course, it does not say it won't lock elsewhere ;)
>
> BLK_MQ_REQ_RESERVED is not something you should use, it's for
> internal use. If you used NOWAIT, then the issue is likely deadlocking
> on a lock due to not disabling irqs/bhs. But you can't use submit_bio()
> from interrupt in any case, it'll even access current process state.
> That's obviously not valid from an IRQ.
>
>> Unfortunately any queuing is chewing up performance, so I'm trying to
>> find ways around.
>
> This way won't work, I'm afraid.

Ok, thanks for clarification.


-- 
wbr, Vitaly
