Return-Path: <ming.lei@redhat.com>
Date: Tue, 22 May 2018 09:46:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] nvme: Move all IO out of controller reset
Message-ID: <20180522014626.GA20430@ming.t460p>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518163823.27820-3-keith.busch@intel.com>
 <20180518230357.GC18334@ming.t460p>
 <20180521142219.GC5528@localhost.localdomain>
 <20180521145850.GA19099@ming.t460p>
 <20180521150331.GI5528@localhost.localdomain>
 <20180521153425.GC19099@ming.t460p>
 <20180521154433.GJ5528@localhost.localdomain>
 <20180521160452.GD19099@ming.t460p>
 <20180521162354.GM5528@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521162354.GM5528@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 10:23:55AM -0600, Keith Busch wrote:
> On Tue, May 22, 2018 at 12:04:53AM +0800, Ming Lei wrote:
> > On Mon, May 21, 2018 at 09:44:33AM -0600, Keith Busch wrote:
> > > On Mon, May 21, 2018 at 11:34:27PM +0800, Ming Lei wrote:
> > > > nvme_dev_disable() quiesces queues first before killing queues.
> > > > 
> > > > If queues are quiesced during or before nvme_wait_freeze() is run
> > > > from the 2nd part of reset, the 2nd part can't move on, and IO hang
> > > > is caused. Finally no reset can be scheduled at all.
> > > 
> > > But this patch moves nvme_wait_freeze outside the reset path, so I'm
> > > afraid I'm unable to follow how you've concluded the wait freeze is
> > > somehow part of the reset.
> > 
> > For example:
> > 
> > 1) the 1st timeout event:
> > 
> > - nvme_dev_disable()
> > - reset
> > - scan_work
> > 
> > 2) the 2nd timeout event:
> > 
> > nvme_dev_disable() may come just after nvme_start_queues() in
> > the above reset of the 1st timeout. And nvme_timeout() won't
> > schedule a new reset since the controller state is NVME_CTRL_CONNECTING.
> 
> Let me get this straight -- you're saying nvme_start_queues is going
> to somehow immediately trigger timeout work? I can't see how that could

It may be difficult to trigger in reality, but won't be impossible
since the timeout value can be adjusted via module parameter, and any
schedule delay can be introduced in one busy system.

It isn't a good practice to rely on timing for avoiding race, IMO.

> possibly happen in real life, but we can just remove it and use the existing
> nvme_start_ctrl to handle that in the LIVE state.

OK, please fix other issues mentioned in the following comment together,
then I will review further and see if it can work well.

https://marc.info/?l=linux-block&m=152668465710591&w=2

Thanks,
Ming
