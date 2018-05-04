Return-Path: <ming.lei@redhat.com>
Date: Fri, 4 May 2018 17:16:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvme: pci: recover controller reliably
Message-ID: <20180504091630.GD20791@ming.t460p>
References: <20180503031716.31446-1-ming.lei@redhat.com>
 <20180503031716.31446-8-ming.lei@redhat.com>
 <32819b0a-acc8-fa76-5e58-8e75e2bc081b@oracle.com>
 <20180503100824.GA5078@ming.t460p>
 <ea98b607-9c8f-3b18-8314-cdcfd8bc5e96@oracle.com>
 <20180504042451.GA20791@ming.t460p>
 <2e6e88f9-089a-2809-0c2b-4e96ba1199e9@oracle.com>
 <20180504080223.GB20791@ming.t460p>
 <b7c597c0-7c0e-4a16-8f7c-ff3a6d6d17a6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7c597c0-7c0e-4a16-8f7c-ff3a6d6d17a6@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 04, 2018 at 04:28:23PM +0800, jianchao.wang wrote:
> Hi ming
> 
> On 05/04/2018 04:02 PM, Ming Lei wrote:
> >> nvme_error_handler should invoke nvme_reset_ctrl instead of introducing another interface.
> >> Then it is more convenient to ensure that there will be only one resetting instance running.
> >>
> > But as you mentioned above, reset_work has to be splitted into two
> > contexts for handling IO timeout during wait_freeze in reset_work,
> > so single instance of nvme_reset_ctrl() may not work well.
> 
> I mean the EH kthread and the reset_work which both could reset the ctrl instead of
> the pre and post rest context.

That may run nvme_pre_reset_dev() two times from both EH thread and
reset_work, looks not good.

> 
> Honestly, I suspect a bit that whether it is worthy to try to recover from [1].
> The Eh kthread solution could make things easier, but the codes for recovery from [1] has
> made code really complicated. It is more difficult to unify the nvme-pci, rdma and fc. 
IMO the model is not complicated(one EH thread with two-stage resetting), and
it may be cloned to rdma, fc, .. without much difficulty.

Follows the model:

1) single EH thread, in which controller should be guaranteed to
shutdown, and EH thread is waken up when controller needs to be
recovered.

2) 1st stage resetting: recover controller, which has to run in one
work context, since admin commands for recover may timeout.

3) 2nd stage resetting: draining IO & updating controller state to live,
which has to run in another context, since IOs during this stage may
timeout too.

The reset lock is used to sync between 1st stage resetting and 2nd
stage resetting. The '1st stage resetting' is scheduled from EH thread,
and the '2nd state resetting' is scheduled after the '1st stage
resetting' is done.

The implementation might not be so complicated too, since V3 has partitioned
reset_work into two parts, then what we just need to do in V4 is to
run each in one work from EH thread.

> How about just fail the resetting as the Keith's solution ?
> 
> [1] io timeout when nvme_reset_work or the new nvme_post_reset_dev invoke nvme_wait_freeze.
> 

I'd suggest to not change controller state as DELETING in this case,
otherwise it may be reported as another bug, in which controller becomes
completely unusable. This issue can be easily triggered by blktests
block/011, in this test case, controller is always recoverable.

I will post out V4, and see if all current issues can be covered, and
how complicated the implementation is.

Thanks
Ming
