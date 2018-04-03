Return-Path: <tglx@linutronix.de>
Date: Tue, 3 Apr 2018 14:55:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
    Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180330031554.GC12412@ming.t460p>
Message-ID: <alpine.DEB.2.21.1804031435450.2511@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p> <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de> <20180309012458.GD5228@ming.t460p> <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p> <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de> <20180330031554.GC12412@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Ming,

On Fri, 30 Mar 2018, Ming Lei wrote:
> On Fri, Mar 09, 2018 at 04:08:19PM +0100, Thomas Gleixner wrote:
> > Thoughts?
> 
> Given this patchset doesn't have effect on normal machines without
> supporting physical CPU hotplug, it can fix performance regression on
> machines which might support physical CPU hotplug(cpu_present_mask !=
> cpu_possible_mask) with some extra memory allocation cost.
>
> So is there any chance to make it in v4.17?

Sorry, that thing fell through the cracks. I'll queue it now and try to do
a pull request late in the merge window.

Thanks,

	tglx
