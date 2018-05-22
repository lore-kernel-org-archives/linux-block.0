Return-Path: <axboe@kernel.dk>
Subject: Re: softirq->blk_mq_make_request deadlocks
To: Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc: linux-block@vger.kernel.org
References: <CAGF4SLg42Ni3gXAyVZOxZcaYVOBBS3qaTK9u=0NCAxPGwQLt-g@mail.gmail.com>
 <5bcc18e8-8d4c-2128-e119-20571e008cc0@kernel.dk>
 <CAGF4SLj_qETsiXpSgPLDzU63xcXtAJy2ruKR6D88+vAVKfxNfg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6c0ec1c9-7885-98b9-f52a-12f54e2047f7@kernel.dk>
Date: Tue, 22 May 2018 08:44:51 -0600
MIME-Version: 1.0
In-Reply-To: <CAGF4SLj_qETsiXpSgPLDzU63xcXtAJy2ruKR6D88+vAVKfxNfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Please don't top post, thanks.

On 5/22/18 8:36 AM, Vitaly Mayatskih wrote:
> I submit with BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, that never
> locked in my testing done on a couple of different configurations. Of
> course, it does not say it won't lock elsewhere ;)

BLK_MQ_REQ_RESERVED is not something you should use, it's for
internal use. If you used NOWAIT, then the issue is likely deadlocking
on a lock due to not disabling irqs/bhs. But you can't use submit_bio()
from interrupt in any case, it'll even access current process state.
That's obviously not valid from an IRQ.

> Unfortunately any queuing is chewing up performance, so I'm trying to
> find ways around.

This way won't work, I'm afraid.

-- 
Jens Axboe
