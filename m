Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C46C352BE
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2077820771
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634894AbgDPMF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634179AbgDPMFY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82776AB7F;
        Thu, 16 Apr 2020 12:05:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 201CF1E1250; Thu, 16 Apr 2020 14:05:20 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:05:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] bdi: remove bdi_register_owner
Message-ID: <20200416120520.GK23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 09:15:17, Christoph Hellwig wrote:
> Split out a new bdi_set_owner helper to set the owner, and move the policy
> for creating the bdi name back into genhd.c, where it belongs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Fine by me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/genhd.c               |  8 +++++---
>  include/linux/backing-dev.h |  2 +-
>  mm/backing-dev.c            | 12 ++----------
>  3 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 06b642b23a07..7d10cfc38c70 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -840,13 +840,15 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>  		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
>  		disk->flags |= GENHD_FL_NO_PART_SCAN;
>  	} else {
> +		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
> +		struct device *dev = disk_to_dev(disk);
>  		int ret;
>  
>  		/* Register BDI before referencing it from bdev */
> -		disk_to_dev(disk)->devt = devt;
> -		ret = bdi_register_owner(disk->queue->backing_dev_info,
> -						disk_to_dev(disk));
> +		dev->devt = devt;
> +		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
>  		WARN_ON(ret);
> +		bdi_set_owner(bdi, dev);
>  		blk_register_region(disk_devt(disk), disk->minors, NULL,
>  				    exact_match, exact_lock, disk);
>  	}
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index c9ad5c3b7b4b..4098ed6ba6b4 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -33,7 +33,7 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
>  __printf(2, 0)
>  int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
>  		    va_list args);
> -int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
> +void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
>  void bdi_unregister(struct backing_dev_info *bdi);
>  
>  struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index a7eb91146c9c..1ba9a7b30933 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -982,20 +982,12 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL(bdi_register);
>  
> -int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
> +void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner)
>  {
> -	int rc;
> -
> -	rc = bdi_register(bdi, "%u:%u", MAJOR(owner->devt), MINOR(owner->devt));
> -	if (rc)
> -		return rc;
> -	/* Leaking owner reference... */
> -	WARN_ON(bdi->owner);
> +	WARN_ON_ONCE(bdi->owner);
>  	bdi->owner = owner;
>  	get_device(owner);
> -	return 0;
>  }
> -EXPORT_SYMBOL(bdi_register_owner);
>  
>  /*
>   * Remove bdi from bdi_list, and ensure that it is no longer visible
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
