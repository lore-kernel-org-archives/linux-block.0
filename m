Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.opengridcomputing.com ([72.48.136.20]:35792 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752565AbcI0QbC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2016 12:31:02 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Bart Van Assche'" <bart.vanassche@sandisk.com>,
        "'Jens Axboe'" <axboe@fb.com>
Cc: <linux-block@vger.kernel.org>,
        "'James Bottomley'" <jejb@linux.vnet.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "'Keith Busch'" <keith.busch@intel.com>,
        "'Doug Ledford'" <dledford@redhat.com>,
        <linux-scsi@vger.kernel.org>, "'Christoph Hellwig'" <hch@lst.de>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com> <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>
In-Reply-To: <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>
Subject: RE: [PATCH 9/9] [RFC] nvme: Fix a race condition
Date: Tue, 27 Sep 2016 11:31:03 -0500
Message-ID: <013c01d218dc$8a5406c0$9efc1440$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> @@ -2079,11 +2075,15 @@ EXPORT_SYMBOL_GPL(nvme_kill_queues);
>  void nvme_stop_queues(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_ns *ns;
> +	struct request_queue *q;
> 
>  	mutex_lock(&ctrl->namespaces_mutex);
>  	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		blk_mq_cancel_requeue_work(ns->queue);
> -		blk_mq_stop_hw_queues(ns->queue);
> +		q = ns->queue;
> +		blk_quiesce_queue(q);
> +		blk_mq_cancel_requeue_work(q);
> +		blk_mq_stop_hw_queues(q);
> +		blk_resume_queue(q);
>  	}
>  	mutex_unlock(&ctrl->namespaces_mutex);

Hey Bart, should nvme_stop_queues() really be resuming the blk queue?



