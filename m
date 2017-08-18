Return-Path: <hare@suse.de>
Subject: Re: [PATCH 04/12] blk-mq: Make blk_mq_reinit_tagset() calls easier to
 read
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-5-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <45129ead-5cd0-cf95-373a-458b41da3412@suse.de>
Date: Fri, 18 Aug 2017 09:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-5-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> Since blk_mq_ops.reinit_request is only called from inside
> blk_mq_reinit_tagset(), make this function pointer an argument of
> blk_mq_reinit_tagset() instead of a member of struct blk_mq_ops.
> This patch does not change any functionality but makes
> blk_mq_reinit_tagset() calls easier to read and to analyze.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq-tag.c       |  9 +++++----
>  drivers/nvme/host/fc.c   |  4 +---
>  drivers/nvme/host/rdma.c | 11 ++++++-----
>  include/linux/blk-mq.h   |  5 ++---
>  4 files changed, 14 insertions(+), 15 deletions(-)
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
