Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D533C54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiIVNjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiIVNiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:38:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00EF7B790
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:38:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD7E31F38D;
        Thu, 22 Sep 2022 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663853881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzpJDWrBG2TomAe5pib/r13k0hKgah319F+1M9Ja1ps=;
        b=vI7vzzYqyBaFJi60fS/IQBJwF1vG/fhNsySjw38eF6DnmXQE1/5uz6JJv2/MRa0nqVEbog
        VrmFgKqNrr5efUupJtybuziBYoptwSroRaGoQuXjA1mqMrN/FUmkwfNO8Guvdq0of+wHp4
        Gjf8B9FIW+wwHUfB6n4qov12uW93JAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663853881;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzpJDWrBG2TomAe5pib/r13k0hKgah319F+1M9Ja1ps=;
        b=2CY//JrdODFfLZZvzcJhBJSOhC3jK5nAWMQjNlcC09Hi083REe7kLZZMdVj5WX927FKuQK
        M1ENsfgZhNpUX5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8631013AA5;
        Thu, 22 Sep 2022 13:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qqFpHzllLGObewAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:38:01 +0000
Date:   Thu, 22 Sep 2022 15:38:00 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] blk-ioprio: pass a gendisk to blk_ioprio_init and
 blk_ioprio_exit
Message-ID: <YyxlOOWNmPmDq4D5@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:51PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_ioprio_init and blk_ioprio_exit as part of moving
> the blk-cgroup infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 4 ++--
>  block/blk-ioprio.c | 8 ++++----
>  block/blk-ioprio.h | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 4ca6933a7c3f5..89974fd0db3da 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1257,7 +1257,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  	if (preloaded)
>  		radix_tree_preload_end();
>  
> -	ret = blk_ioprio_init(q);
> +	ret = blk_ioprio_init(disk);
>  	if (ret)
>  		goto err_destroy_all;
>  
> @@ -1274,7 +1274,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  err_throtl_exit:
>  	blk_throtl_exit(q);
>  err_ioprio_exit:
> -	blk_ioprio_exit(q);
> +	blk_ioprio_exit(disk);
>  err_destroy_all:
>  	blkg_destroy_all(q);
>  	return ret;
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index c00060a02c6ef..8bb6b8eba4cee 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -202,14 +202,14 @@ void blkcg_set_ioprio(struct bio *bio)
>  		bio->bi_ioprio = prio;
>  }
>  
> -void blk_ioprio_exit(struct request_queue *q)
> +void blk_ioprio_exit(struct gendisk *disk)
>  {
> -	blkcg_deactivate_policy(q, &ioprio_policy);
> +	blkcg_deactivate_policy(disk->queue, &ioprio_policy);
>  }
>  
> -int blk_ioprio_init(struct request_queue *q)
> +int blk_ioprio_init(struct gendisk *disk)
>  {
> -	return blkcg_activate_policy(q, &ioprio_policy);
> +	return blkcg_activate_policy(disk->queue, &ioprio_policy);
>  }
>  
>  static int __init ioprio_init(void)
> diff --git a/block/blk-ioprio.h b/block/blk-ioprio.h
> index 5a1eb550e178c..b6afb8e80de05 100644
> --- a/block/blk-ioprio.h
> +++ b/block/blk-ioprio.h
> @@ -9,15 +9,15 @@ struct request_queue;
>  struct bio;
>  
>  #ifdef CONFIG_BLK_CGROUP_IOPRIO
> -int blk_ioprio_init(struct request_queue *q);
> -void blk_ioprio_exit(struct request_queue *q);
> +int blk_ioprio_init(struct gendisk *disk);
> +void blk_ioprio_exit(struct gendisk *disk);
>  void blkcg_set_ioprio(struct bio *bio);
>  #else
> -static inline int blk_ioprio_init(struct request_queue *q)
> +static inline int blk_ioprio_init(struct gendisk *disk)
>  {
>  	return 0;
>  }
> -static inline void blk_ioprio_exit(struct request_queue *q)
> +static inline void blk_ioprio_exit(struct gendisk *disk)
>  {
>  }
>  static inline void blkcg_set_ioprio(struct bio *bio)
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
