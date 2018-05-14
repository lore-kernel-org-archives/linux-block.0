Return-Path: <ming.lei@redhat.com>
Date: Mon, 14 May 2018 20:22:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180514122211.GB807@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Hi Jianchao,

On Mon, May 14, 2018 at 06:05:50PM +0800, jianchao.wang wrote:
> Hi ming
> 
> On 05/14/2018 05:38 PM, Ming Lei wrote:
> >> Here is the deadlock scenario.
> >>
> >> nvme_eh_work // EH0
> >>   -> nvme_reset_dev //hold reset_lock
> >>     -> nvme_setup_io_queues
> >>       -> nvme_create_io_queues
> >>         -> nvme_create_queue
> >>           -> set nvmeq->cq_vector
> >>           -> adapter_alloc_cq
> >>           -> adapter_alloc_sq
> >>              irq has not been requested
> >>              io timeout 
> >>                                     nvme_eh_work //EH1
> >>                                       -> nvme_dev_disable
> >>                                         -> quiesce the adminq //----> here !
> >>                                         -> nvme_suspend_queue
> >>                                           print out warning Trying to free already-free IRQ 133
> >>                                         -> nvme_cancel_request // complete the timeout admin request
> >>                                       -> require reset_lock
> >>           -> adapter_delete_cq
> > If the admin IO submitted in adapter_alloc_sq() is timed out,
> > nvme_dev_disable() in EH1 will complete it which is set as REQ_FAILFAST_DRIVER,
> > then adapter_alloc_sq() should return error, and the whole reset in EH0
> > should have been terminated immediately.
> 
> Please refer to the following segment:
> 
> static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> {
> 	struct nvme_dev *dev = nvmeq->dev;
> 	int result;
> ...
> 	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
> 	result = adapter_alloc_cq(dev, qid, nvmeq);
> 	if (result < 0)
> 		goto release_vector;
> 
> 	result = adapter_alloc_sq(dev, qid, nvmeq);   // if timeout and failed here
> 	if (result < 0)
> 		goto release_cq;
> 
> 	nvme_init_queue(nvmeq, qid);
> 	result = queue_request_irq(nvmeq);
> 	if (result < 0)
> 		goto release_sq;
> 
> 	return result;
> 
>  release_sq:
> 	dev->online_queues--;
> 	adapter_delete_sq(dev, qid);
>  release_cq:                                        // we will be here !
> 	adapter_delete_cq(dev, qid);                // another cq delete admin command will be sent out.
>  release_vector:
> 	nvmeq->cq_vector = -1;
> 	return result;
> }

Given admin queue has been suspended, all admin IO should have
been terminated immediately, so could you test the following patch?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f509d37b2fb8..44e38be259f2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1515,9 +1515,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-
 	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
 	return 0;
@@ -1741,8 +1738,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->ctrl.admin_q = NULL;
 			return -ENODEV;
 		}
-	} else
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 
 	return 0;
 }

> 
> 
> > 
> > I guess the issue should be that nvme_create_io_queues() ignores the failure.
> > 
> > Could you dump the stack trace of EH0 reset task? So that we may see
> > where EH0 reset kthread hangs.
> 
> root@will-ThinkCentre-M910s:/home/will/Desktop# cat /proc/2273/stack 
> [<0>] blk_execute_rq+0xf7/0x150
> [<0>] __nvme_submit_sync_cmd+0x94/0x110
> [<0>] nvme_submit_sync_cmd+0x1b/0x20
> [<0>] adapter_delete_queue+0xad/0xf0
> [<0>] nvme_reset_dev+0x1b67/0x2450
> [<0>] nvme_eh_work+0x19c/0x4b0
> [<0>] process_one_work+0x3ca/0xaa0
> [<0>] worker_thread+0x89/0x6c0
> [<0>] kthread+0x18d/0x1e0
> [<0>] ret_from_fork+0x24/0x30
> [<0>] 0xffffffffffffffff

Even without this patch, the above hang can happen in reset context,
so this issue isn't related with the introduced 'reset_lock'.

> root@will-ThinkCentre-M910s:/home/will/Desktop# cat /proc/2275/stack 
> [<0>] nvme_eh_work+0x11a/0x4b0
> [<0>] process_one_work+0x3ca/0xaa0
> [<0>] worker_thread+0x89/0x6c0
> [<0>] kthread+0x18d/0x1e0
> [<0>] ret_from_fork+0x24/0x30
> [<0>] 0xffffffffffffffff
> 
> > 
> >>             -> adapter_delete_queue // submit to the adminq which has been quiesced.
> >>               -> nvme_submit_sync_cmd
> >>                 -> blk_execute_rq
> >>                   -> wait_for_completion_io_timeout
> >>                   hang_check is true, so there is no hung task warning for this context
> >>
> >> EH0 submit cq delete admin command, but it will never be completed or timed out, because the admin request queue has
> >> been quiesced, so the reset_lock cannot be released, and EH1 cannot get reset_lock and make things forward.
> > The nvme_dev_disable() in outer EH(EH1 in above log) will complete all
> > admin command, which won't be retried because it is set as
> > REQ_FAILFAST_DRIVER, so nvme_cancel_request() will complete it in
> > nvme_dev_disable().
> 
> This cq delete admin command is sent out after EH 1 nvme_dev_disable completed and failed the
> previous timeout sq alloc admin command. please refer to the code segment above.

Right, as I mentioned above, this admin command should have been failed
immediately.


Thanks,
Ming
