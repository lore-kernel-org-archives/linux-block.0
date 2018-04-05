Return-Path: <tglx@linutronix.de>
Date: Thu, 5 Apr 2018 12:12:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180404152018.GB24824@ming.t460p>
Message-ID: <alpine.DEB.2.21.1804051206050.2204@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <20180308105358.1506-5-ming.lei@redhat.com> <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de> <20180403160001.GA25255@ming.t460p> <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1804041317550.2056@nanos.tec.linutronix.de> <20180404152018.GB24824@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 4 Apr 2018, Ming Lei wrote:
> On Wed, Apr 04, 2018 at 02:45:18PM +0200, Thomas Gleixner wrote:
> > Now the 4 offline CPUs are plugged in again. These CPUs won't ever get an
> > interrupt as all interrupts stay on CPU 0-3 unless one of these CPUs is
> > unplugged. Using cpu_present_mask the spread would be:
> > 
> >  	irq 39, cpu list 0,1
> >  	irq 40, cpu list 2,3
> >  	irq 41, cpu list 4,5
> >  	irq 42, cpu list 6,7
> 
> Given physical CPU hotplug isn't common, this way will make only irq 39
> and irq 40 active most of times, so performance regression is caused just
> as Kashyap reported.

That is only true, if CPU 4-7 are in the present mask at boot time. I
seriously doubt that this is the case for Kashyaps scenario. Grrr, if you
would have included him into the Reported-by: tags then I could have asked
him myself.

In the physical hotplug case, the physcially (or virtually) not available
CPUs are not in the present mask. They are solely in the possible mask.

The above is about soft hotplug where the CPUs are physically there and
therefore in the present mask and can be onlined without interaction from
the outside (mechanical or virt config).

If nobody objects, I'll make that change and queue the stuff tomorrow
morning so it can brew a few days in next before I send it off to Linus.

Thanks,

	tglx
