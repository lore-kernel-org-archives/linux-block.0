Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D4C54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 12:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIVMLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVMLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 08:11:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A952E75
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 05:11:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 155801F8D2;
        Thu, 22 Sep 2022 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663848669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9d6wdDCBElj6lRZDhibbmVewURbLuu8wSMfsK89pfEs=;
        b=AaVSpi0kuFSi85MWc4VFw7BZiEorN39QuQjExIj88V7DFRna2OKWTQtaxHid6bTS1SOzyl
        EazAf3tnbDY3ZGfd3BAw6dfLvyg1X03e1WymXH4p+hhbPKSbiXeKRio1PilMRPwmU9G2LJ
        ov79UO3UL0x5FrEoFDzBWd0X+a8jZZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663848669;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9d6wdDCBElj6lRZDhibbmVewURbLuu8wSMfsK89pfEs=;
        b=5e8aPTZHKH0wBRdctPkiYkkCdNS/9uZHlLHOMfj6CZTf2GbiJ40hASj6nK9qHKZoB0Hon8
        3DEUaW8+kzqHKJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E36871346B;
        Thu, 22 Sep 2022 12:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B/gvNtxQLGN/UAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 12:11:08 +0000
Date:   Thu, 22 Sep 2022 14:11:07 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 10/17] blk-iocost: pass a gendisk to blk_iocost_init
Message-ID: <YyxQ2x9zJBCHkVUS@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:54PM +0200, Christoph Hellwig wrote:
> Pass the gendisk to blk_iocost_init as part of moving the blk-cgroup
> infrastructure to be gendisk based.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-iocost.c | 7 ++++---
>  block/blk.h        | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index cba9d3ad58e16..1e7bf0d353227 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2828,8 +2828,9 @@ static struct rq_qos_ops ioc_rqos_ops = {
>  	.exit = ioc_rqos_exit,
>  };
>  
> -static int blk_iocost_init(struct request_queue *q)
> +static int blk_iocost_init(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
>  	struct ioc *ioc;
>  	struct rq_qos *rqos;
>  	int i, cpu, ret;
> @@ -3178,7 +3179,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>  
>  	ioc = q_to_ioc(bdev_get_queue(bdev));
>  	if (!ioc) {
> -		ret = blk_iocost_init(bdev_get_queue(bdev));
> +		ret = blk_iocost_init(bdev->bd_disk);
>  		if (ret)
>  			goto err;
>  		ioc = q_to_ioc(bdev_get_queue(bdev));
> @@ -3345,7 +3346,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  
>  	ioc = q_to_ioc(bdev_get_queue(bdev));
>  	if (!ioc) {
> -		ret = blk_iocost_init(bdev_get_queue(bdev));
> +		ret = blk_iocost_init(bdev->bd_disk);
>  		if (ret)
>  			goto err;
>  		ioc = q_to_ioc(bdev_get_queue(bdev));
> diff --git a/block/blk.h b/block/blk.h
> index 361db83147c6f..8d5c7a6f52a66 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -391,7 +391,7 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
>  #ifdef CONFIG_BLK_CGROUP_IOLATENCY
>  int blk_iolatency_init(struct gendisk *disk);
>  #else
> -static int blk_iolatency_init(struct gendisk *disk) { return 0 };
> +static int blk_iolatency_init(struct gendisk *disk) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
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
