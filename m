Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 10/11] block: add a report_zones method
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-11-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ab0dba55-8169-b9d0-5e1c-54dc210c57b9@suse.de>
Date: Fri, 12 Oct 2018 09:42:58 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-11-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Dispatching a report zones command through the request queue is a major
> pain due to the command reply payload rewriting necessary. Given that
> blkdev_report_zones() is executing everything synchronously, implement
> report zones as a block device file operation instead, allowing major
> simplification of the code in many places.
> 
> sd, null-blk, dm-linear and dm-flakey being the only block device
> drivers supporting exposing zoned block devices, these drivers are
> modified to provide the device side implementation of the
> report_zones() block device file operation.
> 
> For device mappers, a new report_zones() target type operation is
> defined so that the upper block layer calls blkdev_report_zones() can
> be propagated down to the underlying devices of the dm targets.
> Implementation for this new operation is added to the dm-linear and
> dm-flakey targets.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [Damien]
> * Changed method block_device argument to gendisk
> * Various bug fixes and improvements
> * Added support for null_blk, dm-linear and dm-flakey.
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/blk-core.c               |   1 -
>   block/blk-mq-debugfs.c         |   1 -
>   block/blk-zoned.c              | 164 ++++++++++----------------------
>   drivers/block/null_blk.h       |  11 ++-
>   drivers/block/null_blk_main.c  |  23 +----
>   drivers/block/null_blk_zoned.c |  57 +++--------
>   drivers/md/dm-flakey.c         |  30 ++++--
>   drivers/md/dm-linear.c         |  35 ++++---
>   drivers/md/dm.c                | 169 ++++++++++++++++-----------------
>   drivers/scsi/sd.c              |  13 +--
>   drivers/scsi/sd.h              |  11 +--
>   drivers/scsi/sd_zbc.c          | 153 +++++++++--------------------
>   include/linux/blk_types.h      |   2 -
>   include/linux/blkdev.h         |   8 +-
>   include/linux/device-mapper.h  |  12 ++-
>   include/trace/events/f2fs.h    |   1 -
>   16 files changed, 266 insertions(+), 425 deletions(-)
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
