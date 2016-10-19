Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 19 Oct 2016 15:41:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3 11/11] nvme: Fix a race condition
Message-ID: <20161019134131.GD6809@lst.de>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <2a29b7ec-0113-3450-9a36-b925b47b1fb0@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <2a29b7ec-0113-3450-9a36-b925b47b1fb0@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Ming Lin <ming.l@ssi.samsung.com>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Doug Ledford <dledford@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

this looks great!

Reviewed-by: Christoph Hellwig <hch@lst.de>

Some minor nitpicks below:

>  void nvme_requeue_req(struct request *req)
>  {
> +	blk_mq_requeue_request(req, true);
>  }
>  EXPORT_SYMBOL_GPL(nvme_requeue_req);

Please just remove the nvme_requeue_req wrapper.

>  
> @@ -2074,11 +2068,14 @@ EXPORT_SYMBOL_GPL(nvme_kill_queues);
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> +	struct request_queue *q;
>  
>  	mutex_lock(&ctrl->namespaces_mutex);
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		q = ns->queue;
> +		blk_mq_cancel_requeue_work(q);
> +		blk_mq_stop_hw_queues(q);
> +		blk_mq_quiesce_queue(q);
>  	}

I'd keep the q declaration in the minimal scope, e.g.

	list_for_each_entry(ns, &ctrl->namespaces, list) {
		struct request_queue *q = ns->queue;

		blk_mq_cancel_requeue_work(q);
		blk_mq_stop_hw_queues(q);
		blk_mq_quiesce_queue(q);
	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
