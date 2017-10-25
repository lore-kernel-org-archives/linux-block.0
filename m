Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Dann Frazier <dann.frazier@canonical.com>, stable@vger.kernel.org
References: <20171025095617.7315-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk>
Date: Wed, 25 Oct 2017 11:23:28 -0700
MIME-Version: 1.0
In-Reply-To: <20171025095617.7315-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 02:56 AM, Bart Van Assche wrote:
> Avoid that submitting an SG_IO ioctl triggers a kernel oops that
> is preceded by:
> 
> usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
> kernel BUG at mm/usercopy.c:72!

Seems I saw a note on a runtime oops triggered by this patch yesterday,
but now I can't seem to find it... Did you see it?

> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 4a438b8abe27..b0b2100763bf 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -450,6 +450,7 @@ config VIRTIO_BLK_SCSI
>  	bool "SCSI passthrough request for the Virtio block driver"
>  	depends on VIRTIO_BLK
>  	select BLK_SCSI_REQUEST
> +	select SCSI_MOD

Should this be SCSI? That's what libata does. It may be correct as-is,
didn't look too deeply, just curious why it's different.

-- 
Jens Axboe
