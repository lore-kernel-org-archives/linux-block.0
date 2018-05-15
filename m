Return-Path: <ming.lei@redhat.com>
Date: Tue, 15 May 2018 08:33:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180515003332.GB21743@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514122211.GB807@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 14, 2018 at 08:22:11PM +0800, Ming Lei wrote:
> Hi Jianchao,
> 
> On Mon, May 14, 2018 at 06:05:50PM +0800, jianchao.wang wrote:
> > Hi ming
> > 
> > On 05/14/2018 05:38 PM, Ming Lei wrote:
> > >> Here is the deadlock scenario.
> > >>
> > >> nvme_eh_work // EH0
> > >>   -> nvme_reset_dev //hold reset_lock
> > >>     -> nvme_setup_io_queues
> > >>       -> nvme_create_io_queues
> > >>         -> nvme_create_queue
> > >>           -> set nvmeq->cq_vector
> > >>           -> adapter_alloc_cq
> > >>           -> adapter_alloc_sq
> > >>              irq has not been requested
> > >>              io timeout 
> > >>                                     nvme_eh_work //EH1
> > >>                                       -> nvme_dev_disable
> > >>                                         -> quiesce the adminq //----> here !
> > >>                                         -> nvme_suspend_queue
> > >>                                           print out warning Trying to free already-free IRQ 133
> > >>                                         -> nvme_cancel_request // complete the timeout admin request
> > >>                                       -> require reset_lock
> > >>           -> adapter_delete_cq
> > > If the admin IO submitted in adapter_alloc_sq() is timed out,
> > > nvme_dev_disable() in EH1 will complete it which is set as REQ_FAILFAST_DRIVER,
> > > then adapter_alloc_sq() should return error, and the whole reset in EH0
> > > should have been terminated immediately.
> > 
> > Please refer to the following segment:
> > 
> > static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> > {
> > 	struct nvme_dev *dev = nvmeq->dev;
> > 	int result;
> > ...
> > 	nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
> > 	result = adapter_alloc_cq(dev, qid, nvmeq);
> > 	if (result < 0)
> > 		goto release_vector;
> > 
> > 	result = adapter_alloc_sq(dev, qid, nvmeq);   // if timeout and failed here
> > 	if (result < 0)
> > 		goto release_cq;
> > 
> > 	nvme_init_queue(nvmeq, qid);
> > 	result = queue_request_irq(nvmeq);
> > 	if (result < 0)
> > 		goto release_sq;
> > 
> > 	return result;
> > 
> >  release_sq:
> > 	dev->online_queues--;
> > 	adapter_delete_sq(dev, qid);
> >  release_cq:                                        // we will be here !
> > 	adapter_delete_cq(dev, qid);                // another cq delete admin command will be sent out.
> >  release_vector:
> > 	nvmeq->cq_vector = -1;
> > 	return result;
> > }
> 
> Given admin queue has been suspended, all admin IO should have
> been terminated immediately, so could you test the following patch?
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f509d37b2fb8..44e38be259f2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1515,9 +1515,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>  	nvmeq->cq_vector = -1;
>  	spin_unlock_irq(&nvmeq->q_lock);
>  
> -	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
> -		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
> -
>  	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
>  
>  	return 0;
> @@ -1741,8 +1738,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>  			dev->ctrl.admin_q = NULL;
>  			return -ENODEV;
>  		}
> -	} else
> -		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
> +	}
>  
>  	return 0;
>  }

We still have to quiesce admin queue before canceling request, so looks
the following patch is better, so please ignore the above patch and try
the following one and see if your hang can be addressed:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f509d37b2fb8..c2adc76472a8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1741,8 +1741,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			dev->ctrl.admin_q = NULL;
 			return -ENODEV;
 		}
-	} else
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+	}
 
 	return 0;
 }
@@ -2520,6 +2519,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool
 	 */
 	if (shutdown)
 		nvme_start_queues(&dev->ctrl);
+
+	/*
+	 * Avoid to suck reset because timeout may happen during reset and
+	 * reset may hang forever if admin queue is kept as quiesced
+	 */
+	blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 	mutex_unlock(&dev->shutdown_lock);
 }
 

-- 
Ming
