Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 5 Apr 2017 13:54:51 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@HansenPartnership.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/5] blk-mq: Introduce blk_mq_ops.restart_hctx
Message-ID: <20170405205451.GD22645@vader.DHCP.thefacebook.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
 <20170403232228.11208-4-bart.vanassche@sandisk.com>
 <20170405204120.GC22645@vader.DHCP.thefacebook.com>
 <1491425510.2787.15.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491425510.2787.15.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 05, 2017 at 08:51:51PM +0000, Bart Van Assche wrote:
> On Wed, 2017-04-05 at 13:41 -0700, Omar Sandoval wrote:
> > On Mon, Apr 03, 2017 at 04:22:26PM -0700, Bart Van Assche wrote:
> > > If a tag set is shared among multiple hardware queues, leave
> > > it to the block driver to rerun hardware queues. Hence remove
> > > QUEUE_FLAG_RESTART and introduce blk_mq_ops.restart_hctx.
> > > Remove blk_mq_sched_mark_restart_queue() because this
> > > function has no callers.
> > 
> > Kyber uses blk_mq_sched_mark_restart_queue() and the QUEUE_FLAG_RESTART
> > bit. If it's not too much trouble, it'd make things easier for me if you
> > left it in place. If it's a pain, it's fine if you get rid of it, I can
> > reintroduce it in my series.
> 
> Hello Omar,
> 
> Would it be OK for you to reintroduce blk_mq_sched_mark_restart_queue()?
> Since that function does not yet have any users I can't test any changes
> I make to that function ...
> 
> Thanks,
> 
> Bart.

Yeah, that's fine.
