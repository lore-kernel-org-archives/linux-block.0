Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF0BC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiIVNDJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiIVNDI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:03:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2AE7C03
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:03:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4503521A32;
        Thu, 22 Sep 2022 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663851786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnZsuJxCUL2LmiczvQiRHN79cksCTBC8I/aoPdSYfkQ=;
        b=ps5ww1tPbwTfOXiU14MyxsPSJ4oCDfD5/zlHm6D74gcHrh6YXcu5zX/lP1E6JnSyzgeZv+
        TQJ95qFWv5abN8mi8tXqkxez76OmfKOGMrckWkfD367oScvITVUp7vAMKoiHu4m7IZAJX4
        ucbYDAA0nMDGUQRb1IlB5V/wI4Fxrzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663851786;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnZsuJxCUL2LmiczvQiRHN79cksCTBC8I/aoPdSYfkQ=;
        b=TH3rH8fvmeDWH5IVKN/rjZy03+adyq58+nJWfSSaV17xvC+vzoHJ8ZvnXgNs4TVw6FYdlD
        zMoFHlYwtyGv8+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13F8D1346B;
        Thu, 22 Sep 2022 13:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9oiKAwpdLGOAagAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:03:06 +0000
Date:   Thu, 22 Sep 2022 15:03:04 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 02/17] blk-cgroup: remove blk_queue_root_blkg
Message-ID: <YyxdCDRhT20KdhNW@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:46PM +0200, Christoph Hellwig wrote:
> Just open code it in the only caller and drop the unused !BLK_CGROUP
> stub.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c |  3 +--
>  block/blk-cgroup.h | 13 -------------
>  2 files changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 3a88f8c011d27..4180de4cbb3e1 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -915,8 +915,7 @@ static void blkcg_fill_root_iostats(void)
>  	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
>  	while ((dev = class_dev_iter_next(&iter))) {
>  		struct block_device *bdev = dev_to_bdev(dev);
> -		struct blkcg_gq *blkg =
> -			blk_queue_root_blkg(bdev_get_queue(bdev));
> +		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
>  		struct blkg_iostat tmp;
>  		int cpu;
>  		unsigned long flags;
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index d2724d1dd7c9b..c1fb00a1dfc03 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -268,17 +268,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
>  	return __blkg_lookup(blkcg, q, false);
>  }
>  
> -/**
> - * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
> - * @q: request_queue of interest
> - *
> - * Lookup blkg for @q at the root level. See also blkg_lookup().
> - */
> -static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
> -{
> -	return q->root_blkg;
> -}
> -
>  /**
>   * blkg_to_pdata - get policy private data
>   * @blkg: blkg of interest
> @@ -507,8 +496,6 @@ struct blkcg {
>  };
>  
>  static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
> -static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
> -{ return NULL; }
>  static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
>  static inline void blkcg_exit_queue(struct request_queue *q) { }
>  static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
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
