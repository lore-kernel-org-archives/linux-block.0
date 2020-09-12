Return-Path: <SRS0=0HSq=CV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EAAC43461
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4581F221E3
	for <linux-block@archiver.kernel.org>; Sat, 12 Sep 2020 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599868976;
	bh=4FyXfKqNmAJFIS1CEdxrIQDMw/kd2aRpal3IrGy0bk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bb7DgiuQ23JZbHh4EtsRMKOZO6FUi9iI5RG3xH9dWqhtlQZh4huux4bOeA7zXM155
	 eWgZ0ATUqxIXV+cszBWIwcy4lEiTpvoLynAmz6GpaBKwH14JSahc95igxAiJwWV+8f
	 GMfCGT7gdcIi4MnZ6GBMlxZcWAlABwg2qBOVqiYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgILACy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 20:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgILACw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 20:02:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F93C061573;
        Fri, 11 Sep 2020 17:02:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so1629235pln.10;
        Fri, 11 Sep 2020 17:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VttaX1A00Pahmg8+r6CiupaE28pM+dQX7m2r1VjFaaM=;
        b=EvSL3xeB2q19zVXQhLdk/tFdLI4gAf7ncmQ9OEfrrCn+prPId0cmJheZmxhG8N1jkg
         3wk6shMhZ2wmD76CfHRes8WIoexCxDrCOraCFZuOVYtakl2fFxTdA+aOx9ThTPWsII+1
         rKynAuIRB47/PEyqcQmT3pnOAjHdHgm9hMa6JqirhN4Jhot87kzntZVKSEpVMZPMDq00
         pqaht20vuCRa74oa7UJAf3SLg18h5S8SDCK3LyOPOFNfblxaCjK4Ete2SRlpmlNH4Lla
         UuRqcB5BhVP9fCKhduVX2LaB3Gg4QIc2AbRY7CMQxUNxaFEVipVTvQPNAbyggMv9lPkp
         ZF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VttaX1A00Pahmg8+r6CiupaE28pM+dQX7m2r1VjFaaM=;
        b=sfQO2A/v73qbfYs8kZC3TBgDiL0iy4GZFDS80G+XcLl7AMYdHObOjiIC30IVSaLgqq
         aTmXQp+3Mh+DfcOMn0iY9UDZnl7Qjp893Nz2kanm7Llk0ieyR80X5ybES7hvoxT4XoDD
         Jkhnq5d5pzpM69FjZAd8llQjI3hcu+7mzWDCbkz8HCcYhulq+XG5lXrHYP1Zf0O8rJ12
         y3VADEclysZSMuPdI20Eid37+3BC5PlVA+rdSwxBHz7zt2gpsY3LwCgom8R5O4uoeIW/
         iPH7GDn1LduO9wP3rzMFDQtGGVXebKVUFGxtw+wSws3jnWL0FkNlDxpKpuDajR1BMbkp
         OUxg==
X-Gm-Message-State: AOAM5322yIqdxMUj1mGZnknad5+7PKUEET9fqgup3tw3koJswyCApNxI
        mYGH8KOnehhnh4yJil2A91o=
X-Google-Smtp-Source: ABdhPJzf9K8rlIAbfCZ9/ub64g9JxG2ztfJcWoiD/ZtQRmGSaSZoJAer59y0IYOX7BvbwBMyzEjzNQ==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr4576780pll.106.1599868971959;
        Fri, 11 Sep 2020 17:02:51 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id l5sm2517494pga.43.2020.09.11.17.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:02:50 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:02:48 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH v2] zram: add restriction on dynamic zram device creation
Message-ID: <20200912000248.GA2447117@google.com>
References: <1599209530-41015-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599209530-41015-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

On Fri, Sep 04, 2020 at 04:52:10PM +0800, Yi Wang wrote:
> From: zhanglin <zhang.lin16@zte.com.cn>
> 
> Add max_num_devices to limit dynamic zram device creation to prevent
>  potential OOM
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> v1->v2:
> change hard-coded initial max_num_devices into configurable way.
> 
>  drivers/block/zram/Kconfig    |  7 +++++++
>  drivers/block/zram/zram_drv.c | 28 +++++++++++++++++++++-------
>  2 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index fe7a4b7d30cf..54a369932417 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -37,3 +37,10 @@ config ZRAM_MEMORY_TRACKING
>  	  /sys/kernel/debug/zram/zramX/block_state.
>  
>  	  See Documentation/admin-guide/blockdev/zram.rst for more information.
> +
> +config ZRAM_DEV_MAX_COUNT
> +	int "Number of zram devices to be created"
> +	depends on ZRAM
> +	default 256
> +	help
> +	  This option specifies the maximum number of zram devices.
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 36d49159140f..d1022f3c04c4 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -43,8 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = "lzo-rle";
>  
> -/* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
> +/* Module params (documentation at end) */
> +static unsigned int max_num_devices = CONFIG_ZRAM_DEV_MAX_COUNT;
>  /*
>   * Pages that compress to sizes equals or greater than this are stored
>   * uncompressed in memory.
> @@ -2013,10 +2014,16 @@ static ssize_t hot_add_show(struct class *class,
>  			struct class_attribute *attr,
>  			char *buf)
>  {
> -	int ret;
> +	int ret = -ENOSPC;
>  
>  	mutex_lock(&zram_index_mutex);
> +	if (num_devices >= max_num_devices) {
> +		mutex_unlock(&zram_index_mutex);
> +		return ret;
> +	}
>  	ret = zram_add();

> +	if (ret >= 0)
> +		num_devices += 1;

Let's have the num_devices inc/dec in zram_add/zram_remove so any caller
doesn't need to take care of it.

>  	mutex_unlock(&zram_index_mutex);
>  
>  	if (ret < 0)
> @@ -2046,8 +2053,10 @@ static ssize_t hot_remove_store(struct class *class,
>  	zram = idr_find(&zram_index_idr, dev_id);
>  	if (zram) {
>  		ret = zram_remove(zram);
> -		if (!ret)
> +		if (!ret) {
>  			idr_remove(&zram_index_idr, dev_id);
> +			num_devices -= 1;
> +		}
>  	} else {
>  		ret = -ENODEV;
>  	}
> @@ -2089,6 +2098,7 @@ static void destroy_devices(void)
>  static int __init zram_init(void)
>  {
>  	int ret;
> +	unsigned int i;
>  
>  	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
>  				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
> @@ -2111,13 +2121,17 @@ static int __init zram_init(void)
>  		return -EBUSY;
>  	}
>  
> -	while (num_devices != 0) {
> +	if (num_devices > max_num_devices) {
> +		pr_err("Number of pre-created zram devices over limit\n");
> +		goto out_error;
> +	}
> +
> +	for (i = 0; i < num_devices; i++) {
>  		mutex_lock(&zram_index_mutex);
>  		ret = zram_add();
>  		mutex_unlock(&zram_index_mutex);
>  		if (ret < 0)
>  			goto out_error;
> -		num_devices--;
>  	}
>  
>  	return 0;
> @@ -2135,8 +2149,8 @@ static void __exit zram_exit(void)
>  module_init(zram_init);
>  module_exit(zram_exit);
>  
> -module_param(num_devices, uint, 0);
> -MODULE_PARM_DESC(num_devices, "Number of pre-created zram devices");
> +module_param(max_num_devices, uint, 0);
> +MODULE_PARM_DESC(max_num_devices, "Max number of created zram devices");

How about this?
"Max number of zram devices to be created"

>  
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Nitin Gupta <ngupta@vflare.org>");
> -- 
> 2.17.1
> 
