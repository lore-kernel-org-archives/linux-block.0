Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42400C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E5320771
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634771AbgDPMHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634831AbgDPMHC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:07:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 475AEAC6D;
        Thu, 16 Apr 2020 12:06:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CFFC1E1250; Thu, 16 Apr 2020 14:06:59 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:06:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] bdi: simplify bdi_alloc
Message-ID: <20200416120659.GL23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-8-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 09:15:18, Christoph Hellwig wrote:
> Merge the _node vs normal version and drop the superflous gfp_t argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-core.c            | 2 +-
>  drivers/mtd/mtdcore.c       | 2 +-
>  fs/super.c                  | 2 +-
>  include/linux/backing-dev.h | 6 +-----
>  mm/backing-dev.c            | 7 +++----
>  5 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7e4a1da0715e..ab87f2833ab2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -484,7 +484,7 @@ struct request_queue *__blk_alloc_queue(int node_id)
>  	if (ret)
>  		goto fail_id;
>  
> -	q->backing_dev_info = bdi_alloc_node(GFP_KERNEL, node_id);
> +	q->backing_dev_info = bdi_alloc(node_id);
>  	if (!q->backing_dev_info)
>  		goto fail_split;
>  
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 2916674208b3..39ec563d9a14 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -2036,7 +2036,7 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
>  	struct backing_dev_info *bdi;
>  	int ret;
>  
> -	bdi = bdi_alloc(GFP_KERNEL);
> +	bdi = bdi_alloc(NUMA_NO_NODE);
>  	if (!bdi)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/super.c b/fs/super.c
> index cd352530eca9..dd28fcd706ff 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1598,7 +1598,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
>  	int err;
>  	va_list args;
>  
> -	bdi = bdi_alloc(GFP_KERNEL);
> +	bdi = bdi_alloc(NUMA_NO_NODE);
>  	if (!bdi)
>  		return -ENOMEM;
>  
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 4098ed6ba6b4..6b3504bf7a42 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -36,11 +36,7 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
>  void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
>  void bdi_unregister(struct backing_dev_info *bdi);
>  
> -struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
> -static inline struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
> -{
> -	return bdi_alloc_node(gfp_mask, NUMA_NO_NODE);
> -}
> +struct backing_dev_info *bdi_alloc(int node_id);
>  
>  void wb_start_background_writeback(struct bdi_writeback *wb);
>  void wb_workfn(struct work_struct *work);
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 1ba9a7b30933..119a41650833 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -865,12 +865,11 @@ static int bdi_init(struct backing_dev_info *bdi)
>  	return ret;
>  }
>  
> -struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
> +struct backing_dev_info *bdi_alloc(int node_id)
>  {
>  	struct backing_dev_info *bdi;
>  
> -	bdi = kmalloc_node(sizeof(struct backing_dev_info),
> -			   gfp_mask | __GFP_ZERO, node_id);
> +	bdi = kzalloc_node(sizeof(*bdi), GFP_KERNEL, node_id);
>  	if (!bdi)
>  		return NULL;
>  
> @@ -880,7 +879,7 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
>  	}
>  	return bdi;
>  }
> -EXPORT_SYMBOL(bdi_alloc_node);
> +EXPORT_SYMBOL(bdi_alloc);
>  
>  static struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
>  {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
