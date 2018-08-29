Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 29 Aug 2018 15:48:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Scott Bauer <scott.bauer@intel.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <sbauer@plzdonthack.me>, stable@vger.kernel.org
Subject: Re: [PATCH] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
Message-ID: <20180829124842.plpsjdvausmtikhj@mwanda>
References: <20180426175108.29280-1-scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180426175108.29280-1-scott.bauer@intel.com>
List-ID: <linux-block@vger.kernel.org>

Sorry, I responded to this patch that this wasn't a real bug, but then
Scott corrected me that it was.

Anyway, it is a bug and we haven't applied this patch yet.

regards,
dan carpenter

On Thu, Apr 26, 2018 at 11:51:08AM -0600, Scott Bauer wrote:
> Like d88b6d04: "cdrom: information leak in cdrom_ioctl_media_changed()"
> 
> There is another cast from unsigned long to int which causes
> a bounds check to fail with specially crafted input. The value is
> then used as an index in the slot array in cdrom_slot_status().
> 
> Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> Signed-off-by: Scott Bauer <sbauer@plzdonthack.me>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cdrom/cdrom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index bfc566d3f31a..8cfa10ab7abc 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -2542,7 +2542,7 @@ static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
>  	if (!CDROM_CAN(CDC_SELECT_DISC) ||
>  	    (arg == CDSL_CURRENT || arg == CDSL_NONE))
>  		return cdi->ops->drive_status(cdi, CDSL_CURRENT);
> -	if (((int)arg >= cdi->capacity))
> +	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  	return cdrom_slot_status(cdi, arg);
>  }
> -- 
> 2.14.1
