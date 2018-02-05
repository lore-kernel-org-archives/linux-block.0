Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: v4.15 and I/O hang with BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <3E34D175-88F9-4114-B627-A11262A7B470@linaro.org>
Date: Mon, 5 Feb 2018 20:07:03 +0100
Cc: Ming Lei <ming.lei@redhat.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ivan Kozik <ivan@ludios.org>,
 linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 SERENA ZIVIANI <169364@studenti.unimore.it>
Message-Id: <6BCE8A16-7D00-4B55-8E2D-0DDC7C187C14@linaro.org>
References: <9ad0d544ab2b12f87f44eb4ef88e23a2@natalenko.name>
 <20180130081925.GA25183@ming.t460p>
 <38bd4dbe280bd0934abde764fe0916cd@natalenko.name>
 <20180130144002.GA14401@ming.t460p>
 <3E34D175-88F9-4114-B627-A11262A7B470@linaro.org>
To: bfq-iosched@googlegroups.com
List-ID: <linux-block@vger.kernel.org>



> Il giorno 30 gen 2018, alle ore 16:40, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 30 gen 2018, alle ore 15:40, Ming Lei <ming.lei@redhat.com> =
ha scritto:
>>=20
>> On Tue, Jan 30, 2018 at 03:30:28PM +0100, Oleksandr Natalenko wrote:
>>> Hi.
>>>=20
>> ...
>>>  systemd-udevd-271   [000] ....     4.311033: bfq_insert_requests: =
insert
>>> rq->0
>>>  systemd-udevd-271   [000] ...1     4.311037: =
blk_mq_do_dispatch_sched:
>>> not get rq, 1
>>>         cfdisk-408   [000] ....    13.484220: bfq_insert_requests: =
insert
>>> rq->1
>>>   kworker/0:1H-174   [000] ....    13.484253: =
blk_mq_do_dispatch_sched:
>>> not get rq, 1
>>> =3D=3D=3D
>>>=20
>>> Looks the same, right?
>>=20
>> Yeah, same with before.
>>=20
>=20
> Hi guys,
> sorry for the delay with this fix.  We are proceeding very slowly on
> this, because I'm super busy.  Anyway, now I can at least explain in
> more detail the cause that leads to this hang.  Commit 'a6a252e64914
> ("blk-mq-sched: decide how to handle flush rq via RQF_FLUSH_SEQ")'
> makes all non-flush re-prepared requests be re-inserted into the I/O
> scheduler.  With this change, I/O schedulers may get the same request
> inserted again, even several times, without a finish_request invoked
> on the request before each re-insertion.
>=20
> For the I/O scheduler, every such re-prepared request is equivalent
> to the insertion of a new request. For schedulers like mq-deadline
> or kyber this fact causes no problems. In contrast, it confuses a =
stateful
> scheduler like BFQ, which preserves states for an I/O request until
> finish_request is invoked on it. In particular, BFQ has no way
> to know that the above re-insertions concerns the same, already =
dispatched
> request. So it may get stuck waiting for the completion of these
> re-inserted requests forever, thus preventing any other queue of
> requests to be served.
>=20
> We are trying to address this issue by adding the hook requeue_request
> to bfq interface.
>=20
> Unfortunately, with our current implementation of requeue_request in
> place, bfq eventually gets to an incoherent state.  This is apparently
> caused by a requeue of an I/O request, immediately followed by a
> completion of the same request.  This seems rather absurd, and drives
> bfq crazy.  But this is something for which we don't have definite
> results yet.
>=20
> We're working on it, sorry again for the delay.
>=20

Ok, patch arriving ... Please test it.

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>> --=20
>> Ming
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
