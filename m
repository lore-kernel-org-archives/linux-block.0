Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-cgroup: use __GFP_NOWARN for NOWAIT allocations
To: Jens Axboe <axboe@kernel.dk>
References: <1477395872-33696-1-git-send-email-borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 16 Nov 2016 12:00:36 +0100
MIME-Version: 1.0
In-Reply-To: <1477395872-33696-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <fc429977-4168-f3ce-f500-39c6594e1534@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On 10/25/2016 01:44 PM, Christian Borntraeger wrote:
> I just got

Ping?

> 
> qemu-system-s39: page allocation failure: order:0, mode:0x2200000(GFP_NOWAIT|__GFP_NOTRACK)
> CPU: 0 PID: 6664 Comm: qemu-system-s39 Tainted: G 4.9.0-rc2+ #44
> [...]
> ([<000000000011230a>] show_trace+0x62/0x78)
> ([<00000000001123da>] show_stack+0x72/0xf0)
> ([<00000000004a7906>] dump_stack+0x7e/0xb0)
> ([<000000000025df14>] warn_alloc+0x11c/0x148)
> ([<000000000025e48c>] __alloc_pages_nodemask+0x4c4/0xe50)
> ([<00000000002be590>] new_slab+0x560/0x778
> ([<00000000002c0adc>] ___slab_alloc.constprop.29+0x2b4/0x368)
> ([<00000000002c0bc4>] __slab_alloc.constprop.28+0x34/0x50)
> ([<00000000002c10aa>] kmem_cache_alloc_trace+0x20a/0x270)
> ([<0000000000257934>] mempool_create_node+0x5c/0x188)
> ([<00000000004745d6>] blk_init_rl+0xa6/0xe0)
> ([<0000000000493f58>] blkg_alloc+0x150/0x2a8)
> ([<0000000000494404>] blkg_create+0x354/0x3b0)
> ([<00000000004962c0>] blkg_lookup_create+0x100/0x180)
> ([<0000000000472cd4>] generic_make_request_checks+0x504/0x590)
> ([<0000000000474a66>] generic_make_request+0x2e/0x1b0)
> ([<0000000000474c8c>] submit_bio+0xa4/0x178)
> ([<000003ff80c64670>] btrfs_map_bio+0x1c0/0x3c8 [btrfs])
> ([<000003ff80c3075c>] btrfs_submit_bio_hook+0x104/0x210
> [...]
> 
> Seems that blk-cgroup can handle allocation failures quite will - it
> does check the result and the system continues to run, so let's make
> allocation failures silent in here.
> 
> There are other GFP_NOWAIT places in that file, but not all seem to
> check the return value. In addition this warning seems to be the only
> one that I can reliably reproduce so I decided to only touch
> blkg_create.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  block/blk-cgroup.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index b08ccbb..d22bd95 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -185,7 +185,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  	}
> 
>  	wb_congested = wb_congested_get_create(&q->backing_dev_info,
> -					       blkcg->css.id, GFP_NOWAIT);
> +					       blkcg->css.id,
> +					       GFP_NOWAIT | __GFP_NOWARN);
>  	if (!wb_congested) {
>  		ret = -ENOMEM;
>  		goto err_put_css;
> @@ -193,7 +194,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> 
>  	/* allocate */
>  	if (!new_blkg) {
> -		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT);
> +		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT | __GFP_NOWARN);
>  		if (unlikely(!new_blkg)) {
>  			ret = -ENOMEM;
>  			goto err_put_congested;
> 
