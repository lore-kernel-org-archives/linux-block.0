Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 5 Oct 2016 10:46:14 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org
Subject: Re: [RFD] I/O scheduling in blk-mq
Message-ID: <20161005174614.GA10999@vader>
References: <42e6f39b-7b47-963f-69b8-2cf61e889339@linaro.org>
 <20160808200903.GA16275@vader.DHCP.thefacebook.com>
 <418DBB05-30B3-410C-808E-EAAA6CA9C832@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <418DBB05-30B3-410C-808E-EAAA6CA9C832@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hey, Paolo,

On Wed, Aug 31, 2016 at 05:20:10PM +0200, Paolo Valente wrote:
[snip]
> > Hi, Paolo,
> > 
> > I've been working on I/O scheduling for blk-mq with Jens for the past
> > few months (splitting time with other small projects), and we're making
> > good progress. Like you noticed, the hard part isn't really grafting a
> > scheduler interface onto blk-mq, it's maintaining good scalability while
> > providing adequate fairness.
> > 
> > We're working towards a scheduler more like deadline and getting the
> > architectural issues worked out. The goal is some sort of fairness
> > across all queues.
> 
> If I'm not mistaken, the requests of a process (the bios after your
> patch) end up in a given software queue basically by chance, i.e.,
> because the process happens to be executed on the core which that
> queue is associated with.

Yeah, pretty much.

> If this is true, then the scheduler cannot
> control in which queue a request is sent. So, how do you imagine the
> scheduler to control the global request service order exactly? By
> stopping the service of some queues and letting only the head-of-line
> request(s) of some other queue(s) be dispatched?

For single-queue devices (HDDs, non-NVME SSDs), all of these software
queues feed into one hardware queue, which is where we can control
global service order. For multi-queue devices, we don't really want to
enforce a strict global service order, since that would undermine the
purpose of having multiple queues.

> In this respect, I guess that, as of now, it is again chance that
> determines from which software queue the next request to dispatch is
> picked, i.e., it depends on which core the dispatch functions happen
> to be executed. Is it correct?

blk-mq has a push model of request dispatch rather than a pull model.
That is, in the old block layer the device driver would ask the elevator
for the next request to dispatch. In blk-mq, either the thread
submitting a request or a worker thread will invoke the driver's
dispatch function with the next request.

> > The scheduler-per-software-queue model won't hold up
> > so well if we have a slower device with an I/O-hungry process on one CPU
> > and an interactive process on another CPU.
> > 
> 
> So, the problem would be that the hungry process eats all the
> bandwidth, and the interactive one never gets served.
> 
> What about the case where both processes are on the same CPU, i.e.,
> where the requests of both processes are on the same software queue?
> How does the scheduler you envisage guarantees a good latency to the
> interactive process in this case? By properly reordering requests
> inside the software queue?

We need a combination of controlling the order in which we queue in the
software queues, the order in which we move requests from the software
queues to the hardware queues, and the order in which we dispatch
requests from the hardware queues to the driver.

> I'm sorry if my questions are quite silly, or do not make much sense.

Hope this helps, and sorry for the delay in my response.

> Thanks,
> Paolo
-- 
Omar
