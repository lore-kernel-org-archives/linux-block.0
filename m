Return-Path: <ming.lei@redhat.com>
Date: Mon, 5 Nov 2018 10:18:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Long Li <longli@linuxonhyperv.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
Message-ID: <20181105021807.GC13699@ming.t460p>
References: <20181102145951.31979-1-ming.lei@redhat.com>
 <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
 <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
List-ID: <linux-block@vger.kernel.org>

On Sun, Nov 04, 2018 at 01:02:18PM +0100, Thomas Gleixner wrote:
> Jens,
> 
> On Sat, 3 Nov 2018, Jens Axboe wrote:
> 
> > On 11/2/18 8:59 AM, Ming Lei wrote:
> > > Hi Jens,
> > > 
> > > As I mentioned, there are at least two issues in the patch of '
> > > irq: add support for allocating (and affinitizing) sets of IRQs':
> > > 
> > > 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
> > > 
> > > 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
> > > 
> > > The fix isn't trivial, and I introduce two extra patches as preparation,
> > > then the implementation can be more clean.
> > > 
> > > The patchset is against mq-maps branch of block tree, feel free to
> > > integrate into the whole patchset of multiple queue maps.
> > 
> > Thanks Ming, I ran this through my testing, and I end up with the
> > same maps and affinities for all the cases I cared about. I'm going
> > to drop my initial version, and add the three.
> 
> So I assume, that I can pick up Mings series instead.
> 
> There is another patch pending affecting the irq affinity spreading. Can
> you folks please have a look at it?
> 
> https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

This patch looks fine.

It ensures that all CPUs are covered in irq's affinity when required
vector number is <= nr_numa_nodes.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
