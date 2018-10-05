Return-Path: <dedekind1@gmail.com>
Message-ID: <1538720688.14984.143.camel@gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Bart Van Assche <bvanassche@acm.org>, Alan Cox
 <gnomes@lxorguk.ukuu.org.uk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 Linus Walleij <linus.walleij@linaro.org>, linux-block
 <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
 <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian
 Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,  Andreas
 Herrmann <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>, Chunyan Zhang
 <zhang.chunyan@linaro.org>,  linux-kernel <linux-kernel@vger.kernel.org>
Date: Fri, 05 Oct 2018 09:24:48 +0300
In-Reply-To: <1538683746.230807.9.camel@acm.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
	 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
	 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
	 <1538582091.205649.20.camel@acm.org>
	 <20181004202553.71c2599c@alans-desktop> <1538683746.230807.9.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-10-04 at 13:09 -0700, Bart Van Assche wrote:
> On Thu, 2018-10-04 at 20:25 +0100, Alan Cox wrote:
> > > I agree with Jens that it's best to leave it to the Linux distributors to
> > > select a default I/O scheduler.
> > 
> > That assumes such a thing exists. The kernel knows what devices it is
> > dealing with. The kernel 'default' ought to be 'whatever is usually best
> > for this device'. A distro cannot just pick a correct single default
> > because NVME and USB sticks are both normal and rather different in needs.
> 
> Which I/O scheduler works best also depends which workload the user will run.
> BFQ has significant advantages for interactive workloads like video replay
> with concurrent background I/O but probably slows down kernel builds. That's
> why I'm not sure whether the kernel should select the default I/O scheduler.

Whats wrong with this simple hierarchy?

1. Block core selects the default scheduler.
2. Driver can overrule it early.
3. Userspace can overrule the default later.

Everyone is happy.

Good defaults in block core are great. Those defaults + #3 may cover
99% of the population.

1% of the population can use #2. See, Linus wants "bfq" for ubiblock.
Why wouldn't we to let him work with UBI community, show that bfq is 
best for ubiblock, and just let the UBI community overrule the block
core's default.

If some day in the future there is a very good reason, we can even make
this to be a module parameter, and people could just boot with
'ubiblock.iosched=bfq'.
