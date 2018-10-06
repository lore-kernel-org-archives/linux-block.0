Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
Date: Sat, 6 Oct 2018 18:46:22 +0200
Cc: Jan Kara <jack@suse.cz>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andreas Herrmann <aherrmann@suse.com>,
 Mel Gorman <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <6305E683-5078-4DA1-A168-D4E5D9BFA80F@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org> <20181005091626.GA9686@quack2.suse.cz>
 <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
 <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
 <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 06 ott 2018, alle ore 18:20, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>=20
> On 10/5/18 11:46 PM, Paolo Valente wrote:
>>> Il giorno 06 ott 2018, alle ore 05:12, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>>> On 10/5/18 2:16 AM, Jan Kara wrote:
>>>> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>>>>> What I think is missing is measurement results for BFQ on a system =
with
>>>>> multiple CPU sockets and against a fast storage medium. =
Eliminating
>>>>> the host lock from the SCSI core yielded a significant performance
>>>>> improvement for such storage devices. Since the BFQ scheduler =
locks and
>>>>> unlocks bfqd->lock for every dispatch operation it is very likely =
that BFQ
>>>>> will slow down I/O for fast storage devices, even if their driver =
only
>>>>> creates a single hardware queue.
>>>> Well, I'm not sure why that is missing. I don't think anyone =
proposed to
>>>> default to BFQ for such setup? Neither was anyone claiming that BFQ =
is
>>>> better in such situation... The proposal has been: Default to BFQ =
for slow
>>>> storage, leave it to deadline-mq otherwise.
>>>=20
>>> How do you define slow storage? The proposal at the start of this =
thread
>>> was to make BFQ the default for all block devices that create a =
single
>>> hardware queue. That includes all SATA storage since scsi-mq only =
creates
>>> a single hardware queue when using the SATA protocol. The proposal =
to make >> BFQ the default for systems with a single hard disk probably =
makes sense
>>> but I am not sure that making BFQ the default for systems equipped =
with
>>> one or more (SATA) SSDs is also a good idea. Especially for =
multi-socket
>>> systems since BFQ reintroduces a queue-wide lock.
>> No, BFQ has no queue-wide lock.  The very first change made to BFQ =
for
>> porting it to blk-mq was to remove the queue lock.  Guided by Jens, I
>> replaced that lock with the exact, same scheduler lock used in
>> mq-deadline.
>=20
> It's easy to see that both mq-deadline and BFQ define a queue-wide =
lock. For mq-deadline its deadline_data.lock. For BFQ it's =
bfq_data.lock. That last lock serializes all bfq_dispatch_request() =
calls and hence reduces concurrency while processing I/O requests. =46rom =
bfq_dispatch_request():
>=20
> static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
> {
> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
> 	[ ... ]
> 	spin_lock_irq(&bfqd->lock);
> 	[ ... ]
> }
>=20
> I think the above makes it very clear that bfqd->lock is queue-wide.
>=20
> It is easy to understand why both I/O schedulers need a queue-wide =
lock: the only way to avoid race conditions when considering all pending =
I/O requests for scheduling decisions is to use a lock that covers all =
pending requests and hence that is queue-wide.
>=20

Absolutely true.  Queue lock is evidently a very general concept, and
a lock on a scheduler is, in the end, a lock on its internal queue(s).
But the queue lock removed by blk-mq is not that small per-scheduler
lock, but the big, single-request-queue lock.  The effects of the
latter are probably almost one order of magnitude higher than those of
a scheduler lock, even with a non-trivial scheduler like BFQ.

As a simple concrete proof of this fact, consider the numbers that I
already gave you, and that you can re-obtain in five minutes: on a
laptop, BFQ may support up to 400KIOPS.  Probably, even just with noop
as I/O scheduler, the same PC cannot process so many IOPS with legacy
blk (because of the single-request-queue lock).

To sum up, in your argument you mixed two different locks.

Anyway, you are going very deep in this issue.  This takes you very
close to what I'm currently working on (still in a design phase):
increasing the parallel efficiency of BFQ, mainly by reducing the
duration of the pieces of BFQ executed under its scheduler lock.

But the goal of such a non-trivial improvement is to go from the
current 400 KIOPS to more than one million of IOPS.  This is an
improvement that will most likely provide no benefits for probably 99%
of the systems with single-queue devices.  Those systems simply do no go
beyond 300 KIOPS.

So, I'm trying to first devote my limited single-person bandwidth
(sorry, I didn't resist the temptation to joke on this growing
discussion on single-something issues :) ) to improvements that make
BFQ better within its current hardware scope.

Thanks,
Paolo

> Bart.
