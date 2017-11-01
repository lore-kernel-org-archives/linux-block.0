Return-Path: <hare@suse.de>
Subject: Re: [PATCH] block: Rework drivers/cdrom/Makefile
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20171030160219.13019-1-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fa1e4397-46d4-3c29-1839-e27d68d6dacb@suse.de>
Date: Wed, 1 Nov 2017 12:07:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171030160219.13019-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/2017 05:02 PM, Bart Van Assche wrote:
> Instead of referring from inside drivers/cdrom/Makefile to all the
> drivers that use this driver, let these drivers select the cdrom
> driver. This change makes the cdrom build code follow the approach
> that is used for most other drivers, namely refer from the higher
> layers to the lower layer instead of from the lower layer to the
> higher layers.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/block/Kconfig        | 12 ++++++++++++
>  drivers/block/paride/Kconfig |  1 +
>  drivers/cdrom/Makefile       | 15 ++-------------
>  drivers/ide/Kconfig          |  1 +
>  drivers/scsi/Kconfig         |  1 +
>  5 files changed, 17 insertions(+), 13 deletions(-)
> 
You seem to have too much spare time ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
