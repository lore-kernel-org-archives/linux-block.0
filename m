Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 19 Oct 2016 15:23:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3 04/11] blk-mq: Introduce blk_mq_quiesce_queue()
Message-ID: <20161019132321.GD6323@lst.de>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
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

> +/**
> + * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
> + *
> + * Note: this function does not prevent that the struct request end_io()
> + * callback function is invoked. Additionally, it is not prevented that
> + * new queue_rq() calls occur unless the queue has been stopped first.
> + */
> +void blk_mq_quiesce_queue(struct request_queue *q)

If this is intended to be a kerneldoc comment you need to document the 'q'
parameter.  If not you should drop the magic "/**" marker.

> +static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> +{
> +	int srcu_idx;
> +
> +	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> +		cpu_online(hctx->next_cpu));
> +
> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> +		rcu_read_lock();
> +		blk_mq_process_rq_list(hctx);
> +		rcu_read_unlock();
> +	} else {
> +		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> +		blk_mq_process_rq_list(hctx);
> +		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> +	}
> +}

Can you document these synchronization changes in detail in the changelog?

> +static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +				      struct request *rq, blk_qc_t *cookie)
> +{
> +	if (blk_mq_hctx_stopped(hctx) ||
> +	    blk_mq_direct_issue_request(rq, cookie) != 0)
> +		blk_mq_insert_request(rq, false, true, true);
> +}

Any reason not to merge this function with blk_mq_direct_issue_request?

Otherwise this change looks fine to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
