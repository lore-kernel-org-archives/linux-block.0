Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FBFC6FA82
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 06:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIWGjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIWGjy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:39:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1860697
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 23:39:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF736219DA;
        Fri, 23 Sep 2022 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663915188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzuegm46H6/9/Ci/Pm8f5oytrYH4IAqM9OoigRLJ+28=;
        b=F9T9/5kk3SAuSNn67iRXi9Eh0K9nD/tNMv9w07wmM+5odgfCkvP1A7z6sJOV2tCnvT+WW+
        bQVLyA9XDeKW4KPaK1Cceq5VUSLEOzUDt7iCMOUkMhOrvhbCqXuvCSe0kNjudeE/S7h4Y3
        A3k0ATw4m4oaMnBv86ffuwS7tsD0Jl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663915188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzuegm46H6/9/Ci/Pm8f5oytrYH4IAqM9OoigRLJ+28=;
        b=xQrXIVpdowK0kk5B9ieytPqOYIjzwA/4DLQLvhM0g3dJbBizR16LJLE5EUdj8G7zIxxdxH
        nQ/Y41NExkZm9dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63F6F13AA5;
        Fri, 23 Sep 2022 06:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 59q7FbRULWP9VwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 23 Sep 2022 06:39:48 +0000
Date:   Fri, 23 Sep 2022 08:39:46 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 13/17] blk-throttle: pass a gendisk to
 blk_throtl_register_queue
Message-ID: <Yy1Uss1pbsR5HJ6/@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:57PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_throtl_register_queue as part of moving the
> blk-cgroup infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-sysfs.c    | 2 +-
>  block/blk-throttle.c | 3 ++-
>  block/blk-throttle.h | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e1f009aba6fd2..e71b3b43927c0 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -844,7 +844,7 @@ int blk_register_queue(struct gendisk *disk)
>  
>  	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
>  	wbt_enable_default(q);
> -	blk_throtl_register_queue(q);
> +	blk_throtl_register(disk);
>  
>  	/* Now everything is ready and send out KOBJ_ADD uevent */
>  	kobject_uevent(&q->kobj, KOBJ_ADD);
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 9ca8ae0ae6683..a9709d4af6f39 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2415,8 +2415,9 @@ void blk_throtl_exit(struct gendisk *disk)
>  	kfree(q->td);
>  }
>  
> -void blk_throtl_register_queue(struct request_queue *q)
> +void blk_throtl_register(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct throtl_data *td;
>  	int i;
>  
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index f75852a4e5337..7e217e613aee2 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -170,13 +170,13 @@ static inline struct throtl_grp *blkg_to_tg(struct blkcg_gq *blkg)
>  #ifndef CONFIG_BLK_DEV_THROTTLING
>  static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
>  static inline void blk_throtl_exit(struct gendisk *disk) { }
> -static inline void blk_throtl_register_queue(struct request_queue *q) { }
> +static inline void blk_throtl_register(struct gendisk *disk) { }
>  static inline bool blk_throtl_bio(struct bio *bio) { return false; }
>  static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
>  #else /* CONFIG_BLK_DEV_THROTTLING */
>  int blk_throtl_init(struct gendisk *disk);
>  void blk_throtl_exit(struct gendisk *disk);
> -void blk_throtl_register_queue(struct request_queue *q);
> +void blk_throtl_register(struct gendisk *disk);
>  bool __blk_throtl_bio(struct bio *bio);
>  void blk_throtl_cancel_bios(struct request_queue *q);
>  static inline bool blk_throtl_bio(struct bio *bio)
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
