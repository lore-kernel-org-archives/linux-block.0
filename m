Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 7/7] blk-zoned: implement ioctls
To: Damien Le Moal <damien.lemoal@hgst.com>, Jens Axboe <axboe@kernel.dk>
References: <1475208699-27310-1-git-send-email-damien.lemoal@hgst.com>
 <1475208699-27310-8-git-send-email-damien.lemoal@hgst.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Shaun Tancheff <shaun@tancheff.com>,
 Shaun Tancheff <shaun.tancheff@seagate.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c2d83405-faba-fe10-56a6-5298357ed492@suse.de>
Date: Fri, 30 Sep 2016 09:21:03 +0200
MIME-Version: 1.0
In-Reply-To: <1475208699-27310-8-git-send-email-damien.lemoal@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/30/2016 06:11 AM, Damien Le Moal wrote:
> From: Shaun Tancheff <shaun@tancheff.com>
>
> Adds the new BLKREPORTZONE and BLKRESETZONE ioctls for respectively
> obtaining the zone configuration of a zoned block device and resetting
> the write pointer of sequential zones of a zoned block device.
>
> The BLKREPORTZONE ioctl maps directly to a single call of the function
> blkdev_report_zones. The zone information result is passed as an array
> of struct blk_zone identical to the structure used internally for
> processing the REQ_OP_ZONE_REPORT operation.  The BLKRESETZONE ioctl
> maps to a single call of the blkdev_reset_zones function.
>
> Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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
