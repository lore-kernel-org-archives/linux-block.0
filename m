Return-Path: <ming.lei@redhat.com>
Date: Fri, 19 May 2017 20:52:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
Message-ID: <20170519125244.GB22585@ming.t460p>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <20170518141307.GD28520@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518141307.GD28520@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 18, 2017 at 10:13:07AM -0400, Keith Busch wrote:
> On Wed, May 17, 2017 at 09:27:28AM +0800, Ming Lei wrote:
> > When one NVMe PCI device is being resetted and found reset failue,
> > nvme_remove_dead_ctrl() is called to handle the failure: blk-mq hw queues
> > are put into stopped first, then schedule .remove_work to release the driver.
> > 
> > Unfortunately if the driver is being released via sysfs store
> > just before the .remove_work is run, del_gendisk() from
> > nvme_remove() may hang forever because hw queues are stopped and
> > the submitted writeback IOs from fsync_bdev() can't be completed at all.
> > 
> > This patch fixes the following issue[1][2] by moving nvme_kill_queues()
> > into nvme_remove_dead_ctrl() to avoid the issue because nvme_remove()
> > flushs .reset_work, and this way is reasonable and safe because
> > nvme_dev_disable() has started to suspend queues and canceled requests
> > already.
> 
> I'm still not sure moving where we kill the queues is the correct way
> to fix this problem. The nvme_kill_queues restarts all the hardware
> queues to force all IO to failure already, so why is this really stuck?

That is a good question.

Today I investigate further, and figured out that it is because that
blk_mq_start_stopped_hw_queues() in nvme_kill_queues() does not
run hw queues actually becasue the queues are started in
nvme_reset_work() already. Will figure out a patch later to fix the
issue.

And the reason why this patch 'fixes' the issue is that just timing,
I guess.

> We should be able to make forward progress even if we kill the queues
> while calling into del_gendisk, right? That could happen with a different
> sequence of events, so that also needs to work.

Now I am not a big fun of this patch for fixing the issue.

But I still think it may be better to move nvme_kill_queues() into
nvme_remove_dead_ctrl() as an improvement because during this small
window page cache can be used up by write application, and no writeback
can move on meantime.

Thanks,
Ming
