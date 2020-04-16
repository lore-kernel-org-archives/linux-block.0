Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CEC2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E070621974
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 12:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635551AbgDPMcY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:32:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635446AbgDPMcR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 08:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 322ADAC6D;
        Thu, 16 Apr 2020 12:32:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 117861E1250; Thu, 16 Apr 2020 14:32:15 +0200 (CEST)
Date:   Thu, 16 Apr 2020 14:32:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] bdi: move bdi_dev_name out of line
Message-ID: <20200416123215.GO23739@quack2.suse.cz>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 09:15:12, Christoph Hellwig wrote:
> bdi_dev_name is not a fast path function, move it out of line.  This
> prepares for using it from modular callers without having to export
> an implementation detail like bdi_unknown_name.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev.h |  9 +--------
>  mm/backing-dev.c            | 10 +++++++++-
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index f88197c1ffc2..c9ad5c3b7b4b 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -505,13 +505,6 @@ static inline int bdi_rw_congested(struct backing_dev_info *bdi)
>  				  (1 << WB_async_congested));
>  }
>  
> -extern const char *bdi_unknown_name;
> -
> -static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
> -{
> -	if (!bdi || !bdi->dev)
> -		return bdi_unknown_name;
> -	return dev_name(bdi->dev);
> -}
> +const char *bdi_dev_name(struct backing_dev_info *bdi);
>  
>  #endif	/* _LINUX_BACKING_DEV_H */
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index c81b4f3a7268..c2c44c89ee5d 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -21,7 +21,7 @@ struct backing_dev_info noop_backing_dev_info = {
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>  
>  static struct class *bdi_class;
> -const char *bdi_unknown_name = "(unknown)";
> +static const char *bdi_unknown_name = "(unknown)";
>  
>  /*
>   * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
> @@ -1043,6 +1043,14 @@ void bdi_put(struct backing_dev_info *bdi)
>  }
>  EXPORT_SYMBOL(bdi_put);
>  
> +const char *bdi_dev_name(struct backing_dev_info *bdi)
> +{
> +	if (!bdi || !bdi->dev)
> +		return bdi_unknown_name;
> +	return dev_name(bdi->dev);
> +}
> +EXPORT_SYMBOL_GPL(bdi_dev_name);
> +
>  static wait_queue_head_t congestion_wqh[2] = {
>  		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[0]),
>  		__WAIT_QUEUE_HEAD_INITIALIZER(congestion_wqh[1])
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
