Return-Path: <prvs=8342f37c0=roger.pau@citrix.com>
Date: Tue, 30 Oct 2018 11:39:56 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Manjunath Patil <manjunath.b.patil@oracle.com>
CC: <boris.ostrovsky@oracle.com>, <jgross@suse.com>, <konrad.wilk@oracle.com>,
	<axboe@kernel.dk>, <xen-devel@lists.xenproject.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkfront: fix kernel panic with negotiate_mq error
 path
Message-ID: <20181030103956.hew7gifjvpjviw7u@mac.citrite.net>
References: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
Return-Path: roger.pau@citrix.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 29, 2018 at 11:31:56AM -0700, Manjunath Patil wrote:
> info->nr_rings isn't adjusted in case of ENOMEM error from
> negotiate_mq(). This leads to kernel panic in error path.
> 
> Typical call stack involving panic -
>  #8 page_fault at ffffffff8175936f
>     [exception RIP: blkif_free_ring+33]
>     RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
>  ...
>  #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
>  #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
>  #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
>  #12 xenbus_otherend_changed at ffffffff81424670
>  #13 backend_changed at ffffffff81426dc3
>  #14 xenwatch_thread at ffffffff81422f29
>  #15 kthread at ffffffff810abe6a
>  #16 ret_from_fork at ffffffff81754078
> 
> Though either of my changes avoid the panic, I included both the
> changes. This issue got introduced with "7ed8ce1 xen-blkfront: move
> negotiate_mq to cover all cases of new VBDs"
> 
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
>  drivers/block/xen-blkfront.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 429d201..dc8fe25 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1350,8 +1350,10 @@ static void blkif_free(struct blkfront_info *info, int suspend)
>  	if (info->rq)
>  		blk_mq_stop_hw_queues(info->rq);
>  
> -	for (i = 0; i < info->nr_rings; i++)
> -		blkif_free_ring(&info->rinfo[i]);
> +	if (info->rinfo) {
> +		for (i = 0; i < info->nr_rings; i++)
> +			blkif_free_ring(&info->rinfo[i]);
> +	}

I don't see the point in the if case here, you already fixed it by
setting the nr_rings value which I think it's the correct way of
fixing it.

Thanks, Roger.
