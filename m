Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE4C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiIVNmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVNmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:42:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD457D62E0
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:42:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D71C21A49;
        Thu, 22 Sep 2022 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663854134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJelLEfuuR+svkQ2l/gSK+7xE6vwYFX6QKtuIeNHAks=;
        b=oP258jGbnk3PcAxLAi0eQLnNY8HM/1W3IpId64TWUVVtk7/k+F6HC96TvnutXXfF44dt8I
        mFQH1aPKvxGtrbCOGA41yCGbh8a5pEOBM2cWMrjGiKUXOMJRtdP+GO9DwuE5PcW0275j30
        swJ8qQgOeBQ36w+sv+TL2Dy1Un9of68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663854134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJelLEfuuR+svkQ2l/gSK+7xE6vwYFX6QKtuIeNHAks=;
        b=zh9Ob6oACO6t/daQ8dBs3O7nkdDQX3/hZHcZtQbTtOHwxEzqpvvNFBhhqHluFReBvV0jI0
        lODBKsG+l2/c1CCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5489A13AA5;
        Thu, 22 Sep 2022 13:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4gAUEzZmLGOIfQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:42:14 +0000
Date:   Thu, 22 Sep 2022 15:42:12 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 15/17] blk-cgroup: pass a gendisk to blkg_destroy_all
Message-ID: <YyxmNE+Ae9D2mSuB@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:59PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blkg_destroy_all as part of moving the blk-cgroup
> infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 3dfd78f1312db..c2d5ca2eb92e5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -462,14 +462,9 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  	percpu_ref_kill(&blkg->refcnt);
>  }
>  
> -/**
> - * blkg_destroy_all - destroy all blkgs associated with a request_queue
> - * @q: request_queue of interest
> - *
> - * Destroy all blkgs associated with @q.
> - */
> -static void blkg_destroy_all(struct request_queue *q)
> +static void blkg_destroy_all(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct blkcg_gq *blkg, *n;
>  	int count = BLKG_DESTROY_BATCH_SIZE;
>  
> @@ -1276,7 +1271,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  err_ioprio_exit:
>  	blk_ioprio_exit(disk);
>  err_destroy_all:
> -	blkg_destroy_all(q);
> +	blkg_destroy_all(disk);
>  	return ret;
>  err_unlock:
>  	spin_unlock_irq(&q->queue_lock);
> @@ -1287,7 +1282,7 @@ int blkcg_init_disk(struct gendisk *disk)
>  
>  void blkcg_exit_disk(struct gendisk *disk)
>  {
> -	blkg_destroy_all(disk->queue);
> +	blkg_destroy_all(disk);
>  	blk_throtl_exit(disk);
>  }
>  
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
