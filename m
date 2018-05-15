Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 14 May 2018 18:33:35 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180515003335.GB15199@localhost.localdomain>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511205028.GB7772@localhost.localdomain>
 <20180512002110.GA23631@ming.t460p>
 <20180514151821.GE7772@localhost.localdomain>
 <20180514234701.GA21743@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514234701.GA21743@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 15, 2018 at 07:47:07AM +0800, Ming Lei wrote:
> > > > [  760.727485] nvme nvme1: EH 0: after recovery -19
> > > > [  760.727488] nvme nvme1: EH: fail controller
> > > 
> > > The above issue(hang in nvme_remove()) is still an old issue, which
> > > is because queues are kept as quiesce during remove, so could you
> > > please test the following change?
> > > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 1dec353388be..c78e5a0cde06 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3254,6 +3254,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> > >          */
> > >         if (ctrl->state == NVME_CTRL_DEAD)
> > >                 nvme_kill_queues(ctrl);
> > > +       else {
> > > +               if (ctrl->admin_q)
> > > +                       blk_mq_unquiesce_queue(ctrl->admin_q);
> > > +               nvme_start_queues(ctrl);
> > > +       }
> > > 
> > >         down_write(&ctrl->namespaces_rwsem);
> > >         list_splice_init(&ctrl->namespaces, &ns_list);
> > 
> > The above won't actually do anything here since the broken link puts the
> > controller in the DEAD state, so we've killed the queues which also
> > unquiesces them.
> 
> I suggest you to double check if the controller is set as DEAD
> in nvme_remove() since there won't be any log dumped when this happen.

Yes, it's dead. pci_device_is_present returns false when the link is
broken.

Also, the logs showed the capacity was set to 0, which only happens when
we kill the namespace queues, which supposedly restarts the queues too.
 
> If controller is set as DEAD and queues are killed, and all IO should
> have been dispatched to driver and nvme_queueu_rq() will fail them all,
> then there isn't any reason to see the hang in your stack trace log.

Right, that's the idea. It just doesn't appear to be working here.
