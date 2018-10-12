Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbeJLPQH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Oct 2018 11:16:07 -0400
Subject: Re: [PATCH v3 11/11] block: Introduce blk_revalidate_disk_zones()
To: Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-12-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <783a4852-f390-c989-17eb-6cb54cc3348a@suse.de>
Date: Fri, 12 Oct 2018 09:44:56 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-12-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> Drivers exposing zoned block devices have to initialize and maintain
> correctness (i.e. revalidate) of the device zone bitmaps attached to
> the device request queue (seq_zones_bitmap and seq_zones_wlock).
> 
> To simplify coding this, introduce a generic helper function
> blk_revalidate_disk_zones() suitable for most (and likely all) cases.
> This new function always update the seq_zones_bitmap and seq_zones_wlock
> bitmaps as well as the queue nr_zones field when called for a disk
> using a request based queue. For a disk using a BIO based queue, only
> the number of zones is updated since these queues do not have
> schedulers and so do not need the zone bitmaps.
> 
> With this change, the zone bitmap initialization code in sd_zbc.c can be
> replaced with a call to this function in sd_zbc_read_zones(), which is
> called from the disk revalidate block operation method.
> 
> A call to blk_revalidate_disk_zones() is also added to the null_blk
> driver for devices created with the zoned mode enabled.
> 
> Finally, to ensure that zoned devices created with dm-linear or
> dm-flakey expose the correct number of zones through sysfs, a call to
> blk_revalidate_disk_zones() is added to dm_table_set_restrictions().
> 
> The zone bitmaps allocated and initialized with
> blk_revalidate_disk_zones() are freed automatically from
> __blk_release_queue() using the block internal function
> blk_queue_free_zone_bitmaps().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/blk-sysfs.c             |   2 +
>   block/blk-zoned.c             | 136 +++++++++++++++++++++
>   block/blk.h                   |   6 +
>   drivers/block/null_blk_main.c |   7 ++
>   drivers/md/dm-table.c         |  10 ++
>   drivers/scsi/sd.c             |   2 -
>   drivers/scsi/sd.h             |   4 -
>   drivers/scsi/sd_zbc.c         | 218 ++++------------------------------
>   include/linux/blkdev.h        |   7 ++
>   9 files changed, 194 insertions(+), 198 deletions(-)
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
