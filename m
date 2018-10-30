Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbeJ3P5B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Oct 2018 11:57:01 -0400
Subject: Re: [PATCH] xen-blkfront: fix kernel panic with negotiate_mq error
 path
To: Manjunath Patil <manjunath.b.patil@oracle.com>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc: axboe@kernel.dk, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <65b5d648-d9dc-9248-751c-b6e15109b52e@suse.com>
Date: Tue, 30 Oct 2018 08:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <1540837916-14356-1-git-send-email-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 29/10/2018 19:31, Manjunath Patil wrote:
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

Please us the correct format for specifying another commit.

> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>

Can you please add a "Fixes:" tag and "Cc: stable@vger.kernel.org" ?

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

I'd drop this change.

>  
>  	kfree(info->rinfo);
>  	info->rinfo = NULL;
> @@ -1919,6 +1921,7 @@ static int negotiate_mq(struct blkfront_info *info)
>  			      GFP_KERNEL);
>  	if (!info->rinfo) {
>  		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
> +		info->nr_rings = 0;
>  		return -ENOMEM;
>  	}


Juergen
