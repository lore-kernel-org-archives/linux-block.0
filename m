Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 8 Aug 2016 13:09:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Paolo <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [RFD] I/O scheduling in blk-mq
Message-ID: <20160808200903.GA16275@vader.DHCP.thefacebook.com>
References: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 08, 2016 at 04:09:56PM +0200, Paolo wrote:
> Hi Jens, Tejun, Christoph, all,
> AFAIK blk-mq does not yet feature I/O schedulers. In particular, there
> is no scheduler providing strong guarantees in terms of
> responsiveness, latency for time-sensitive applications and bandwidth
> distribution.
> 
> For this reason, I'm trying to port BFQ to blk-mq, or to develop
> something simpler if even a reduced version of BFQ proves to be too
> heavy (this project is supported by Linaro). If you are willing to
> provide some feedback in this respect, I would like to ask for
> opinions/suggestions on the following two matters, and possibly to
> open a more general discussion on I/O scheduling in blk-mq.
> 
> 1) My idea is to have an independent instance of BFQ, or in general of
> the I/O scheduler, executed for each software queue. Then there would
> be no global scheduling. The drawback of no global scheduling is that
> each process cannot get more than 1/M of the total throughput of the
> device, if M is the number of software queues. But, if I'm not
> mistaken, it is however unfeasible to give a process more than 1/M of
> the total throughput, without lowering the throughput itself. In fact,
> giving a process more than 1/M of the total throughput implies serving
> its software queue, say Q, more than the others.  The only way to do
> it is periodically stopping the service of the other software queues
> and dispatching only the requests in Q. But this would reduce
> parallelism, which is the main way how blk-mq achieves a very high
> throughput. Are these considerations, and, in particular, one
> independent I/O scheduler per software queue, sensible?
> 
> 2) To provide per-process service guarantees, an I/O scheduler must
> create per-process internal queues. BFQ and CFQ use I/O contexts to
> achieve this goal. Is something like that (or exactly the same)
> available also in blk-mq? If so, do you have any suggestion, or link to
> documentation/code on how to use what is available in blk-mq?
> 
> Thanks,
> Paolo

Hi, Paolo,

I've been working on I/O scheduling for blk-mq with Jens for the past
few months (splitting time with other small projects), and we're making
good progress. Like you noticed, the hard part isn't really grafting a
scheduler interface onto blk-mq, it's maintaining good scalability while
providing adequate fairness.

We're working towards a scheduler more like deadline and getting the
architectural issues worked out. The goal is some sort of fairness
across all queues. The scheduler-per-software-queue model won't hold up
so well if we have a slower device with an I/O-hungry process on one CPU
and an interactive process on another CPU.

The issue I'm working through now is that on blk-mq, we only have as
many `struct request`s as the hardware has tags, so on a device with a
limited queue depth, it's really hard to do any sort of intelligent
scheduling. The solution for that is switching over to working with
`struct bio`s in the software queues instead, which abstracts away the
hardware capabilities. I have some work in progress at
https://github.com/osandov/linux/tree/blk-mq-iosched, but it's not yet
at feature-parity.

After that, I'll be back to working on the scheduling itself. The vague
idea is to amortize global scheduling decisions, but I don't have much
concrete code behind that yet.

Thanks!
-- 
Omar
