Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 06/11] block: Introduce BLKGETZONESZ ioctl
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-7-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56b5e309-872d-d37e-89fc-5df15757c1a3@suse.de>
Date: Fri, 12 Oct 2018 09:37:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-7-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> Get a zoned block device zone size in number of 512 B sectors.
> The zone size is always 0 for regular block devices.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/ioctl.c                 | 2 ++
>   include/uapi/linux/blkzoned.h | 2 ++
>   2 files changed, 4 insertions(+)
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
