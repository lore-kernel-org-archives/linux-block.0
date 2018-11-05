Return-Path: <tglx@linutronix.de>
Date: Mon, 5 Nov 2018 12:24:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
    LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.com>,
    Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
    Long Li <longli@microsoft.com>
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
In-Reply-To: <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1811051220330.1566@nanos.tec.linutronix.de>
References: <20181102145951.31979-1-ming.lei@redhat.com> <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk> <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de> <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
 <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Jens,

On Sun, 4 Nov 2018, Thomas Gleixner wrote:
> On Sun, 4 Nov 2018, Jens Axboe wrote:
> > On 11/4/18 5:02 AM, Thomas Gleixner wrote:
> > > So I assume, that I can pick up Mings series instead.
> > 
> > Yes, let's do that.
> > 
> > > There is another patch pending affecting the irq affinity spreading. Can
> > > you folks please have a look at it?
> > > 
> > > https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com
> > 
> > I'll give that a look and test. Thanks for the heads-up.

I picked the series from Ming and the patch from Long and merged it into
tip/irq/core.

The result is available for you to pull from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

That branch is immutable now and I keep it around in case that there are
incremental updates necessary before the merge window.

Thanks,

	tglx
