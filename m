Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 5/6] cdrom: Check SCSI passthrough support before
 reading audio
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
 <20170531214350.31157-6-bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4a5ca74e-4cb2-d22d-e3ec-4f8936652404@suse.de>
Date: Thu, 1 Jun 2017 07:50:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170531214350.31157-6-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 05/31/2017 11:43 PM, Bart Van Assche wrote:
> The CDROMREADAUDIO ioctl uses SCSI passthrough when the .disk
> pointer has been set in struct cdrom_device_info. Hence check
> whether SCSI passthrough is supported before submitting a SCSI
> command. Note: both the ide-cd and sr drivers set the disk
> pointer in struct cdrom_device_info but neither the pcd nor
> the gdrom driver sets that pointer.
> 
> References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/cdrom/cdrom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 76c952fd9ab9..ff19cfc587f0 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -2178,6 +2178,12 @@ static int cdrom_read_cdda_bpc(struct cdrom_device_info *cdi, __u8 __user *ubuf,
>  	if (!q)
>  		return -ENXIO;
>  
> +	if (!blk_queue_scsi_passthrough(q)) {
> +		WARN_ONCE(true,
> +			  "Attempt read CDDA info through a non-SCSI queue\n");
> +		return -EINVAL;
> +	}
> +
>  	cdi->last_sense = 0;
>  
>  	while (nframes) {
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
