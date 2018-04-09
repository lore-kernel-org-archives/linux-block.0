Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Apr 2018 14:40:26 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] blk-mq: Fix recently introduced races in the timeout
 handling code
Message-ID: <20180409214026.GH3126663@devbig577.frc2.facebook.com>
References: <20180409052038.5391-1-bart.vanassche@wdc.com>
 <20180409164737.GE3126663@devbig577.frc2.facebook.com>
 <4e32290f8d5901fbd16116d1623d37dbfdc1e1b8.camel@wdc.com>
 <20180409185616.GG3126663@devbig577.frc2.facebook.com>
 <f1d8af3b1944d8e2db724fa990d1f09da2c75592.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1d8af3b1944d8e2db724fa990d1f09da2c75592.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Mon, Apr 09, 2018 at 09:30:27PM +0000, Bart Van Assche wrote:
> On Mon, 2018-04-09 at 11:56 -0700, tj@kernel.org wrote:
> > On Mon, Apr 09, 2018 at 05:03:05PM +0000, Bart Van Assche wrote:
> > > exist today in the blk-mq timeout handling code cannot be fixed completely
> > > using RCU only.
> > 
> > I really don't think that is that complicated.  Let's first confirm
> > the race fix and get to narrowing / closing that window.
> 
> Two months ago it was reported for the first time that commit 1d9bd5161ba3
> ("blk-mq: replace timeout synchronization with a RCU and generation based
> scheme") introduces a regression. Since that report nobody has posted a
> patch that fixes all races related to blk-mq timeout handling and that only

The two patches using RCU were posted a long time ago.  It was just
that the repro that only you had at the time didn't work anymore so we
couldn't confirm the fix.  If we now have a different repro, awesome.
Let's see whether the fix works.

> uses RCU. If you want to continue working on this that's fine with me. But
> since my opinion is that it is impossible to fix these races using RCU only
> I will continue working on an alternative approach. See also "[PATCH]
> blk-mq: Fix a race between resetting the timer and completion handling"
> (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18089.html).

ISTR discussing that patch earlier.  Didn't the RCU based fix get
posted after that discussion?

Thanks.

-- 
tejun
