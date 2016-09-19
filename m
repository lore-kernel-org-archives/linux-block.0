Return-Path: <tglx@linutronix.de>
Date: Tue, 20 Sep 2016 01:37:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwing <hch@lst.de>
cc: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
    Jens Axboe <axboe@kernel.dk>, Sebastian Siewior <bigeasy@linutronix.de>,
    Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: Re: [patch 2/3] blk/mq/cpu-notif: Convert to hotplug state machine
In-Reply-To: <20160919222421.GA7077@lst.de>
Message-ID: <alpine.DEB.2.20.1609200032350.5524@nanos>
References: <20160919212207.161583394@linutronix.de> <20160919212601.094034281@linutronix.de> <20160919222421.GA7077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 20 Sep 2016, Christoph Hellwing wrote:

> On Mon, Sep 19, 2016 at 09:28:20PM -0000, Thomas Gleixner wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Install the callbacks via the state machine so we can phase out the cpu
> > hotplug notifiers..
> 
> Didn't Sebastian come up with a version of the hotplug state callbacks
> that can be per-object?  This seems to be a perfect candidate for that.

Indeed. I wrote that myself and forgot about it already..... :(

So yes, we can use that and get rid of blk-mq-cpu.c completely.

Thanks,

	tglx
