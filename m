Return-Path: <BATV+1815987b1c14acf14571+4678+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 14 Jun 2016 07:32:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: 'Sagi Grimberg' <sagi@lightbits.io>, 'Christoph Hellwig' <hch@lst.de>,
	axboe@kernel.dk, keith.busch@intel.com,
	'Ming Lin' <ming.l@ssi.samsung.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	'Jay Freyensee' <james.p.freyensee@intel.com>,
	'Armen Baloyan' <armenx.baloyan@intel.com>
Subject: Re: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target
 driver
Message-ID: <20160614143248.GB17800@infradead.org>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <051801d1c297$c7d8a7d0$5789f770$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <051801d1c297$c7d8a7d0$5789f770$@opengridcomputing.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 09, 2016 at 04:42:11PM -0500, Steve Wise wrote:
> 
> <snip>
> 
> > > +
> > > +static struct nvmet_rdma_queue *
> > > +nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
> > > +		struct rdma_cm_id *cm_id,
> > > +		struct rdma_cm_event *event)
> > > +{
> > > +	struct nvmet_rdma_queue *queue;
> > > +	int ret;
> > > +
> > > +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> > > +	if (!queue) {
> > > +		ret = NVME_RDMA_CM_NO_RSC;
> > > +		goto out_reject;
> > > +	}
> > > +
> > > +	ret = nvmet_sq_init(&queue->nvme_sq);
> > > +	if (ret)
> > > +		goto out_free_queue;
> > > +
> > > +	ret = nvmet_rdma_parse_cm_connect_req(&event->param.conn,
> > queue);
> > > +	if (ret)
> > > +		goto out_destroy_sq;
> > > +
> > > +	/*
> > > +	 * Schedules the actual release because calling rdma_destroy_id from
> > > +	 * inside a CM callback would trigger a deadlock. (great API
> design..)
> > > +	 */
> > > +	INIT_WORK(&queue->release_work,
> > nvmet_rdma_release_queue_work);
> > > +	queue->dev = ndev;
> > > +	queue->cm_id = cm_id;
> > > +
> > > +	spin_lock_init(&queue->state_lock);
> > > +	queue->state = NVMET_RDMA_Q_CONNECTING;
> > > +	INIT_LIST_HEAD(&queue->rsp_wait_list);
> > > +	INIT_LIST_HEAD(&queue->rsp_wr_wait_list);
> > > +	spin_lock_init(&queue->rsp_wr_wait_lock);
> > > +	INIT_LIST_HEAD(&queue->free_rsps);
> > > +	spin_lock_init(&queue->rsps_lock);
> > > +
> > > +	queue->idx = ida_simple_get(&nvmet_rdma_queue_ida, 0, 0,
> > GFP_KERNEL);
> > > +	if (queue->idx < 0) {
> > > +		ret = NVME_RDMA_CM_NO_RSC;
> > > +		goto out_free_queue;
> > > +	}
> > > +
> > > +	ret = nvmet_rdma_alloc_rsps(queue);
> > > +	if (ret) {
> > > +		ret = NVME_RDMA_CM_NO_RSC;
> > > +		goto out_ida_remove;
> > > +	}
> > > +
> > > +	if (!ndev->srq) {
> > > +		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
> > > +				queue->recv_queue_size,
> > > +				!queue->host_qid);
> > > +		if (IS_ERR(queue->cmds)) {
> > > +			ret = NVME_RDMA_CM_NO_RSC;
> > > +			goto out_free_cmds;
> > > +		}
> > > +	}
> > > +
> 
> Should the above error path actually goto a block that frees the rsps?  Like
> this?

Yes, this looks good.  Thanks a lot, I'll include it in when reposting.
