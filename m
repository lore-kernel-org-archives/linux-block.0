Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BEBC54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiIVNeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVNeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:34:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC71D4DED
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:34:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D37E219A6;
        Thu, 22 Sep 2022 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663853655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlYRM2f08sBn4GnB9RAPHIj6SD49nAUxhPuDst1G1WM=;
        b=l+ATbAR1IwJCiaPBJ9SBqyV7U6g+L/WKFvOi3PQdnml8lU/5iVGLsvE3iu8Bp9d+emg18k
        1SJkm2AlNvxDu9GTN8n9nMNze71vqS2pZUFmQwXPsPo40bnaZeVq9Z09ApbJyvzJ8BKT2i
        cKamIxsJJCeaCcce8Ip04zmTFtqWiJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663853655;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlYRM2f08sBn4GnB9RAPHIj6SD49nAUxhPuDst1G1WM=;
        b=VPPa9BFbUBxvgeV3IKzd/6VsE7DMls35ZTxG+mG7mgkQxunY4LNQKXnQOOdyXuyJK6jvar
        LckdEr2/UzOL87DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5444413AA5;
        Thu, 22 Sep 2022 13:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qQQ3E1dkLGONeQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:34:15 +0000
Date:   Thu, 22 Sep 2022 15:34:13 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 06/17] blk-cgroup: pass a gendisk to blkcg_init_queue and
 blkcg_exit_queue
Message-ID: <YyxkVQs0/+9HEux3@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:50PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blkcg_init_disk and blkcg_exit_disk as part of moving
> the blk-cgroup infrastructure to be gendisk based.  Also remove the
> rather pointless kerneldoc comments for these internal functions with a
> single caller each.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 25 +++++--------------------
>  block/blk-cgroup.h |  8 ++++----
>  block/genhd.c      |  5 +++--
>  3 files changed, 12 insertions(+), 26 deletions(-)

This creates a stale reference to blkcg_exit_queue() in comment of
block/blk-core.c which needs to be adapted, I think:

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -223,7 +223,7 @@ const char *blk_status_to_str(blk_status_t status)
  *
  *     This function does not cancel any asynchronous activity arising
  *     out of elevator or throttling code. That would require elevator_exit()
- *     and blkcg_exit_queue() to be called with queue lock initialized.
+ *     and blkcg_exit_disk() to be called with queue lock initialized.
  *
  */
 void blk_sync_queue(struct request_queue *q)

--
Otherwise
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 1306112d76486..4ca6933a7c3f5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1230,18 +1230,9 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
>  	return 0;
>  }
>  
> -/**
> - * blkcg_init_queue - initialize blkcg part of request queue
> - * @q: request_queue to initialize
> - *
> - * Called from blk_alloc_queue(). Responsible for initializing blkcg
> - * part of new request_queue @q.
> - *
> - * RETURNS:
> - * 0 on success, -errno on failure.
> - */
> -int blkcg_init_queue(struct request_queue *q)
> +int blkcg_init_disk(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blkcg_gq *new_blkg, *blkg;
>  	bool preloaded;
>  	int ret;
> @@ -1294,16 +1285,10 @@ int blkcg_init_queue(struct request_queue *q)
>  	return PTR_ERR(blkg);
>  }
>  
> -/**
> - * blkcg_exit_queue - exit and release blkcg part of request_queue
> - * @q: request_queue being released
> - *
> - * Called from blk_exit_queue().  Responsible for exiting blkcg part.
> - */
> -void blkcg_exit_queue(struct request_queue *q)
> +void blkcg_exit_disk(struct gendisk *disk)
>  {
> -	blkg_destroy_all(q);
> -	blk_throtl_exit(q);
> +	blkg_destroy_all(disk->queue);
> +	blk_throtl_exit(disk->queue);
>  }
>  
>  static void blkcg_bind(struct cgroup_subsys_state *root_css)
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 91b7ae0773be6..aa2b286bc825f 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -178,8 +178,8 @@ struct blkcg_policy {
>  extern struct blkcg blkcg_root;
>  extern bool blkcg_debug_stats;
>  
> -int blkcg_init_queue(struct request_queue *q);
> -void blkcg_exit_queue(struct request_queue *q);
> +int blkcg_init_disk(struct gendisk *disk);
> +void blkcg_exit_disk(struct gendisk *disk);
>  
>  /* Blkio controller policy registration */
>  int blkcg_policy_register(struct blkcg_policy *pol);
> @@ -481,8 +481,8 @@ struct blkcg {
>  };
>  
>  static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
> -static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
> -static inline void blkcg_exit_queue(struct request_queue *q) { }
> +static inline int blkcg_init_disk(struct gendisk *disk) { return 0; }
> +static inline void blkcg_exit_disk(struct gendisk *disk) { }
>  static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
>  static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
>  static inline int blkcg_activate_policy(struct request_queue *q,
> diff --git a/block/genhd.c b/block/genhd.c
> index d36fabf0abc1f..f1af045fac2fe 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1150,7 +1150,8 @@ static void disk_release(struct device *dev)
>  	    !test_bit(GD_ADDED, &disk->state))
>  		blk_mq_exit_queue(disk->queue);
>  
> -	blkcg_exit_queue(disk->queue);
> +	blkcg_exit_disk(disk);
> +
>  	bioset_exit(&disk->bio_split);
>  
>  	disk_release_events(disk);
> @@ -1363,7 +1364,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
>  		goto out_destroy_part_tbl;
>  
> -	if (blkcg_init_queue(q))
> +	if (blkcg_init_disk(disk))
>  		goto out_erase_part0;
>  
>  	rand_initialize_disk(disk);
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
