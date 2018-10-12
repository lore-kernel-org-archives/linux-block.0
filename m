Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 04/11] block: Introduce blkdev_nr_zones() helper
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-5-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <88ebc7eb-f5f8-6966-7820-3c1a5b36b72c@suse.de>
Date: Fri, 12 Oct 2018 09:36:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> Introduce the blkdev_nr_zones() helper function to get the total
> number of zones of a zoned block device. This number is always 0 for a
> regular block device (q->limits.zoned == BLK_ZONED_NONE case).
> 
> Replace hard-coded number of zones calculation in dmz_get_zoned_device()
> with a call to this helper.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c            | 27 +++++++++++++++++++++++++++
>   drivers/md/dm-zoned-target.c |  3 +--
>   include/linux/blkdev.h       |  5 +++++
>   3 files changed, 33 insertions(+), 2 deletions(-)
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
