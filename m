Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827DC55186
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EB720767
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 09:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVJIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:08:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgDVJIf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 05:08:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C022DAE47;
        Wed, 22 Apr 2020 09:08:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 00CEF1E125C; Wed, 22 Apr 2020 11:08:32 +0200 (CEST)
Date:   Wed, 22 Apr 2020 11:08:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200422090832.GE8775@quack2.suse.cz>
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073851.303714-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 22-04-20 09:38:46, Christoph Hellwig wrote:
> Cache a copy of the name for the life time of the backing_dev_info
> structure so that we can reference it even after unregistering.
> 
> Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
> Reported-by: Yufen Yu <yuyufen@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev-defs.h | 1 +
>  mm/backing-dev.c                 | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 4fc87dee005a..2849bdbb3acb 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -220,6 +220,7 @@ struct backing_dev_info {
>  	wait_queue_head_t wb_waitq;
>  
>  	struct device *dev;
> +	char dev_name[64];
>  	struct device *owner;
>  
>  	struct timer_list laptop_mode_wb_timer;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index c2c44c89ee5d..efc5b83acd2d 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -938,7 +938,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  	if (bdi->dev)	/* The driver needs to use separate queues per device */
>  		return 0;
>  
> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> +	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
>  
> @@ -1047,7 +1048,7 @@ const char *bdi_dev_name(struct backing_dev_info *bdi)
>  {
>  	if (!bdi || !bdi->dev)
>  		return bdi_unknown_name;
> -	return dev_name(bdi->dev);
> +	return bdi->dev_name;
>  }
>  EXPORT_SYMBOL_GPL(bdi_dev_name);
>  
> -- 
> 2.26.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
