Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [RFD] I/O scheduling in blk-mq
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20160808200903.GA16275@vader.DHCP.thefacebook.com>
Date: Wed, 31 Aug 2016 17:20:10 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <418DBB05-30B3-410C-808E-EAAA6CA9C832@linaro.org>
References: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org> <20160808200903.GA16275@vader.DHCP.thefacebook.com>
To: Omar Sandoval <osandov@osandov.com>
List-ID: <linux-block@vger.kernel.org>


Il giorno 08/ago/2016, alle ore 22:09, Omar Sandoval =
<osandov@osandov.com> ha scritto:

> On Mon, Aug 08, 2016 at 04:09:56PM +0200, Paolo wrote:
>> Hi Jens, Tejun, Christoph, all,
>> AFAIK blk-mq does not yet feature I/O schedulers. In particular, =
there
>> is no scheduler providing strong guarantees in terms of
>> responsiveness, latency for time-sensitive applications and bandwidth
>> distribution.
>>=20
>> For this reason, I'm trying to port BFQ to blk-mq, or to develop
>> something simpler if even a reduced version of BFQ proves to be too
>> heavy (this project is supported by Linaro). If you are willing to
>> provide some feedback in this respect, I would like to ask for
>> opinions/suggestions on the following two matters, and possibly to
>> open a more general discussion on I/O scheduling in blk-mq.
>>=20
>> 1) My idea is to have an independent instance of BFQ, or in general =
of
>> the I/O scheduler, executed for each software queue. Then there would
>> be no global scheduling. The drawback of no global scheduling is that
>> each process cannot get more than 1/M of the total throughput of the
>> device, if M is the number of software queues. But, if I'm not
>> mistaken, it is however unfeasible to give a process more than 1/M of
>> the total throughput, without lowering the throughput itself. In =
fact,
>> giving a process more than 1/M of the total throughput implies =
serving
>> its software queue, say Q, more than the others.  The only way to do
>> it is periodically stopping the service of the other software queues
>> and dispatching only the requests in Q. But this would reduce
>> parallelism, which is the main way how blk-mq achieves a very high
>> throughput. Are these considerations, and, in particular, one
>> independent I/O scheduler per software queue, sensible?
>>=20
>> 2) To provide per-process service guarantees, an I/O scheduler must
>> create per-process internal queues. BFQ and CFQ use I/O contexts to
>> achieve this goal. Is something like that (or exactly the same)
>> available also in blk-mq? If so, do you have any suggestion, or link =
to
>> documentation/code on how to use what is available in blk-mq?
>>=20
>> Thanks,
>> Paolo
>=20
> Hi, Paolo,
>=20
> I've been working on I/O scheduling for blk-mq with Jens for the past
> few months (splitting time with other small projects), and we're =
making
> good progress. Like you noticed, the hard part isn't really grafting a
> scheduler interface onto blk-mq, it's maintaining good scalability =
while
> providing adequate fairness.
>=20
> We're working towards a scheduler more like deadline and getting the
> architectural issues worked out. The goal is some sort of fairness
> across all queues.

If I'm not mistaken, the requests of a process (the bios after your
patch) end up in a given software queue basically by chance, i.e.,
because the process happens to be executed on the core which that
queue is associated with. If this is true, then the scheduler cannot
control in which queue a request is sent. So, how do you imagine the
scheduler to control the global request service order exactly? By
stopping the service of some queues and letting only the head-of-line
request(s) of some other queue(s) be dispatched?

In this respect, I guess that, as of now, it is again chance that
determines from which software queue the next request to dispatch is
picked, i.e., it depends on which core the dispatch functions happen
to be executed. Is it correct?

> The scheduler-per-software-queue model won't hold up
> so well if we have a slower device with an I/O-hungry process on one =
CPU
> and an interactive process on another CPU.
>=20

So, the problem would be that the hungry process eats all the
bandwidth, and the interactive one never gets served.

What about the case where both processes are on the same CPU, i.e.,
where the requests of both processes are on the same software queue?
How does the scheduler you envisage guarantees a good latency to the
interactive process in this case? By properly reordering requests
inside the software queue?

I'm sorry if my questions are quite silly, or do not make much sense.

Thanks,
Paolo


> The issue I'm working through now is that on blk-mq, we only have as
> many `struct request`s as the hardware has tags, so on a device with a
> limited queue depth, it's really hard to do any sort of intelligent
> scheduling. The solution for that is switching over to working with
> `struct bio`s in the software queues instead, which abstracts away the
> hardware capabilities. I have some work in progress at
> https://github.com/osandov/linux/tree/blk-mq-iosched, but it's not yet
> at feature-parity.
>=20
> After that, I'll be back to working on the scheduling itself. The =
vague
> idea is to amortize global scheduling decisions, but I don't have much
> concrete code behind that yet.
>=20
> Thanks!
> --=20
> Omar
