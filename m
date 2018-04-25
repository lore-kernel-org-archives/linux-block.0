Return-Path: <scott.bauer@intel.com>
Date: Wed, 25 Apr 2018 11:37:15 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH] cdrom: information leak in cdrom_ioctl_media_changed()
Message-ID: <20180425173711.ppikkczih54daplg@sbauer-Z170X-UD5>
References: <20180418095130.GA26904@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180418095130.GA26904@mwanda>
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 18, 2018 at 12:51:31PM +0300, Dan Carpenter wrote:
> This cast is wrong.  "cdi->capacity" is an int and "arg" is an unsigned
> long.  The way the check is written now, if one of the high 32 bits is
> set then we could read outside the info->slots[] array.
> 
> This bug is pretty old and it predates git.


There seems to be another one in this file too. We can send an arg that when type'd to int will be negative, or like the above bug the upper 32 bits will be cast-away.


diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index bfc566d3f31a..8cfa10ab7abc 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2542,7 +2542,7 @@ static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
        if (!CDROM_CAN(CDC_SELECT_DISC) ||
            (arg == CDSL_CURRENT || arg == CDSL_NONE))
                return cdi->ops->drive_status(cdi, CDSL_CURRENT);
-       if (((int)arg >= cdi->capacity))
+       if (arg >= cdi->capacity)
                return -EINVAL;
        return cdrom_slot_status(cdi, arg);
 }

I can submit a normal patch if there are no objections.
