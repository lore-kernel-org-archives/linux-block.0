Return-Path: <hare@suse.de>
Subject: Re: [PATCH 3/3] scsi: Ensure that scsi_run_queue() runs all hardware
 queues
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
 <20170331231205.16640-4-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <07c9fa1c-4623-3524-4360-6d699bc52a88@suse.de>
Date: Mon, 3 Apr 2017 08:12:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170331231205.16640-4-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/01/2017 01:12 AM, Bart Van Assche wrote:
> commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped
> queues") removed the blk_mq_stop_hw_queue() call from scsi_queue_rq()
> for the BLK_MQ_RQ_QUEUE_BUSY case. blk_mq_start_stopped_hw_queues()
> only runs queues that had been stopped. Hence change the
> blk_mq_start_stopped_hw_queues() call in scsi_run_queue() into
> blk_mq_run_hw_queues(). Remove the blk_mq_start_stopped_hw_queues()
> call from scsi_end_request() because __blk_mq_finish_request()
> already runs all hardware queues if needed.
> 
> Fixes: commit 52d7f1b5c2f3 ("blk-mq: Avoid that requeueing starts stopped queues")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/scsi/scsi_lib.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
