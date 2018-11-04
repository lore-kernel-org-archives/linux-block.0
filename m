Return-Path: <tglx@linutronix.de>
Date: Sun, 4 Nov 2018 19:39:59 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
    LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>,
    Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
    Long Li <longli@microsoft.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
In-Reply-To: <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
Message-ID: <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
References: <20181102145951.31979-1-ming.lei@redhat.com> <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk> <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de> <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Sun, 4 Nov 2018, Jens Axboe wrote:

Cc'ing Long with a hopefully working E-Mail address. The previous one
bounced because I stupidly copied the wrong one...

> On 11/4/18 5:02 AM, Thomas Gleixner wrote:
> > Jens,
> > 
> > On Sat, 3 Nov 2018, Jens Axboe wrote:
> > 
> >> On 11/2/18 8:59 AM, Ming Lei wrote:
> >>> Hi Jens,
> >>>
> >>> As I mentioned, there are at least two issues in the patch of '
> >>> irq: add support for allocating (and affinitizing) sets of IRQs':
> >>>
> >>> 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> >>>
> >>> 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> >>>
> >>> The fix isn't trivial, and I introduce two extra patches as preparation,
> >>> then the implementation can be more clean.
> >>>
> >>> The patchset is against mq-maps branch of block tree, feel free to
> >>> integrate into the whole patchset of multiple queue maps.
> >>
> >> Thanks Ming, I ran this through my testing, and I end up with the
> >> same maps and affinities for all the cases I cared about. I'm going
> >> to drop my initial version, and add the three.
> > 
> > So I assume, that I can pick up Mings series instead.
> 
> Yes, let's do that.
> 
> > There is another patch pending affecting the irq affinity spreading. Can
> > you folks please have a look at it?
> > 
> > https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com
> 
> I'll give that a look and test. Thanks for the heads-up.
> 
> -- 
> Jens Axboe
> 
> 
