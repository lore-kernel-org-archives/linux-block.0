Return-Path: <hare@suse.de>
Subject: Re: [PATCH v9 05/10] block: Introduce blk_get_request_flags()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20171016232905.5047-1-bart.vanassche@wdc.com>
 <20171016232905.5047-6-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fa39b2c1-bb46-4d43-0cf1-5b5e833dbccc@suse.de>
Date: Tue, 17 Oct 2017 08:26:06 +0200
MIME-Version: 1.0
In-Reply-To: <20171016232905.5047-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 01:29 AM, Bart Van Assche wrote:
> A side effect of this patch is that the GFP mask that is passed to
> several allocation functions in the legacy block layer is changed
> from GFP_KERNEL into __GFP_DIRECT_RECLAIM.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Tested-by: Martin Steigerwald <martin@lichtvoll.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c       | 50 +++++++++++++++++++++++++++++++++++---------------
>  include/linux/blkdev.h |  3 +++
>  2 files changed, 38 insertions(+), 15 deletions(-)
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
