Return-Path: <hare@suse.de>
Subject: Re: [PATCH v9 10/10] block, nvme: Introduce blk_mq_req_flags_t
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171016232905.5047-1-bart.vanassche@wdc.com>
 <20171016232905.5047-11-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56950f16-7c51-3e58-edd8-2cdf9049f686@suse.de>
Date: Tue, 17 Oct 2017 08:34:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171016232905.5047-11-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 01:29 AM, Bart Van Assche wrote:
> Several block layer and NVMe core functions accept a combination
> of BLK_MQ_REQ_* flags through the 'flags' argument but there is
> no verification at compile time whether the right type of block
> layer flags is passed. Make it possible for sparse to verify this.
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-nvme@lists.infradead.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c          | 12 ++++++------
>  block/blk-mq.c            |  4 ++--
>  block/blk-mq.h            |  2 +-
>  drivers/nvme/host/core.c  |  5 +++--
>  drivers/nvme/host/nvme.h  |  5 +++--
>  include/linux/blk-mq.h    | 17 +++++++++++------
>  include/linux/blk_types.h |  2 ++
>  include/linux/blkdev.h    |  4 ++--
>  8 files changed, 30 insertions(+), 21 deletions(-)
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
