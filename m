Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1565C6FA86
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 07:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiIWHDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIWHDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 03:03:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD611ED4F
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 00:03:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D0C0219F7;
        Fri, 23 Sep 2022 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663916626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkGxSx1RoZxQxUN1SPObAjEOQy9+pf0L5b2RDRD6cSY=;
        b=Z9Zjwmb+y0ilAObnsf3s5hJ2OCJeS9YthkNCDudD/zni58f5H5NTV0Wat6cuZx5ABPsYdu
        WixvjMRD9NX+I5wdQHfsgRCE4VA+5YWwg7fgTiJ811mBRTWZtIKRnm0PKIFx1EdCWKPWTY
        Wed8/ikvl94kZIT0ulVtZxaxxHxzIRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663916626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkGxSx1RoZxQxUN1SPObAjEOQy9+pf0L5b2RDRD6cSY=;
        b=ZsmH6ywGqyi2Z45EUa1cmmAgwNcdA7O4GNOnaUPbgRyGPTX9NzWa4H84t5DHRbN9dT4lLU
        LIsaroDaj1+eh6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2451C13A00;
        Fri, 23 Sep 2022 07:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ea0jBFJaLWMdYQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 23 Sep 2022 07:03:46 +0000
Date:   Fri, 23 Sep 2022 09:03:44 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 17/17] blk-cgroup: pass a gendisk to the blkg allocation
 helpers
