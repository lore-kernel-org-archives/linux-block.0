Return-Path: <tglx@linutronix.de>
Date: Wed, 4 Apr 2018 10:25:16 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180403160001.GA25255@ming.t460p>
Message-ID: <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <20180308105358.1506-5-ming.lei@redhat.com> <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de> <20180403160001.GA25255@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 4 Apr 2018, Ming Lei wrote:
> On Tue, Apr 03, 2018 at 03:32:21PM +0200, Thomas Gleixner wrote:
> > On Thu, 8 Mar 2018, Ming Lei wrote:
> > > 1) before 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > > 	irq 39, cpu list 0
> > > 	irq 40, cpu list 1
> > > 	irq 41, cpu list 2
> > > 	irq 42, cpu list 3
> > > 
> > > 2) after 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > > 	irq 39, cpu list 0-2
> > > 	irq 40, cpu list 3-4,6
> > > 	irq 41, cpu list 5
> > > 	irq 42, cpu list 7
> > > 
> > > 3) after applying this patch against V4.15+:
> > > 	irq 39, cpu list 0,4
> > > 	irq 40, cpu list 1,6
> > > 	irq 41, cpu list 2,5
> > > 	irq 42, cpu list 3,7
> > 
> > That's more or less window dressing. If the device is already in use when
> > the offline CPUs get hot plugged, then the interrupts still stay on cpu 0-3
> > because the effective affinity of interrupts on X86 (and other
> > architectures) is always a single CPU.
> > 
> > So this only might move interrupts to the hotplugged CPUs when the device
> > is initialized after CPU hotplug and the actual vector allocation moves an
> > interrupt out to the higher numbered CPUs if they have less vectors
> > allocated than the lower numbered ones.
> 
> It works for blk-mq devices, such as NVMe.
> 
> Now NVMe driver creates num_possible_cpus() hw queues, and each
> hw queue is assigned one msix irq vector.
> 
> Storage is Client/Server model, that means the interrupt is only
> delivered to CPU after one IO request is submitted to hw queue and
> it is completed by this hw queue.
> 
> When CPUs is hotplugged, and there will be IO submitted from these
> CPUs, then finally IOs complete and irq events are generated from
> hw queues, and notify these submission CPU by IRQ finally.

I'm aware how that hw-queue stuff works. But that only works if the
spreading algorithm makes the interrupts affine to offline/not-present CPUs
when the block device is initialized.

In the example above:

> > > 	irq 39, cpu list 0,4
> > > 	irq 40, cpu list 1,6
> > > 	irq 41, cpu list 2,5
> > > 	irq 42, cpu list 3,7

and assumed that at driver init time only CPU 0-3 are online then the
hotplug of CPU 4-7 will not result in any interrupt delivered to CPU 4-7.

So the extra assignment to CPU 4-7 in the affinity mask has no effect
whatsoever and even if the spreading result is 'perfect' it just looks
perfect as it is not making any difference versus the original result:

> > >   irq 39, cpu list 0
> > >   irq 40, cpu list 1
> > >   irq 41, cpu list 2
> > >   irq 42, cpu list 3

Thanks,

	tglx
