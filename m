Return-Path: <hare@suse.de>
Subject: Re: [PATCH v3 08/11] block: Improve zone reset execution
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012023012.29923-1-damien.lemoal@wdc.com>
 <20181012023012.29923-9-damien.lemoal@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b16e29dc-ed3a-f267-54a4-8c3b065ccbce@suse.de>
Date: Fri, 12 Oct 2018 09:39:53 +0200
MIME-Version: 1.0
In-Reply-To: <20181012023012.29923-9-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:30 AM, Damien Le Moal wrote:
> There is no need to synchronously execute all REQ_OP_ZONE_RESET BIOs
> necessary to reset a range of zones. Similarly to what is done for
> discard BIOs in blk-lib.c, all zone reset BIOs can be chained and
> executed asynchronously and a synchronous call done only for the last
> BIO of the chain.
> 
> Modify blkdev_reset_zones() to operate similarly to
> blkdev_issue_discard() using the next_bio() helper for chaining BIOs. To
> avoid code duplication of that function in blk_zoned.c, rename
> next_bio() into blk_next_bio() and declare it as a block internal
> function in blk.h.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-lib.c   | 13 ++++++-------
>   block/blk-zoned.c | 29 ++++++++++++++++-------------
>   block/blk.h       |  2 ++
>   3 files changed, 24 insertions(+), 20 deletions(-)
> 
Neat.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
