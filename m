Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 19 Oct 2016 15:28:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3 06/11] dm: Use BLK_MQ_S_STOPPED instead of
 QUEUE_FLAG_STOPPED in blk-mq code
Message-ID: <20161019132804.GF6323@lst.de>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e5facfd0-82d5-10cb-712b-13d7950b78b8@sandisk.com>
MIME-Version: 1.0
In-Reply-To: <e5facfd0-82d5-10cb-712b-13d7950b78b8@sandisk.com>
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

This looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Tue, Oct 18, 2016 at 02:51:33PM -0700, Bart Van Assche wrote:
>  static void dm_mq_start_queue(struct request_queue *q)
>  {
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(q->queue_lock, flags);
> -	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
> -	spin_unlock_irqrestore(q->queue_lock, flags);
> -
>  	blk_mq_start_stopped_hw_queues(q, true);
>  	blk_mq_kick_requeue_list(q);

FYI, I'm tempted to say we should always call blk_mq_kick_requeue_list
from blk_mq_start_stopped_hw_queues, but that's a separate issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
