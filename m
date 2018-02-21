Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2018 11:21:11 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180221192111.GE170644@devbig577.frc2.facebook.com>
References: <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
 <20180213212044.GS695913@devbig577.frc2.facebook.com>
 <1518627534.3147.6.camel@wdc.com>
 <20180218131144.GX695913@devbig577.frc2.facebook.com>
 <1519239184.4060.7.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519239184.4060.7.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Wed, Feb 21, 2018 at 06:53:05PM +0000, Bart Van Assche wrote:
> On Sun, 2018-02-18 at 05:11 -0800, tj@kernel.org wrote:
> > On Wed, Feb 14, 2018 at 04:58:56PM +0000, Bart Van Assche wrote:
> > > With this patch applied the tests I ran so far pass.
> > 
> > Ah, great to hear.  Thanks a lot for testing.  Can you please verify
> > the following?  It's the same approach but with RCU sync batching.
> 
> Hello Tejun,
> 
> After having merged kernel v4.16-rc2 into my kernel tree and after having
> applied patch "Avoid that ATA error handling hangs"
> (https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg71145.html) I
> have not been able to reproduce the reported crash - neither with the patch
> applied that was posted on February 13th nor without that patch. This makes
> me wonder whether we should drop the discussed patches unless someone comes
> up with a reproducible test case?

It is an actual bug in that we actually can override the timer setting
of the next request instance.  Given that the race window isn't that
large, it makes sense that the reproducibility is affected by
butterflies.  I think it makes sense to fix the bug.  Any chance you
can test the new patch on top of the reproducible setup?

Thanks.

-- 
tejun
