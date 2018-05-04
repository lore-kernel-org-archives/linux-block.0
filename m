Return-Path: <ming.lei@redhat.com>
Date: Fri, 4 May 2018 16:02:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
Message-ID: <20180504080223.GB20791@ming.t460p>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
 <20180504042451.GA20791@ming.t460p>
 <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 04, 2018 at 02:10:19PM +0800, jianchao.wang wrote:
> Hi ming
> 
> On 05/04/2018 12:24 PM, Ming Lei wrote:
> >> Just invoke nvme_dev_disable in nvme_error_handler context and hand over the other things
> >> to nvme_reset_work as the v2 patch series seems clearer.
> > That way may not fix the current race: nvme_dev_disable() will
> > quiesce/freeze queue again when resetting is in-progress, then
> > nothing can move on.
> 
> With timeout quiesce and nvme EH kthread, the nvme_dev_disable could ensure all the in-flight
> requests to be handled. When we queue the reset_work in nvme_error_handler, there will be no
> timeout anymore.

Right.

> If there is timeout due to the admin io in reset_work, this is expected, reset_work will be
> interrupted and fail.

At least with V3, the admin io submitted in reset_work won't be handled
well. When EH thread hangs in the sync admin io, nvme_eh_schedule()
can't wakeup the EH thread any more, then the admin io may hang forever
in reset_work. Then we have to run nvme_pre_reset_dev() in another
context.

> If the io timeout when reset_work wait freeze, because the reset_work is waiting, things cannot
> move on. we have multiple method to handle this:
> 1. as Keith's solution, change ctrl state to DELETING and fail the reset_work.
> 2. as current patch set, try to recovery it. but we have to split reset_work into two contexts.
>

Right, nvme_dev_disable() can guarantee forward progress, and we have to
make sure that nvme_dev_disable() is called when timeout happens.

> Actually, there are many other places where the nvme_dev_disable will be invoked.   
> > 
> > One big change in V3 is to run nvme_dev_disable() & nvme_pre_reset_dev()
> > in the EH thread, and make sure queues are started once
> > nvme_pre_reset_dev() returns. But as you pointed, it may not work well
> > enough if admin requests are timed-out in nvme_pre_reset_dev().
> > 
> >> The primary target of nvme_error_handler is to drain IOs and disable controller.
> >> reset_work could take over the left things of the recovery work
> > Draining IOs isn't necessary, we can remove freezing queues & wait_freeze()
> > from nvme_dev_disable() & nvme_reset_work() for non-shutdown, that can be
> > easy to fix all these races since the .eh_reset_work isn't needed any more,
> > because quiescing is enough to prevent IOs from entering driver/device.
> > 
> > The only issue is that more requests may be failed when reset failed,
> > so I don't want to try that, and just follows the current behaviour.
> > 
> > IMO the primary goal of nvme EH is to recover controller, that is
> > what nvme_dev_disable() and resetting should do, if IO isn't drained,
> > timeout still may be triggered.
> > 
> > The big trouble is about percpu_ref, once the q_usage_counter is killed
> > to start freezing for preventing IO from entering block layer, we have
> > to run blk_mq_freeze_queue_wait() before unfreezing the usage couner. If
> > blk_mq_freeze_queue_wait() isn't needed, things can be much easier for us.
> 
> 
> Sorry for my bad description. I mean nvme_dev_disable will drain all the 
> in-flight requests and requeue or fail them, then we will not get any timeout again.

OK, got it, sorry for misunderstanding your point.

> 
> In fact, I used to talk with Keith about remove freezing queues & wait_freeze for non-shutdown.
> There is an obstacle, nvme_dev_add -> blk_mq_update_nr_hw_queues.
> When the ctrl comes back, the number of hw queues maybe changed.
> Even if we move the wait_freeze, blk_mq_update_nr_hw_queues will do that.
> On the other hand, if not freeze the queue, the requests that are submitted to the dying hw queue 
> during the resetting, will be sacrificed.  

Right.

> 
> 
> > 
> >> IMO, modify the nvme_reset_ctrl_sync in nvme_error_handler to nvme_reset_ctrl should be ok.
> >> If the admin ios in reset_work timeout, the nvme_error_handler could also provide help to complete them.
> >>
> > Right, that is one goal of this patchset.
> > 
> >>> There are actually two issues here, both are covered in this patchset:
> >>>
> >>> 1) when nvme_wait_freeze() is for draining IO, controller error may
> >>> happen again, this patch can shutdown & reset controller again to
> >>> recover it.
> >>>
> >> We could split the nvme_reset_work into two contexts instead of introduce another nvme_eh_reset.
> >> Otherwise, the code looks really complicated.
> > Yeah, that is what I plan to do in V4, introduce .eh_pre_reset_work and
> > .eh_post_reset_work, and run the following things in .eh_pre_reset_work:
> > 
> > 	- nvme_pre_reset_dev()
> > 	- schedule .eh_post_reset_work
> > 
> > and run draining IO & updating controller state in .eh_post_reset_work.
> > .eh_pre_reset_work will be scheduled in nvme_error_handler().
> > 
> > This way may address the issue of admin req timeout in nvme_pre_reset_dev(),
> > what do you think of this approach?
> 
> nvme_error_handler should invoke nvme_reset_ctrl instead of introducing another interface.
> Then it is more convenient to ensure that there will be only one resetting instance running.
> 

But as you mentioned above, reset_work has to be splitted into two
contexts for handling IO timeout during wait_freeze in reset_work,
so single instance of nvme_reset_ctrl() may not work well.


Thanks,
Ming
