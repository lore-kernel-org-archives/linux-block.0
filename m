Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1762088AbdEXGCc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2017 02:02:32 -0400
Subject: Re: [PATCH 14/31] cdrom: Check private request size before attaching
 to a queue
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.com>
References: <20170524003420.5381-1-bart.vanassche@sandisk.com>
 <20170524003420.5381-15-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bc522b30-a9b1-29b6-f063-2e12741096b1@suse.de>
Date: Wed, 24 May 2017 08:02:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170524003420.5381-15-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/24/2017 02:34 AM, Bart Van Assche wrote:
> Since the cdrom driver only supports request queues for which
> struct scsi_request is the first member of their private request
> data, refuse to register block layer queues for which this is
> not the case.
> 
> References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/cdrom/cdrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 76c952fd9ab9..070568d496dc 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -594,6 +594,10 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  
>  	if (cdo->open == NULL || cdo->release == NULL)
>  		return -EINVAL;
> +	if (!blk_queue_scsi_sup(cdi->disk->queue)) {
> +		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
> +		return -EINVAL;
> +	}
>  	if (!banner_printed) {
>  		pr_info("Uniform CD-ROM driver " REVISION "\n");
>  		banner_printed = 1;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
