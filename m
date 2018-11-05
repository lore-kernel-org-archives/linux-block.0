Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKEUPJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Nov 2018 15:15:09 -0500
Date: Mon, 5 Nov 2018 18:55:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181105105548.GC12367@ming.t460p>
References: <20181105102301.9752-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181105102301.9752-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Nov 05, 2018 at 11:23:01AM +0100, Johannes Thumshirn wrote:
> With drivers like iSer we are seeing a lot of bio splitting and smaller I/Os
> being submitted to the driver.
> 
> The root cause of this issue that the virtual boundary mask code does not take
> into consideration that some of the memory segments in the SG list may have
> come from a huge memory page that is being managed in the SG list as 4K

I guess you mean something like 64K PAGE_SIZE, instead of huge page.

> blocks.  This means that many of the segments in the SG list will have an
> offset into the page that is not 0 but will be a multiple of 4K.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-merge.c | 2 +-
>  block/blk.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 6b5ad275ed56..208658a901c6 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -46,7 +46,7 @@ static inline bool bio_will_gap(struct request_queue *q,
>  		bio_get_first_bvec(prev_rq->bio, &pb);
>  	else
>  		bio_get_first_bvec(prev, &pb);
> -	if (pb.bv_offset)
> +	if (pb.bv_offset & queue_virt_boundary(q))
>  		return true;

The change should only make difference in case that PAGE_SIZE is bigger
than 4K. If yes, please add the description in commit log.


Thanks,
Ming
