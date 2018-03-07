Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f51.google.com ([209.85.160.51]:45313 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbeCGCyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Mar 2018 21:54:19 -0500
Received: by mail-pl0-f51.google.com with SMTP id v9-v6so519179plp.12
        for <linux-block@vger.kernel.org>; Tue, 06 Mar 2018 18:54:19 -0800 (PST)
Subject: Re: [PATCH v2] bcache: move closure debug file into debug direcotry
To: Chengguang Xu <cgxu519@gmx.com>, tang.junhui@zte.com.cn,
        kent.overstreet@gmail.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1520235612-64749-1-git-send-email-cgxu519@gmx.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <aa3edd91-0d2c-4b8f-f291-4fbd9975a931@lyle.org>
Date: Tue, 6 Mar 2018 18:54:17 -0800
MIME-Version: 1.0
In-Reply-To: <1520235612-64749-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Sorry- I had to pull/unapply this actually.

On 03/04/2018 11:40 PM, Chengguang Xu wrote:
> -static struct dentry *debug
> +struct dentry *debug;

This conflicts with other symbols called "debug" and doesn't compile.
Please be sure that your patch set compiles before submitting.

Mike

>  
>  #ifdef CONFIG_BCACHE_DEBUG
>  
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 1a9fdab..b784292 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2133,7 +2133,6 @@ static int __init bcache_init(void)
>  	mutex_init(&bch_register_lock);
>  	init_waitqueue_head(&unregister_wait);
>  	register_reboot_notifier(&reboot);
> -	closure_debug_init();
>  
>  	bcache_major = register_blkdev(0, "bcache");
>  	if (bcache_major < 0) {
> @@ -2145,7 +2144,7 @@ static int __init bcache_init(void)
>  	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
>  	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
>  	    bch_request_init() ||
> -	    bch_debug_init(bcache_kobj) ||
> +	    bch_debug_init(bcache_kobj) || closure_debug_init() ||
>  	    sysfs_create_files(bcache_kobj, files))
>  		goto err;
>  
> 
