Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D44C4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EC023A03
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601233793;
	bh=DuuP9qAdch5bhxFG45lTJkF9yyZKUCn1A92utB70z8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SrkM2yBXFjPIV4KXNLTwRuLp0nY37GlrwOMt2Hus+wcaXJT1njXehUEqo3Zsc0NPh
	 g4KAup6If7vRkeoTHunn9z/8cybkxsQFTievpRwmcQj3BVfL0asWTTjTikVP9q5gGS
	 Nd7txtaSXnwHZRI5x6ry+hIwGa8EMgjwmpCXMkYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgI0TJw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 15:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0TJw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 15:09:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E5C0613CE;
        Sun, 27 Sep 2020 12:09:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id v14so2325033pjd.4;
        Sun, 27 Sep 2020 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LBMpruBnsZIrufCFvRBcjt88XqIw96hv7Z8FwDsXdYE=;
        b=L9QSfTkXJfKU5esFr3pkDpIEuB8FI+9UsnkEO7B6scwSbAyycoyGyUrUEofbWHg11U
         dLRx0VZuJ1w7DNaVj7I/xOg2BoTt1WQHFsb9UXK7qGtztg77b5lWFKJIz7FzyxisDrXH
         oPRqvWV6TNe3Zcoq2aHYpMXIO3V8eTJ+JVfQsd96mFup2LxHFt3s1ZwVmQsVTEaFjRjW
         V3+OpMZrrCC9K7fRb1q6muwFBykIXpT0afCBT2OlQoNuv/1qpBkRcCX9mgjDm+Ttabkw
         eWKcFdbhdtUGOHiz9xhPkC98LibVE1l/hBUOh5Wa9Jjp2m+PPOr/7xFsLNwD5qUEuOli
         jUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LBMpruBnsZIrufCFvRBcjt88XqIw96hv7Z8FwDsXdYE=;
        b=E6Bx+Bx753WK+1PZmyHuT0UWgiqCtZglw4KJKbdJNlbO9L/bn/1g+9e8tQxxo294xg
         WFPhsiYg6Vyb3H3YhyJrCQseLGRpoCXfSN3Qj/NGZQUNySPmfy0cCaYXnbRX3Lknk+ri
         o8LpldNoUazzzMRvOxLDV8on1Er5Puq+ylxVTJThLDfGMh39LKGSec4VfJhEfnHmWA3Y
         LKKEC1OcoyzCFWAitAHCDy/7BWfHRL1hCWUx4s/7FLDaGteV+FNGMe0UYDrqXbwPujO+
         7XYMZKJhdgDMtm3YD//1D0iH/iOTVbCU7myG7JVDhA4WnEY8YUVOI91ML3HJwhaZSVHX
         bByQ==
X-Gm-Message-State: AOAM5338jiOdvNTphqCGoY/g7zz3scGYby4DTCoSGyiIMYt3iYFBAyQm
        Y74xB2OPlC8ExLYa1jyfjQqZK6/j9H4mEg==
X-Google-Smtp-Source: ABdhPJzPcPjy0SRh283akmvoj1pQEKRb93U8pQFOU7T5JJqg1O8s32lJzlOsuLPKilyl2VDuxScx/A==
X-Received: by 2002:a17:90a:d246:: with SMTP id o6mr6651233pjw.211.1601233791747;
        Sun, 27 Sep 2020 12:09:51 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id w192sm8840301pfd.156.2020.09.27.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:09:50 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sun, 27 Sep 2020 12:09:48 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH v3] zram: add restriction on dynamic zram device creation
Message-ID: <20200927190948.GB422329@google.com>
References: <1600651821-46836-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600651821-46836-1-git-send-email-wang.yi59@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 21, 2020 at 09:30:21AM +0800, Yi Wang wrote:
> From: zhanglin <zhang.lin16@zte.com.cn>
> 
> Add max_num_devices to limit dynamic zram device creation to prevent
>  potential OOM
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  v1->v2:
>  change hard-coded initial max_num_devices into configurable way.
>  v2->v3:
>  Move inc/dec num_devices logic into zram_add/zram_remove.
> 
>  drivers/block/zram/Kconfig    |  7 +++++++
>  drivers/block/zram/zram_drv.c | 26 +++++++++++++++-----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..8455e5ec608b 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -37,3 +37,10 @@ config ZRAM_MEMORY_TRACKING
>  	  /sys/kernel/debug/zram/zramX/block_state.
>  
>  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
> +
> +config ZRAM_DEV_MAX_COUNT
> +	int "Max number of zram devices to be created"
> +	depends on ZRAM
> +	default 256
> +	help
> +	  This option specifies the maximum number of zram devices.
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 36d49159140f..5e8978095d68 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -43,8 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = "lzo-rle";
>  
> +static unsigned int num_devices;
>  /* Module params (documentation at end) */
> -static unsigned int num_devices = 1;
> +static unsigned int max_num_devices = CONFIG_ZRAM_DEV_MAX_COUNT;
>  /*
>   * Pages that compress to sizes equals or greater than this are stored
>   * uncompressed in memory.
> @@ -1878,6 +1879,9 @@ static int zram_add(void)
>  	struct request_queue *queue;
>  	int ret, device_id;
>  
> +	if (num_devices >= max_num_devices)
> +		return -ENOSPC;
> +
>  	zram = kzalloc(sizeof(struct zram), GFP_KERNEL);
>  	if (!zram)
>  		return -ENOMEM;
> @@ -1955,6 +1959,7 @@ static int zram_add(void)
>  	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
>  
>  	zram_debugfs_register(zram);
> +	num_devices += 1;
>  	pr_info("Added device: %s\n", zram->disk->disk_name);
>  	return device_id;
>  
> @@ -1998,6 +2003,7 @@ static int zram_remove(struct zram *zram)
>  	blk_cleanup_queue(zram->disk->queue);
>  	put_disk(zram->disk);
>  	kfree(zram);
> +	num_devices -= 1;
>  	return 0;
>  }
>  
> @@ -2111,14 +2117,12 @@ static int __init zram_init(void)
>  		return -EBUSY;
>  	}
>  
> -	while (num_devices != 0) {
> -		mutex_lock(&zram_index_mutex);
> -		ret = zram_add();
> -		mutex_unlock(&zram_index_mutex);
> -		if (ret < 0)
> -			goto out_error;
> -		num_devices--;
> -	}
> +	mutex_lock(&zram_index_mutex);
> +	num_devices = 0;
> +	ret = zram_add();
> +	mutex_unlock(&zram_index_mutex);
> +	if (ret < 0)
> +		goto out_error;
>  
>  	return 0;
>  
> @@ -2135,8 +2139,8 @@ static void __exit zram_exit(void)
>  module_init(zram_init);
>  module_exit(zram_exit);
>  
> -module_param(num_devices, uint, 0);
> -MODULE_PARM_DESC(num_devices, "Number of pre-created zram devices");

Why did you remove num_devices? It's orthgonal with max_num_devices.
If we remove it, users have been used it to create pre-created zram
device will be broken.

If user asked it more than max_num_devices, we could just return the error
in zram_init with simple pr_err to notice configuration wrong.


> +module_param(max_num_devices, uint, 0);
> +MODULE_PARM_DESC(max_num_devices, "Max number of zram devices to be created");
>  
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Nitin Gupta <ngupta@vflare.org>");
> -- 
> 2.17.1


