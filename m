Return-Path: <linux-block-owner@vger.kernel.org>
Received: from vps-vb.mhejs.net ([37.28.154.113]:51162 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdL3Vl0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Dec 2017 16:41:26 -0500
Subject: Re: [v2,4/6] pktcdvd: Check queue type before attaching to a queue
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
References: <20170531214350.31157-5-bart.vanassche@sandisk.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <d237f623-ce22-6360-306f-3460ddba25ef@maciej.szmigiero.name>
Date: Sat, 30 Dec 2017 22:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170531214350.31157-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 31.05.2017 23:43, Bart Van Assche wrote:
> Since the pktcdvd driver only supports request queues for which
> struct scsi_request is the first member of their private request
> data, refuse to register block layer queues for which struct
> scsi_request is not the first member of the private data.
> 
> References: commit 82ed4db499b8 ("block: split scsi_request out of struct request")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/pktcdvd.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index 205b865ebeb9..42e3c880a8a5 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -2583,6 +2583,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  	bdev = bdget(dev);
>  	if (!bdev)
>  		return -ENOMEM;
> +	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
> +		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
> +		bdput(bdev);
> +		return -EINVAL;
> +	}
>  	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
>  	if (ret)
>  		return ret;
> 

This commit causes a NULL pointer dereference when adding a pktcdvd
mapping.

Reproducing it is simple:
# pktsetup 1 /dev/cdrom 

Specifically, the NULL dereference happens inside bdev_get_queue(bdev),
which is supposed to return bdev->bd_disk->queue, but in this case
bdev->bd_disk is NULL.

If I revert this commit the mapping is added correctly (tested on 4.14.10,
but there haven't been any changes to pktcdvd.c and bdev_get_queue() in
4.15-rc5).

Maciej
