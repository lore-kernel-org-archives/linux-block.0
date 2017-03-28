Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34220 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbdC1DnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 23:43:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so15153245pga.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 20:43:11 -0700 (PDT)
Date: Tue, 28 Mar 2017 11:43:04 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] block: fix leak of q->rq_wb
Message-ID: <20170328033850.GB23217@ming.t460p>
References: <de751892a392533e8e26fffbf72ba7904cfda468.1490636543.git.osandov@fb.com>
 <d6f2baa4f64dce04da94a649d080acdaaf7d6b57.1490636543.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6f2baa4f64dce04da94a649d080acdaaf7d6b57.1490636543.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 10:43:59AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> CONFIG_DEBUG_TEST_DRIVER_REMOVE found a possible leak of q->rq_wb in a
> couple of cases: when a request queue is reregistered and when gendisks
> share a request_queue. This has been a problem since wbt was introduced,
> but the WARN_ON(!list_empty(&stats->callbacks)) in the blk-stat rework
> exposed it. The fix is unfortunately a hack until we fix all of the
> drivers sharing a request_queue.
> 
> Fixes: 87760e5eef35 ("block: hook up writeback throttling")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-sysfs.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index fa831cb2fc30..a187e3f70028 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -893,7 +893,21 @@ int blk_register_queue(struct gendisk *disk)
>  
>  	kobject_uevent(&q->kobj, KOBJ_ADD);
>  
> -	blk_wb_init(q);
> +	/*
> +	 * There are two cases where wbt may have already been initialized:
> +	 * 1. A call sequence of blk_register_queue(); blk_unregister_queue();
> +	 *    blk_register_queue().
> +	 * 2. Multiple gendisks sharing a request_queue.
> +	 *
> +	 * To fix case 1, we'd like to call wbt_exit() in
> +	 * blk_unregister_queue(). However, that's unsafe for case 2. So, we're
> +	 * forced to do this and call wbt_exit() in blk_release_queue() instead.
> +	 *
> +	 * Note that in case 2, wbt will account across disks until those legacy
> +	 * drivers are fixed.
> +	 */
> +	if (!q->rq_wb)
> +		blk_wb_init(q);

Since 'rq_wb' is per-queue and its life time is same with queue's, I
am wondering why blk_wb_init() isn't put into blk_alloc_queue_node() or
queue's initialization api(blk_init_allocated_queue(), or
blk_mq_init_allocated_queue())?

Thanks,
Ming
