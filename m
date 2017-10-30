Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbdJ3NBR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2017 09:01:17 -0400
Date: Mon, 30 Oct 2017 14:01:14 +0100
From: Jan Kara <jack@suse.cz>
To: weiping zhang <zhangweiping@didichuxing.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] bdi: convert bdi_debug_register to int
Message-ID: <20171030130114.GH23278@quack2.suse.cz>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
 <2c475848d5aa52f54e7c2440a0f5b06791980aac.1509038624.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c475848d5aa52f54e7c2440a0f5b06791980aac.1509038624.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri 27-10-17 01:35:57, weiping zhang wrote:
> Convert bdi_debug_register to int and then do error handle for it.
> 
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

This patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/backing-dev.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 5072be19d9b2..e9d6a1ede12b 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -116,11 +116,23 @@ static const struct file_operations bdi_debug_stats_fops = {
>  	.release	= single_release,
>  };
>  
> -static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> +static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
>  {
> +	if (!bdi_debug_root)
> +		return -ENOMEM;
> +
>  	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
> +	if (!bdi->debug_dir)
> +		return -ENOMEM;
> +
>  	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
>  					       bdi, &bdi_debug_stats_fops);
> +	if (!bdi->debug_stats) {
> +		debugfs_remove(bdi->debug_dir);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
>  }
>  
>  static void bdi_debug_unregister(struct backing_dev_info *bdi)
> @@ -133,9 +145,10 @@ static inline int bdi_debug_init(void)
>  {
>  	return 0;
>  }
> -static inline void bdi_debug_register(struct backing_dev_info *bdi,
> +static inline int bdi_debug_register(struct backing_dev_info *bdi,
>  				      const char *name)
>  {
> +	return 0;
>  }
>  static inline void bdi_debug_unregister(struct backing_dev_info *bdi)
>  {
> -- 
> 2.14.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
