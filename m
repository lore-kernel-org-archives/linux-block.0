Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AB9C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 12:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiIVMLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVMLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 08:11:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA152E75
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 05:11:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DDC721A32;
        Thu, 22 Sep 2022 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663848700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KylczORo8Jgo73p7jeEyt/himenFvR9a74rSUrvw7lU=;
        b=lr8gbh6mBrvsYptuda4zn1gOsfYf6/ulrIBZiBd32PivtdWo7u/a0f3PFBG9Yf0vPFaYXf
        VfesBy4C4mWp7GUM3skPslpJR7vgTq3GAw9vnzIqXUkuP8K7FXdbM1ddkF2Q0TiOqlIbCa
        h5qIE/x/SJ2fUAMBKQzd/BuIc5meaw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663848700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KylczORo8Jgo73p7jeEyt/himenFvR9a74rSUrvw7lU=;
        b=dEfDwC29H46eJVFYFatW78G5Bw/DytD6O48g51vFPLU78JpDiZQXGLpySfQqbIDLZeMLrg
        gdgX4FengkL/+jCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 273691346B;
        Thu, 22 Sep 2022 12:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dPA6CPxQLGO8UAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 12:11:40 +0000
Date:   Thu, 22 Sep 2022 14:11:38 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 11/17] blk-iocost: cleanup ioc_qos_write
Message-ID: <YyxQ+lfIsP8mSAGq@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:55PM +0200, Christoph Hellwig wrote:
> Use a local disk variable instead of retrieving the disk and
> request_queue over and over by various means.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-iocost.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 1e7bf0d353227..b8e5f550aa5be 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3167,6 +3167,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  			     size_t nbytes, loff_t off)
>  {
>  	struct block_device *bdev;
> +	struct gendisk *disk;
>  	struct ioc *ioc;
>  	u32 qos[NR_QOS_PARAMS];
>  	bool enable, user;
> @@ -3177,12 +3178,13 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  	if (IS_ERR(bdev))
>  		return PTR_ERR(bdev);
>  
> -	ioc = q_to_ioc(bdev_get_queue(bdev));
> +	disk = bdev->bd_disk;
> +	ioc = q_to_ioc(disk->queue);
>  	if (!ioc) {
> -		ret = blk_iocost_init(bdev->bd_disk);
> +		ret = blk_iocost_init(disk);
>  		if (ret)
>  			goto err;
> -		ioc = q_to_ioc(bdev_get_queue(bdev));
> +		ioc = q_to_ioc(disk->queue);
>  	}
>  
>  	spin_lock_irq(&ioc->lock);
> @@ -3259,11 +3261,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  	spin_lock_irq(&ioc->lock);
>  
>  	if (enable) {
> -		blk_stat_enable_accounting(ioc->rqos.q);
> -		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
> +		blk_stat_enable_accounting(disk->queue);
> +		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>  		ioc->enabled = true;
>  	} else {
> -		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
> +		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
>  		ioc->enabled = false;
>  	}
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
