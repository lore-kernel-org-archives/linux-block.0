Return-Path: <hch@lst.de>
Date: Tue, 20 Sep 2016 00:24:21 +0200
From: Christoph Hellwing <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwing <hch@lst.de>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, rt@linutronix.de
Subject: Re: [patch 2/3] blk/mq/cpu-notif: Convert to hotplug state machine
Message-ID: <20160919222421.GA7077@lst.de>
References: <20160919212207.161583394@linutronix.de> <20160919212601.094034281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919212601.094034281@linutronix.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 19, 2016 at 09:28:20PM -0000, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Install the callbacks via the state machine so we can phase out the cpu
> hotplug notifiers..

Didn't Sebastian come up with a version of the hotplug state callbacks
that can be per-object?  This seems to be a perfect candidate for that.
