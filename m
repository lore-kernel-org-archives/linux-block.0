Return-Path: <ming.lei@redhat.com>
Date: Thu, 3 May 2018 18:08:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
Message-ID: <20180503100824.GA5078@ming.t460p>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 03, 2018 at 05:14:30PM +0800, jianchao.wang wrote:
> Hi ming
> 
> On 05/03/2018 11:17 AM, Ming Lei wrote:
> >  static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
> > @@ -1199,7 +1204,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  	if (nvme_should_reset(dev, csts)) {
> >  		nvme_warn_reset(dev, csts);
> >  		nvme_dev_disable(dev, false, true);
> > -		nvme_reset_ctrl(&dev->ctrl);
> > +		nvme_eh_reset(dev);
> >  		return BLK_EH_HANDLED;
> >  	}
> >  
> > @@ -1242,7 +1247,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >  			 "I/O %d QID %d timeout, reset controller\n",
> >  			 req->tag, nvmeq->qid);
> >  		nvme_dev_disable(dev, false, true);
> > -		nvme_reset_ctrl(&dev->ctrl);
> > +		nvme_eh_reset(dev);
> 
> w/o the 8th patch, invoke nvme_eh_reset in nvme_timeout is dangerous.
> nvme_pre_reset_dev will send a lot of admin io when initialize the controller.
> if this admin ios timeout, the nvme_timeout cannot handle this because the timeout work is sleeping
> to wait admin ios.

I just tried to not make the 8th patch too big, but looks we have to
merge the two.

Once the EH kthread is introduced in 8th patch, there isn't such issue any more.

> 
> In addition, even if we take the nvme_wait_freeze out of nvme_eh_reset and put it into another context,
> but the ctrl state is still CONNECTING, the nvme_eh_reset cannot move forward.

nvme_eh_reset() can move on, if controller state is either CONNECTING or
RESETTING, nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING) won't
be called in nvme_eh_reset(), and nvme_pre_reset_dev() will be called
directly, then follows scheduling of the eh_reset_work.

> 
> Actually, I used to report this issue to Keith. I met io hung when the controller die in
> nvme_reset_work -> nvme_wait_freeze. As you know, the nvme_reset_work cannot be scheduled because it is waiting.
> Here is Keith's commit for this:
> http://lists.infradead.org/pipermail/linux-nvme/2018-February/015603.html

There are actually two issues here, both are covered in this patchset:

1) when nvme_wait_freeze() is for draining IO, controller error may
happen again, this patch can shutdown & reset controller again to
recover it.

2) there is also another issue: queues may not be put into freeze state
in nvme_dev_disable(), then nvme_wait_freeze() will wait forever. This
issue is addressed by 4th patch.

Both two can be observed in blktests block/011 and verified by this patches.

Thanks for your great review, please let me know if there are other
issues.

Thanks,
Ming
