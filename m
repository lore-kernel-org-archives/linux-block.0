Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38433 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbeF3BkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 21:40:14 -0400
Date: Fri, 29 Jun 2018 18:40:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH] scsi: fix scsi_host_queue_ready
Message-ID: <20180630014012.GA10966@roeck-us.net>
References: <20180630012724.24178-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180630012724.24178-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jun 30, 2018 at 09:27:24AM +0800, Ming Lei wrote:
> 328728630d9f2bf1 ("scsi: avoid to hold host-wide counter of host_busy
> for scsi_mq") adds one extra check on scsi_host_busy(shost) in
> scsi_host_queue_ready(), which is wrong and not necessary, can causes
> booting stall on LSI53c895A.
> 
> So remove the check.
> 
> Cc: Omar Sandoval <osandov@fb.com>,
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 328728630d9f2bf1 ("scsi: avoid to hold host-wide counter of host_busy for scsi_mq")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 1c79c86184b1..cc97818cb29c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1561,7 +1561,7 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
>  	else
>  		busy = 0;
>  	if (atomic_read(&shost->host_blocked) > 0) {
> -		if (busy || scsi_host_busy(shost))
> +		if (busy)
>  			goto starved;
>  
>  		/*
> -- 
> 2.9.5
> 
