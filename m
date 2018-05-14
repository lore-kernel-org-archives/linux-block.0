Return-Path: <ming.lei@redhat.com>
Date: Tue, 15 May 2018 07:47:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180514234701.GA21743@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511205028.GB7772@localhost.localdomain>
 <20180512002110.GA23631@ming.t460p>
 <20180514151821.GE7772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514151821.GE7772@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 14, 2018 at 09:18:21AM -0600, Keith Busch wrote:
> Hi Ming,
> 
> On Sat, May 12, 2018 at 08:21:22AM +0800, Ming Lei wrote:
> > > [  760.679960] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> > > [  760.701468] nvme nvme1: EH 0: after shutdown, top eh: 1
> > > [  760.727099] pci_raw_set_power_state: 62 callbacks suppressed
> > > [  760.727103] nvme 0000:86:00.0: Refused to change power state, currently in D3
> > 
> > EH may not cover this kind of failure, so it fails in the 1st try.
> 
> Indeed, the test is simulating a permanently broken link, so recovery is
> not expected. A success in this case is just completing driver
> unbinding.
>  
> > > [  760.727483] nvme nvme1: EH 0: state 4, eh_done -19, top eh 1
> > > [  760.727485] nvme nvme1: EH 0: after recovery -19
> > > [  760.727488] nvme nvme1: EH: fail controller
> > 
> > The above issue(hang in nvme_remove()) is still an old issue, which
> > is because queues are kept as quiesce during remove, so could you
> > please test the following change?
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1dec353388be..c78e5a0cde06 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3254,6 +3254,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >          */
> >         if (ctrl->state == NVME_CTRL_DEAD)
> >                 nvme_kill_queues(ctrl);
> > +       else {
> > +               if (ctrl->admin_q)
> > +                       blk_mq_unquiesce_queue(ctrl->admin_q);
> > +               nvme_start_queues(ctrl);
> > +       }
> > 
> >         down_write(&ctrl->namespaces_rwsem);
> >         list_splice_init(&ctrl->namespaces, &ns_list);
> 
> The above won't actually do anything here since the broken link puts the
> controller in the DEAD state, so we've killed the queues which also
> unquiesces them.

I suggest you to double check if the controller is set as DEAD
in nvme_remove() since there won't be any log dumped when this happen.

If controller is set as DEAD and queues are killed, and all IO should
have been dispatched to driver and nvme_queueu_rq() will fail them all,
then there isn't any reason to see the hang in your stack trace log.

> 
> > BTW, in my environment, it is hard to trigger this failure, so not see
> > this issue, but I did verify the nested EH which can recover from error
> > in reset.
> 
> It's actually pretty easy to trigger this one. I just modify block/019 to
> remove the check for a hotplug slot then run it on a block device that's
> not hot-pluggable.

I will try this test, and hope I can reproduce it in my environment.

Thanks,
Ming
