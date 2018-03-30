Return-Path: <ming.lei@redhat.com>
Date: Fri, 30 Mar 2018 11:15:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180330031554.GC12412@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p>
 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
List-ID: <linux-block@vger.kernel.org>

Hi Thomas,

On Fri, Mar 09, 2018 at 04:08:19PM +0100, Thomas Gleixner wrote:
> On Fri, 9 Mar 2018, Ming Lei wrote:
> > On Fri, Mar 09, 2018 at 11:08:54AM +0100, Thomas Gleixner wrote:
> > > > > So my understanding is that these irq patches are enhancements and not bug
> > > > > fixes. I'll queue them for 4.17 then.
> > > > 
> > > > Wrt. this IO hang issue, these patches shouldn't be bug fix, but they may
> > > > fix performance regression[1] for some systems caused by 84676c1f21 ("genirq/affinity:
> > > > assign vectors to all possible CPUs").
> > > > 
> > > > [1] https://marc.info/?l=linux-block&m=152050347831149&w=2
> > > 
> > > Hmm. The patches are rather large for urgent and evtl. backporting. Is
> > > there a simpler way to address that performance issue?
> > 
> > Not thought of a simpler solution. The problem is that number of active msix vector
> > is decreased a lot by commit 84676c1f21.
> 
> It's reduced in cases where the number of possible CPUs is way larger than
> the number of online CPUs.
> 
> Now, if you look at the number of present CPUs on such systems it's
> probably the same as the number of online CPUs.
> 
> It only differs on machines which support physical hotplug, but that's not
> the normal case. Those systems are more special and less wide spread.
> 
> So the obvious simple fix for this regression issue is to spread out the
> vectors accross present CPUs and not accross possible CPUs.
> 
> I'm not sure if there is a clear indicator whether physcial hotplug is
> supported or not, but the ACPI folks (x86) and architecture maintainers
> should be able to answer that question. I have a machine which says:
> 
>    smpboot: Allowing 128 CPUs, 96 hotplug CPUs
> 
> There is definitely no way to hotplug anything on that machine and sure the
> existing spread algorithm will waste vectors to no end.

percpu variable may waste space too if the possible cpu number is
provided not accurately from ACPI.

> 
> Sure then there is virt, which can pretend to have a gazillion of possible
> hotpluggable CPUs, but virt is an insanity on its own. Though someone might
> come up with reasonable heuristics for that as well.

There are also IBM s390, in which physical CPU hotplug is one normal use
case.

Looks not see any other solution posted out for virt, and it may cause
complicated queue dependency issue by re-introducing CPU hotplug
handler for blk-mq.

> 
> Thoughts?

Given this patchset doesn't have effect on normal machines without
supporting physical CPU hotplug, it can fix performance regression on
machines which might support physical CPU hotplug(cpu_present_mask !=
cpu_possible_mask) with some extra memory allocation cost.

So is there any chance to make it in v4.17?

Thanks,
Ming
