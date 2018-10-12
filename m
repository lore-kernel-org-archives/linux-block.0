Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 07/11] block: Introduce BLKGETNRZONES ioctl
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-8-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e55350a5-a5aa-2b7d-7d68-89ce221dc874@suse.de>
Date: Fri, 12 Oct 2018 09:37:52 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-8-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> Get a zoned block device total number of zones. The device can be a
> partition of the whole device. The number of zones is always 0 for
> regular block devices.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/ioctl.c                 | 2 ++
>   include/uapi/linux/blkzoned.h | 1 +
>   2 files changed, 3 insertions(+)
> 
And that's us, trying to get rid of ioctls ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
