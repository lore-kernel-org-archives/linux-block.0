Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 05/11] block: Limit allocation of zone descriptors for
 report zones
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-6-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <34452bd8-5649-4f7f-35f6-f370811dc68c@suse.de>
Date: Fri, 12 Oct 2018 09:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-6-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> There is no point in allocating more zone descriptors than the number of
> zones a block device has for doing a zone report. Avoid doing that in
> blkdev_report_zones_ioctl() by limiting the number of zone decriptors
> allocated internally to process the user request.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
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
