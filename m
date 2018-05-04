Return-Path: <ming.lei@redhat.com>
Date: Fri, 4 May 2018 12:24:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
Message-ID: <20180504042451.GA20791@ming.t460p>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 03, 2018 at 11:46:56PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Thanks for your kindly response.
> 
> On 05/03/2018 06:08 PM, Ming Lei wrote:
> > nvme_eh_reset() can move on, if controller state is either CONNECTING or
> > RESETTING, nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING) won't
> > be called in nvme_eh_reset(), and nvme_pre_reset_dev() will be called
> > directly, then follows scheduling of the eh_reset_work.
> 
> We have to consider another context, nvme_reset_work.
> There are two contexts that will invoke nvme_pre_reset_dev.
> nvme_eh_reset could invoke nvme_pre_reset_dev even if the state is RESETTING or CONNECTING.
> 
> nvme_error_handler                nvme_reset_ctrl
>                                     -> change state to RESETTING
>                                     -> queue reset work
>                                   nvme_reset_work          
>   -> nvme_dev_disable                                     
>   -> nvme_eh_reset
>     -> nvme_pre_reset_dev          -> nvme_pre_reset_dev
>       -> change state to CONNECTING   -> change state fails
>                                    -> nvme_remove_dead_ctrl
> There seems to be other race scenarios between them.

IMO it is fine to change the change state in nvme_pre_reset_dev()
as the following way:

if (dev->ctrl.state != NVME_CTRL_CONNECTING)
	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING))
		goto out;

Also dev->reset_lock has been introduced, and we may hold it for
nvme_pre_reset_dev() in the path of nvme_reset_ctrl() too, then
there isn't the above race any more.

> 
> Just invoke nvme_dev_disable in nvme_error_handler context and hand over the other things
> to nvme_reset_work as the v2 patch series seems clearer.

That way may not fix the current race: nvme_dev_disable() will
quiesce/freeze queue again when resetting is in-progress, then
nothing can move on.

One big change in V3 is to run nvme_dev_disable() & nvme_pre_reset_dev()
in the EH thread, and make sure queues are started once
nvme_pre_reset_dev() returns. But as you pointed, it may not work well
enough if admin requests are timed-out in nvme_pre_reset_dev().

> The primary target of nvme_error_handler is to drain IOs and disable controller.
> reset_work could take over the left things of the recovery work

Draining IOs isn't necessary, we can remove freezing queues & wait_freeze()
from nvme_dev_disable() & nvme_reset_work() for non-shutdown, that can be
easy to fix all these races since the .eh_reset_work isn't needed any more,
because quiescing is enough to prevent IOs from entering driver/device.

The only issue is that more requests may be failed when reset failed,
so I don't want to try that, and just follows the current behaviour.

IMO the primary goal of nvme EH is to recover controller, that is
what nvme_dev_disable() and resetting should do, if IO isn't drained,
timeout still may be triggered.

The big trouble is about percpu_ref, once the q_usage_counter is killed
to start freezing for preventing IO from entering block layer, we have
to run blk_mq_freeze_queue_wait() before unfreezing the usage couner. If
blk_mq_freeze_queue_wait() isn't needed, things can be much easier for us.

> 
> IMO, modify the nvme_reset_ctrl_sync in nvme_error_handler to nvme_reset_ctrl should be ok.
> If the admin ios in reset_work timeout, the nvme_error_handler could also provide help to complete them.
> 

Right, that is one goal of this patchset.

> > There are actually two issues here, both are covered in this patchset:
> > 
> > 1) when nvme_wait_freeze() is for draining IO, controller error may
> > happen again, this patch can shutdown & reset controller again to
> > recover it.
> >
> 
> We could split the nvme_reset_work into two contexts instead of introduce another nvme_eh_reset.
> Otherwise, the code looks really complicated.

Yeah, that is what I plan to do in V4, introduce .eh_pre_reset_work and
.eh_post_reset_work, and run the following things in .eh_pre_reset_work:

	- nvme_pre_reset_dev()
	- schedule .eh_post_reset_work

and run draining IO & updating controller state in .eh_post_reset_work.
.eh_pre_reset_work will be scheduled in nvme_error_handler().

This way may address the issue of admin req timeout in nvme_pre_reset_dev(),
what do you think of this approach?

Thanks,
Ming
