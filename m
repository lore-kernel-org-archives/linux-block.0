Return-Path: <hare@suse.de>
Subject: Re: [PATCH 08/12] ide-floppy: Use blk_rq_is_scsi()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "David S . Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-9-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e9a0027d-84bd-f189-acf2-efb871ec6b55@suse.de>
Date: Fri, 18 Aug 2017 09:39:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-9-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ide/ide-floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 627b1f62a749..3ddd88219906 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -72,7 +72,7 @@ static int ide_floppy_callback(ide_drive_t *drive, int dsc)
>  		drive->failed_pc = NULL;
>  
>  	if (pc->c[0] == GPCMD_READ_10 || pc->c[0] == GPCMD_WRITE_10 ||
> -	    (req_op(rq) == REQ_OP_SCSI_IN || req_op(rq) == REQ_OP_SCSI_OUT))
> +	    blk_rq_is_scsi(rq))
>  		uptodate = 1; /* FIXME */
>  	else if (pc->c[0] == GPCMD_REQUEST_SENSE) {
>  
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
