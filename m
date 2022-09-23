Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85078C6FA82
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIWGm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIWGm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:42:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED95E127CB8
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 23:42:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 968EE1F8E2;
        Fri, 23 Sep 2022 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663915376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSJb4oVqqPJeWNlotJWvUcJu3jbOqdOOkNiPtpWBnqs=;
        b=HQYk+rXyzW5/+tg6Lua6Snl1lpFRMfFMA/bSTTKD6jNyoABFRC44UbVBVa9whDuBYjTp5I
        BxEiOpH3YHJCALpzBycBOBuacIwkLHl/iLjFhW2a+cDTaJiVWhuBRkzW37yDvptkHOJGxE
        5PyTZV0B8mUfztMTF1092F8Ux9qLWnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663915376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSJb4oVqqPJeWNlotJWvUcJu3jbOqdOOkNiPtpWBnqs=;
        b=kOR+VWbd0o4BnSnyt2HIvYMS1SyNfCpgImKs3II04uDrUm7quje4n4uCXVAglawy7KMoOM
        Y0CwXViMjHIsPHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C9A213AA5;
        Fri, 23 Sep 2022 06:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ame0D3BVLWM2WQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 23 Sep 2022 06:42:56 +0000
Date:   Fri, 23 Sep 2022 08:42:54 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 14/17] blk-throttle: pass a gendisk to
 blk_throtl_cancel_bios
Message-ID: <Yy1Vbopg6FFJ1sdj@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:58PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_throtl_cancel_bios as part of moving the
> blk-cgroup infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-throttle.c | 3 ++-
>  block/blk-throttle.h | 4 ++--
>  block/genhd.c        | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index a9709d4af6f39..8c683d5050483 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1723,8 +1723,9 @@ struct blkcg_policy blkcg_policy_throtl = {
>  	.pd_free_fn		= throtl_pd_free,
>  };
>  
> -void blk_throtl_cancel_bios(struct request_queue *q)
> +void blk_throtl_cancel_bios(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct cgroup_subsys_state *pos_css;
>  	struct blkcg_gq *blkg;
>  
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 7e217e613aee2..143991fd13228 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -172,13 +172,13 @@ static inline int blk_throtl_init(struct gendisk *disk) { return 0; }
>  static inline void blk_throtl_exit(struct gendisk *disk) { }
>  static inline void blk_throtl_register(struct gendisk *disk) { }
>  static inline bool blk_throtl_bio(struct bio *bio) { return false; }
> -static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
> +static inline void blk_throtl_cancel_bios(struct gendisk *disk) { }
>  #else /* CONFIG_BLK_DEV_THROTTLING */
>  int blk_throtl_init(struct gendisk *disk);
>  void blk_throtl_exit(struct gendisk *disk);
>  void blk_throtl_register(struct gendisk *disk);
>  bool __blk_throtl_bio(struct bio *bio);
> -void blk_throtl_cancel_bios(struct request_queue *q);
> +void blk_throtl_cancel_bios(struct gendisk *disk);
>  static inline bool blk_throtl_bio(struct bio *bio)
>  {
>  	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> diff --git a/block/genhd.c b/block/genhd.c
> index f1af045fac2fe..d6a21803a57e2 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -626,7 +626,7 @@ void del_gendisk(struct gendisk *disk)
>  	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
>  	device_del(disk_to_dev(disk));
>  
> -	blk_throtl_cancel_bios(disk->queue);
> +	blk_throtl_cancel_bios(disk);
>  
>  	blk_sync_queue(q);
>  	blk_flush_integrity();
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
