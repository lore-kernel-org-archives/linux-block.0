Return-Path: <rakesh@tuxera.com>
Date: Tue, 6 Jun 2017 10:30:46 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<keith.busch@intel.com>, Johannes Thumshirn <jthumshirn@suse.de>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix hang in remove path
Message-ID: <20170606073046.GA34428@dhcp-216.srv.tuxera.com>
References: <20170602083208.4518-1-ming.lei@redhat.com>
 <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
 <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>
 <20170605084434.GA30864@dhcp-216.srv.tuxera.com>
 <20170605084732.GA30881@dhcp-216.srv.tuxera.com>
 <20170605194532.GA2549@hercules.tuxera.com>
 <23b9bc87-81a0-93e8-3730-f07e68e46702@grimberg.me>
 <20170606071223.GA15359@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170606071223.GA15359@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 06, 2017 at 09:12:23AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 06, 2017 at 10:10:45AM +0300, Sagi Grimberg wrote:
> >
> >>>> Note 7 here is NVME_SC_ABORT_REQ.  Also we would avoid walking through
> >>>> all power states inside the nvme_configure_apst as
> >>>> nvme_set_latency_tolerance was called with value
> >>>> PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1) which sets
> >>>> ctrl->ps_max_latency_us to U64_MAX and tries to send a sync command
> >>>> which of course fails with error message.
> >>
> >> Even though this change from this patch does fix the hang, just tested
> >> again and I can see above error message "failed to set APST feature 7"
> >> while nvme_remove PID is getting executed.
> >>
> >> So, sync requests (while nvme_remove is executing) are going through
> >> and not everything is handled well in .queue_rq while controller is
> >> under deleting state or dead state.
> >
> > The error message is expected because queue_rq is failing the I/O, did
> > you see it actually hang?

No hang.

> >
> > Personally I'm not too bothered with the error log, we can suppress it
> > conditional on the ctrl state if it really annoys people, but if we're
> > conditioning on the ctrl state, we can do it like you suggested anyway...
> 
> Yeah.  Or just remove the error printk entirely..

Thanks for input, lets ignore.

Based on earlier message I guess this is already queued.  If not it
seems worth adding for 4.12-rc.
