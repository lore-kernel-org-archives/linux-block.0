Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] bfq-mq: cause deadlock by executing exit_icq body immediately
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170207214516.GA14269@vader.DHCP.thefacebook.com>
Date: Wed, 8 Feb 2017 11:03:01 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <A064B1DA-C96B-4EA9-A412-F2A6D8FB295A@linaro.org>
References: <20170207173346.4789-1-paolo.valente@linaro.org> <20170207214516.GA14269@vader.DHCP.thefacebook.com>
To: Omar Sandoval <osandov@osandov.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 feb 2017, alle ore 22:45, Omar Sandoval =
<osandov@osandov.com> ha scritto:
>=20
> On Tue, Feb 07, 2017 at 06:33:46PM +0100, Paolo Valente wrote:
>> Hi,
>> this patch is meant to show that, if the  body of the hook exit_icq =
is executed
>> from inside that hook, and not as deferred work, then a circular =
deadlock
>> occurs.
>>=20
>> It happens if, on a CPU
>> - the body of icq_exit takes the scheduler lock,
>> - it does so from inside the exit_icq hook, which is invoked with the =
queue
>>  lock held
>>=20
>> while, on another CPU
>> - bfq_bio_merge, after taking the scheduler lock, invokes =
bfq_bic_lookup,
>>  which, in its turn, takes the queue lock. bfq_bic_lookup needs to =
take such a
>>  lock, because it invokes ioc_lookup_icq.
>>=20
>> For more details, here is a lockdep report, right before the deadlock =
did occur.
>>=20
>> [   44.059877] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   44.124922] [ INFO: possible circular locking dependency detected =
]
>> [   44.125795] 4.10.0-rc5-bfq-mq+ #38 Not tainted
>> [   44.126414] =
-------------------------------------------------------
>> [   44.127291] sync/2043 is trying to acquire lock:
>> [   44.128918]  (&(&bfqd->lock)->rlock){-.-...}, at: =
[<ffffffff90484195>] bfq_exit_icq_bfqq+0x55/0x140
>> [   44.134052]
>> [   44.134052] but task is already holding lock:
>> [   44.134868]  (&(&q->__queue_lock)->rlock){-.....}, at: =
[<ffffffff9044738e>] put_io_context_active+0x6e/0xc0
>=20
> Hey, Paolo,
>=20
> I only briefly skimmed the code, but what are you using the queue_lock
> for? You should just use your scheduler lock everywhere. blk-mq =
doesn't
> use the queue lock, so the scheduler is the only thing you need mutual
> exclusion against.

Hi Omar,
the cause of the problem is that the hook functions bfq_request_merge
and bfq_allow_bio_merge invoke, directly or through other functions,
the function bfq_bic_lookup, which, in its turn, invokes
ioc_lookup_icq.  The latter must be invoked with the queue lock held.
In particular the offending lines in bfq_bic_lookup are:

		spin_lock_irqsave(q->queue_lock, flags);
		icq =3D icq_to_bic(ioc_lookup_icq(ioc, q));
		spin_unlock_irqrestore(q->queue_lock, flags);

Maybe I'm missing something and we can avoid taking this lock?

Thanks,
Paolo

> I'm guessing if you stopped using that, your locking
> issues would go away.
