Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/3] scsi: Add scsi_restart_queues()
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
 <20170331231205.16640-3-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4534bda9-5c0f-2121-d996-ac55d09e90cb@suse.de>
Date: Mon, 3 Apr 2017 08:10:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170331231205.16640-3-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/01/2017 01:12 AM, Bart Van Assche wrote:
> This patch avoids that if multiple SCSI devices are associated with
> a SCSI host that a queue can get stuck if scsi_queue_rq() returns
> "busy".
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/scsi_lib.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
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