Message-ID: <Yy1aUP/EFXhL1zHR@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-18-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:05:01PM +0200, Christoph Hellwig wrote:
> Prepare for storing the blkcg information in the gendisk instead of
> the request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 56 +++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index fc82057db9629..94af5f3f3620b 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -202,19 +202,19 @@ static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
>  /**
>   * blkg_alloc - allocate a blkg
>   * @blkcg: block cgroup the new blkg is associated with
> - * @q: request_queue the new blkg is associated with
> + * @disk: gendisk the new blkg is associated with
>   * @gfp_mask: allocation mask to use
>   *
>   * Allocate a new blkg assocating @blkcg and @q.
>   */
> -static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
> +static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  				   gfp_t gfp_mask)
>  {
>  	struct blkcg_gq *blkg;
>  	int i, cpu;
>  
>  	/* alloc and init base part */
> -	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, q->node);
> +	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, disk->queue->node);
>  	if (!blkg)
>  		return NULL;
>  
> @@ -225,10 +225,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>  	if (!blkg->iostat_cpu)
>  		goto err_free;
>  
> -	if (!blk_get_queue(q))
> +	if (!blk_get_queue(disk->queue))
>  		goto err_free;
>  
> -	blkg->q = q;
> +	blkg->q = disk->queue;
>  	INIT_LIST_HEAD(&blkg->q_node);
>  	spin_lock_init(&blkg->async_bio_lock);
>  	bio_list_init(&blkg->async_bios);
> @@ -243,11 +243,11 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>  		struct blkcg_policy *pol = blkcg_policy[i];
>  		struct blkg_policy_data *pd;
>  
> -		if (!blkcg_policy_enabled(q, pol))
> +		if (!blkcg_policy_enabled(disk->queue, pol))
>  			continue;
>  
>  		/* alloc per-policy data and attach it to blkg */
> -		pd = pol->pd_alloc_fn(gfp_mask, q, blkcg);
> +		pd = pol->pd_alloc_fn(gfp_mask, disk->queue, blkcg);
>  		if (!pd)
>  			goto err_free;
>  
> @@ -275,17 +275,16 @@ static void blkg_update_hint(struct blkcg *blkcg, struct blkcg_gq *blkg)
>   * If @new_blkg is %NULL, this function tries to allocate a new one as
>   * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
>   */
> -static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
> -				    struct request_queue *q,
> +static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  				    struct blkcg_gq *new_blkg)
>  {
>  	struct blkcg_gq *blkg;
>  	int i, ret;
>  
> -	lockdep_assert_held(&q->queue_lock);
> +	lockdep_assert_held(&disk->queue->queue_lock);
>  
>  	/* request_queue is dying, do not create/recreate a blkg */
> -	if (blk_queue_dying(q)) {
> +	if (blk_queue_dying(disk->queue)) {
>  		ret = -ENODEV;
>  		goto err_free_blkg;
>  	}
> @@ -298,7 +297,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  
>  	/* allocate */
>  	if (!new_blkg) {
> -		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT | __GFP_NOWARN);
> +		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT | __GFP_NOWARN);
>  		if (unlikely(!new_blkg)) {
>  			ret = -ENOMEM;
>  			goto err_put_css;
> @@ -308,7 +307,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  
>  	/* link parent */
>  	if (blkcg_parent(blkcg)) {
> -		blkg->parent = blkg_lookup(blkcg_parent(blkcg), q);
> +		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
>  		if (WARN_ON_ONCE(!blkg->parent)) {
>  			ret = -ENODEV;
>  			goto err_put_css;
> @@ -326,10 +325,10 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  
>  	/* insert */
>  	spin_lock(&blkcg->lock);
> -	ret = radix_tree_insert(&blkcg->blkg_tree, q->id, blkg);
> +	ret = radix_tree_insert(&blkcg->blkg_tree, disk->queue->id, blkg);
>  	if (likely(!ret)) {
>  		hlist_add_head_rcu(&blkg->blkcg_node, &blkcg->blkg_list);
> -		list_add(&blkg->q_node, &q->blkg_list);
> +		list_add(&blkg->q_node, &disk->queue->blkg_list);
>  
>  		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  			struct blkcg_policy *pol = blkcg_policy[i];
> @@ -358,19 +357,20 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  /**
>   * blkg_lookup_create - lookup blkg, try to create one if not there
>   * @blkcg: blkcg of interest
> - * @q: request_queue of interest
> + * @disk: gendisk of interest
>   *
> - * Lookup blkg for the @blkcg - @q pair.  If it doesn't exist, try to
> + * Lookup blkg for the @blkcg - @disk pair.  If it doesn't exist, try to
>   * create one.  blkg creation is performed recursively from blkcg_root such
>   * that all non-root blkg's have access to the parent blkg.  This function
> - * should be called under RCU read lock and takes @q->queue_lock.
> + * should be called under RCU read lock and takes @disk->queue->queue_lock.
>   *
>   * Returns the blkg or the closest blkg if blkg_create() fails as it walks
>   * down from root.
>   */
>  static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> -		struct request_queue *q)
> +		struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blkcg_gq *blkg;
>  	unsigned long flags;
>  
> @@ -408,7 +408,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  			parent = blkcg_parent(parent);
>  		}
>  
> -		blkg = blkg_create(pos, q, NULL);
> +		blkg = blkg_create(pos, disk, NULL);
>  		if (IS_ERR(blkg)) {
>  			blkg = ret_blkg;
>  			break;
> @@ -652,6 +652,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	__acquires(rcu) __acquires(&bdev->bd_queue->queue_lock)
>  {
>  	struct block_device *bdev;
> +	struct gendisk *disk;
>  	struct request_queue *q;
>  	struct blkcg_gq *blkg;
>  	int ret;
> @@ -659,8 +660,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	bdev = blkcg_conf_open_bdev(&input);
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
> -
> -	q = bdev_get_queue(bdev);
> +	disk = bdev->bd_disk;
> +	q = disk->queue;
>  
>  	/*
>  	 * blkcg_deactivate_policy() requires queue to be frozen, we can grab
> @@ -703,7 +704,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		spin_unlock_irq(&q->queue_lock);
>  		rcu_read_unlock();
>  
> -		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
> +		new_blkg = blkg_alloc(pos, disk, GFP_KERNEL);
>  		if (unlikely(!new_blkg)) {
>  			ret = -ENOMEM;
>  			goto fail_exit_queue;
> @@ -729,7 +730,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  			blkg_update_hint(pos, blkg);
>  			blkg_free(new_blkg);
>  		} else {
> -			blkg = blkg_create(pos, q, new_blkg);
> +			blkg = blkg_create(pos, disk, new_blkg);
>  			if (IS_ERR(blkg)) {
>  				ret = PTR_ERR(blkg);
>  				goto fail_preloaded;
> @@ -1234,7 +1235,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  
>  	INIT_LIST_HEAD(&q->blkg_list);
>  
> -	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
> +	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
>  	if (!new_blkg)
>  		return -ENOMEM;
>  
> @@ -1243,7 +1244,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  	/* Make sure the root blkg exists. */
>  	/* spin_lock_irq can serve as RCU read-side critical section. */
>  	spin_lock_irq(&q->queue_lock);
> -	blkg = blkg_create(&blkcg_root, q, new_blkg);
> +	blkg = blkg_create(&blkcg_root, disk, new_blkg);
>  	if (IS_ERR(blkg))
>  		goto err_unlock;
>  	q->root_blkg = blkg;
> @@ -1860,8 +1861,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
>  	struct blkcg_gq *blkg, *ret_blkg = NULL;
>  
>  	rcu_read_lock();
> -	blkg = blkg_lookup_create(css_to_blkcg(css),
> -				  bdev_get_queue(bio->bi_bdev));
> +	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_bdev->bd_disk);
>  	while (blkg) {
>  		if (blkg_tryget(blkg)) {
>  			ret_blkg = blkg;
> -- 
> 2.30.2
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
