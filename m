Return-Path: <tglx@linutronix.de>
Date: Wed, 4 Apr 2018 14:45:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1804041317550.2056@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <20180308105358.1506-5-ming.lei@redhat.com> <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de> <20180403160001.GA25255@ming.t460p>
 <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 4 Apr 2018, Thomas Gleixner wrote:
> I'm aware how that hw-queue stuff works. But that only works if the
> spreading algorithm makes the interrupts affine to offline/not-present CPUs
> when the block device is initialized.
> 
> In the example above:
> 
> > > > 	irq 39, cpu list 0,4
> > > > 	irq 40, cpu list 1,6
> > > > 	irq 41, cpu list 2,5
> > > > 	irq 42, cpu list 3,7
> 
> and assumed that at driver init time only CPU 0-3 are online then the
> hotplug of CPU 4-7 will not result in any interrupt delivered to CPU 4-7.
> 
> So the extra assignment to CPU 4-7 in the affinity mask has no effect
> whatsoever and even if the spreading result is 'perfect' it just looks
> perfect as it is not making any difference versus the original result:
> 
> > > >   irq 39, cpu list 0
> > > >   irq 40, cpu list 1
> > > >   irq 41, cpu list 2
> > > >   irq 42, cpu list 3

And looking deeper into the changes, I think that the first spreading step
has to use cpu_present_mask and not cpu_online_mask.

Assume the following scenario:

Machine with 8 present CPUs is booted, the 4 last CPUs are
unplugged. Device with 4 queues is initialized.

The resulting spread is going to be exactly your example:

 	irq 39, cpu list 0,4
 	irq 40, cpu list 1,6
 	irq 41, cpu list 2,5
 	irq 42, cpu list 3,7

Now the 4 offline CPUs are plugged in again. These CPUs won't ever get an
interrupt as all interrupts stay on CPU 0-3 unless one of these CPUs is
unplugged. Using cpu_present_mask the spread would be:

 	irq 39, cpu list 0,1
 	irq 40, cpu list 2,3
 	irq 41, cpu list 4,5
 	irq 42, cpu list 6,7

while on a machine where CPU 4-7 are NOT present, but advertised as
possible the spread would be:

 	irq 39, cpu list 0,4
 	irq 40, cpu list 1,6
 	irq 41, cpu list 2,5
 	irq 42, cpu list 3,7

Hmm?

Thanks,

	tglx
