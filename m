Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE2FC6FA86
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 14:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiIVOWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiIVOVn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:21:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B3F3701
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:21:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02E69218E2;
        Thu, 22 Sep 2022 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663856498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJ5MloPjge1aybrw3VPT2moRtXskWEybZMK58z8IXfE=;
        b=Weq8TCjwwmOu7o6qxSQk7ptwxLxnTCKFl9qvAxMe4etjymWQ15iUFpXbmuCVKImJqhdWv8
        N3i37J3YhsNeAFv+tJ8suzw3ZQrzJRRTbhIhk7zVbNNgf3mP6FynbzC2NprZ1UHXCvOFcp
        Csa06CSxlEew8c+hVhAvNU1ZRg+tVtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663856498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJ5MloPjge1aybrw3VPT2moRtXskWEybZMK58z8IXfE=;
        b=ffLv+zfbib1ZlqQ/Dc6T2QPNyLRd9GnEF3qTOfAaIVdT4o3XdnHDu/n684NwXcRO+rHVRj
        wociiF3xfLXw90CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF35113AA5;
        Thu, 22 Sep 2022 14:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLs+MXFvLGNcEwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 14:21:37 +0000
Date:   Thu, 22 Sep 2022 16:21:36 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 16/17] blk-cgroup: pass a gendisk to
 blkcg_schedule_throttle
Message-ID: <YyxvcAwPm7jSSLNd@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:05:00PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blkcg_schedule_throttle as part of moving the
> blk-cgroup infrastructure to be gendisk based.  Remove the unused
> !BLK_CGROUP stub while we're at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c         | 8 +++++---
>  block/blk-iocost.c         | 4 ++--
>  block/blk-iolatency.c      | 2 +-
>  include/linux/blk-cgroup.h | 5 ++---
>  mm/swapfile.c              | 2 +-
>  5 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c2d5ca2eb92e5..fc82057db9629 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1792,13 +1792,13 @@ void blkcg_maybe_throttle_current(void)
>  
>  /**
>   * blkcg_schedule_throttle - this task needs to check for throttling
> - * @q: the request queue IO was submitted on
> + * @gendisk: disk to throttle
>   * @use_memdelay: do we charge this to memory delay for PSI
>   *
>   * This is called by the IO controller when we know there's delay accumulated
>   * for the blkg for this task.  We do not pass the blkg because there are places
>   * we call this that may not have that information, the swapping code for
> - * instance will only have a request_queue at that point.  This set's the
> + * instance will only have a block_device at that point.  This set's the
>   * notify_resume for the task to check and see if it requires throttling before
>   * returning to user space.
>   *
> @@ -1807,8 +1807,10 @@ void blkcg_maybe_throttle_current(void)
>   * throttle once.  If the task needs to be throttled again it'll need to be
>   * re-set at the next time we see the task.
>   */
> -void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
> +void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	if (unlikely(current->flags & PF_KTHREAD))
>  		return;
>  
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index b8e5f550aa5be..b0899ab214c41 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2636,7 +2636,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
>  	if (use_debt) {
>  		iocg_incur_debt(iocg, abs_cost, &now);
>  		if (iocg_kick_delay(iocg, &now))
> -			blkcg_schedule_throttle(rqos->q,
> +			blkcg_schedule_throttle(rqos->q->disk,
>  					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
>  		iocg_unlock(iocg, ioc_locked, &flags);
>  		return;
> @@ -2737,7 +2737,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
>  	if (likely(!list_empty(&iocg->active_list))) {
>  		iocg_incur_debt(iocg, abs_cost, &now);
>  		if (iocg_kick_delay(iocg, &now))
> -			blkcg_schedule_throttle(rqos->q,
> +			blkcg_schedule_throttle(rqos->q->disk,
>  					(bio->bi_opf & REQ_SWAP) == REQ_SWAP);
>  	} else {
>  		iocg_commit_bio(iocg, bio, abs_cost, cost);
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index c6f61fe88b875..571fa95aafe96 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -292,7 +292,7 @@ static void __blkcg_iolatency_throttle(struct rq_qos *rqos,
>  	unsigned use_delay = atomic_read(&lat_to_blkg(iolat)->use_delay);
>  
>  	if (use_delay)
> -		blkcg_schedule_throttle(rqos->q, use_memdelay);
> +		blkcg_schedule_throttle(rqos->q->disk, use_memdelay);
>  
>  	/*
>  	 * To avoid priority inversions we want to just take a slot if we are
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 9f40dbc65f82c..dd5841a42c331 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -18,14 +18,14 @@
>  
>  struct bio;
>  struct cgroup_subsys_state;
> -struct request_queue;
> +struct gendisk;
>  
>  #define FC_APPID_LEN              129
>  
>  #ifdef CONFIG_BLK_CGROUP
>  extern struct cgroup_subsys_state * const blkcg_root_css;
>  
> -void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
> +void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay);
>  void blkcg_maybe_throttle_current(void);
>  bool blk_cgroup_congested(void);
>  void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css);
> @@ -39,7 +39,6 @@ struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
>  
>  static inline void blkcg_maybe_throttle_current(void) { }
>  static inline bool blk_cgroup_congested(void) { return false; }
> -static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
>  static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
>  {
>  	return NULL;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1fdccd2f1422e..82e62007881db 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3655,7 +3655,7 @@ void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
>  				  avail_lists[nid]) {
>  		if (si->bdev) {
> -			blkcg_schedule_throttle(bdev_get_queue(si->bdev), true);
> +			blkcg_schedule_throttle(si->bdev->bd_disk, true);
>  			break;
>  		}
>  	}
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
