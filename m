Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A0C6FA82
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 06:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiIWGio (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiIWGie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:38:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B51280DB
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 23:38:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C98D11F953;
        Fri, 23 Sep 2022 06:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663915111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS1dPeaXIzRME7ObCblZ8A+YKEsqI3GsSiIYZP9UjBE=;
        b=TdqhKRco4hhDpxBbtTPVBu7QnJz5bonIKFMDQPQ6rwc52pHNmoVeFeSTuWIQ5T3ikig0Sx
        rDlwrI8ZfEkxSzJOt5y07C9ciawnqwOw2HGwIsi1USab2TCQEar+yDyQDJPmRCbTX/p5xB
        61CCrZkEgB0h5Gj7NcDSdtvka8sEhpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663915111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS1dPeaXIzRME7ObCblZ8A+YKEsqI3GsSiIYZP9UjBE=;
        b=NCC278Qe2JHGwLmNs7EVllKeIlnEETqNYE8PQfhlpKGIo7y4yNi6KxR95+WlBEcNpkQzzk
        HzDXCY7ZxVPJ12Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DC3013AA5;
        Fri, 23 Sep 2022 06:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uF5sG2dULWOXVwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 23 Sep 2022 06:38:31 +0000
Date:   Fri, 23 Sep 2022 08:38:29 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 12/17] blk-throttle: pass a gendisk to blk_throtl_init
 and blk_throtl_exit
Message-ID: <Yy1UZXgRcwXzaidt@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:56PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_throtl_init and blk_throtl_exit as part of moving
> the blk-cgroup infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c   | 6 +++---
>  block/blk-throttle.c | 7 +++++--
>  block/blk-throttle.h | 8 ++++----
>  3 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 82a117ff54de5..3dfd78f1312db 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1261,7 +1261,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  	if (ret)
>  		goto err_destroy_all;
>  
> -	ret = blk_throtl_init(q);
> +	ret = blk_throtl_init(disk);
>  	if (ret)
>  		goto err_ioprio_exit;
>  
> @@ -1272,7 +1272,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  	return 0;
>  
>  err_throtl_exit:
> -	blk_throtl_exit(q);
> +	blk_throtl_exit(disk);
>  err_ioprio_exit:
>  	blk_ioprio_exit(disk);
>  err_destroy_all:
> @@ -1288,7 +1288,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  void blkcg_exit_disk(struct gendisk *disk)
>  {
>  	blkg_destroy_all(disk->queue);
> -	blk_throtl_exit(disk->queue);
> +	blk_throtl_exit(disk);
>  }
>  
>  static void blkcg_bind(struct cgroup_subsys_state *root_css)
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 55f2d985cfbbd..9ca8ae0ae6683 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2358,8 +2358,9 @@ void blk_throtl_bio_endio(struct bio *bio)
>  }
>  #endif
>  
> -int blk_throtl_init(struct request_queue *q)
> +int blk_throtl_init(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct throtl_data *td;
>  	int ret;
>  
> @@ -2401,8 +2402,10 @@ int blk_throtl_init(struct request_queue *q)
>  	return ret;
>  }
>  
> -void blk_throtl_exit(struct request_queue *q)
> +void blk_throtl_exit(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	BUG_ON(!q->td);
>  	del_timer_sync(&q->td->service_queue.pending_timer);
>  	throtl_shutdown_wq(q);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 66b4292b1b92a..f75852a4e5337 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -168,14 +168,14 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
>   * Internal throttling interface
>   */
>  #ifndef CONFIG_BLK_DEV_THROTTLING
> -static inline int blk_throtl_init(struct request_queue *q) { return 0; }
> -static inline void blk_throtl_exit(struct request_queue *q) { }
> +static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
> +static inline void blk_throtl_exit(struct gendisk *disk) { }
>  static inline void blk_throtl_register_queue(struct request_queue *q) { }
>  static inline bool blk_throtl_bio(struct bio *bio) { return false; }
>  static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
>  #else /* CONFIG_BLK_DEV_THROTTLING */
> -int blk_throtl_init(struct request_queue *q);
> -void blk_throtl_exit(struct request_queue *q);
> +int blk_throtl_init(struct gendisk *disk);
> +void blk_throtl_exit(struct gendisk *disk);
>  void blk_throtl_register_queue(struct request_queue *q);
>  bool __blk_throtl_bio(struct bio *bio);
>  void blk_throtl_cancel_bios(struct request_queue *q);
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
