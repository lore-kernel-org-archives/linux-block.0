Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD1C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D485A20786
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441462AbgDPMXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:23:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439151AbgDPMX3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A92BCAC6D;
        Thu, 16 Apr 2020 12:23:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B32BD1E1250; Thu, 16 Apr 2020 14:23:25 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:23:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] bdi: remove the name field in struct backing_dev_info
Message-ID: <20200416122325.GM23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 09:15:19, Christoph Hellwig wrote:
> The name is only printed for a not registered bdi in writeback.  Use the
> device name there as is more useful anyway for the unlike case that the
> warning triggers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Ah, cool. So it isn't used in sysfs/debugfs as I was afraid. The patch
looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c                 | 1 -
>  drivers/mtd/mtdcore.c            | 1 -
>  fs/fs-writeback.c                | 2 +-
>  fs/super.c                       | 2 --
>  include/linux/backing-dev-defs.h | 2 --
>  mm/backing-dev.c                 | 1 -
>  6 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ab87f2833ab2..f37068c611bf 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -494,7 +494,6 @@ struct request_queue *__blk_alloc_queue(int node_id)
>  
>  	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
>  	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
> -	q->backing_dev_info->name = "block";
>  	q->node = node_id;
>  
>  	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 39ec563d9a14..fcb018ce17c3 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -2040,7 +2040,6 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
>  	if (!bdi)
>  		return ERR_PTR(-ENOMEM);
>  
> -	bdi->name = name;
>  	/*
>  	 * We put '-0' suffix to the name to get the same name format as we
>  	 * used to get. Since this is called only once, we get a unique name. 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 76ac9c7d32ec..d85323607b49 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2320,7 +2320,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
>  			     !test_bit(WB_registered, &wb->state),
> -			     "bdi-%s not registered\n", wb->bdi->name);
> +			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
>  
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
> diff --git a/fs/super.c b/fs/super.c
> index dd28fcd706ff..4991f441988e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1602,8 +1602,6 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
>  	if (!bdi)
>  		return -ENOMEM;
>  
> -	bdi->name = sb->s_type->name;
> -
>  	va_start(args, fmt);
>  	err = bdi_register_va(bdi, fmt, args);
>  	va_end(args);
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 249590bcccf7..0a55170b2142 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -194,8 +194,6 @@ struct backing_dev_info {
>  	congested_fn *congested_fn; /* Function pointer if device is md/dm */
>  	void *congested_data;	/* Pointer to aux data for congested func */
>  
> -	const char *name;
> -
>  	struct kref refcnt;	/* Reference counter for the structure */
>  	unsigned int capabilities; /* Device capabilities */
>  	unsigned int min_ratio;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 119a41650833..dc7215dfd56b 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -15,7 +15,6 @@
>  #include <trace/events/writeback.h>
>  
>  struct backing_dev_info noop_backing_dev_info = {
> -	.name		= "noop",
>  	.capabilities	= BDI_CAP_NO_ACCT_AND_WRITEBACK,
>  };
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
