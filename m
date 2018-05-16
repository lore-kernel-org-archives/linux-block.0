Return-Path: <ming.lei@redhat.com>
Date: Wed, 16 May 2018 10:09:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180516020903.GC17412@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <776f21e1-dc19-1b77-9ba4-44f0b8366625@oracle.com>
 <20180514093850.GA807@ming.t460p>
 <008cb38d-aa91-6ab7-64d9-417d6c53a1eb@oracle.com>
 <20180514122211.GB807@ming.t460p>
 <20180515003332.GB21743@ming.t460p>
 <d97b375f-9b47-6b95-bd5b-8166dae93676@oracle.com>
 <20180516020420.GB17412@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516020420.GB17412@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 16, 2018 at 10:04:20AM +0800, Ming Lei wrote:
> On Tue, May 15, 2018 at 05:56:14PM +0800, jianchao.wang wrote:
> > Hi ming
> > 
> > On 05/15/2018 08:33 AM, Ming Lei wrote:
> > > We still have to quiesce admin queue before canceling request, so looks
> > > the following patch is better, so please ignore the above patch and try
> > > the following one and see if your hang can be addressed:
> > > 
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index f509d37b2fb8..c2adc76472a8 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -1741,8 +1741,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
> > >  			dev->ctrl.admin_q = NULL;
> > >  			return -ENODEV;
> > >  		}
> > > -	} else
> > > -		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > @@ -2520,6 +2519,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool
> > >  	 */
> > >  	if (shutdown)
> > >  		nvme_start_queues(&dev->ctrl);
> > > +
> > > +	/*
> > > +	 * Avoid to suck reset because timeout may happen during reset and
> > > +	 * reset may hang forever if admin queue is kept as quiesced
> > > +	 */
> > > +	blk_mq_unquiesce_queue(dev->ctrl.admin_q);
> > >  	mutex_unlock(&dev->shutdown_lock);
> > >  }
> > 
> > w/ patch above and patch below, both the warning and io hung issue didn't reproduce till now.
> > 
> > 
> > @@ -1450,6 +1648,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> >  {
> >         struct nvme_dev *dev = nvmeq->dev;
> >         int result;
> > +       int cq_vector;
> >  
> >         if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> >                 unsigned offset = (qid - 1) * roundup(SQ_SIZE(nvmeq->q_depth),
> > @@ -1462,15 +1661,16 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> >          * A queue's vector matches the queue identifier unless the controller
> >          * has only one vector available.
> >          */
> > -       nvmeq->cq_vector = dev->num_vecs == 1 ? 0 : qid;
> > -       result = adapter_alloc_cq(dev, qid, nvmeq);
> > +       cq_vector = dev->num_vecs == 1 ? 0 : qid;
> > +       result = adapter_alloc_cq(dev, qid, nvmeq, cq_vector);
> >         if (result < 0)
> > -               goto release_vector;
> > +               goto out;
> 
> Think of this issue further, the above change will cause adapter_alloc_cq()
> failed immediately because nvmeq->cq_vector isn't set before submitting this
> admin IO.
> 
> So could you check if only the patch("unquiesce admin queue after shutdown
> controller") can fix your IO hang issue?
> 
> BTW, the warning from genirq can be left alone, that is another issue.

Ooops, no such issue at all since admin queue is ready, please ignore the
noise, sorry, :-(

Thanks,
Ming
