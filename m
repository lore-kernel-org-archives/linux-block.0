Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933206AbeCGDYS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Mar 2018 22:24:18 -0500
MIME-Version: 1.0
Message-ID: <trinity-7b70affd-3b22-4af5-a5db-27015b3b8485-1520393043604@3c-app-mailcom-bs15>
From: "Chengguang Xu" <cgxu519@gmx.com>
To: "Michael Lyle" <mlyle@lyle.org>
Cc: tang.junhui@zte.com.cn, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] bcache: move closure debug file into debug direcotry
Content-Type: text/plain; charset=UTF-8
Date: Wed, 7 Mar 2018 04:24:03 +0100
In-Reply-To: <aa3edd91-0d2c-4b8f-f291-4fbd9975a931@lyle.org>
References: <1520235612-64749-1-git-send-email-cgxu519@gmx.com>
 <aa3edd91-0d2c-4b8f-f291-4fbd9975a931@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Mike

I'm really sorry for the inconvenient, in my test box it can compile with no error,
so I didn't notice that before, I've sent modified v2 version for the problem.


> Sent: Wednesday, March 07, 2018 at 10:54 AM
> From: "Michael Lyle" <mlyle@lyle.org>
> To: "Chengguang Xu" <cgxu519@gmx.com>, tang.junhui@zte.com.cn, kent.overstreet@gmail.com
> Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
> Subject: Re: [PATCH v2] bcache: move closure debug file into debug direcotry
>
> Sorry- I had to pull/unapply this actually.
> 
> On 03/04/2018 11:40 PM, Chengguang Xu wrote:
> > -static struct dentry *debug
> > +struct dentry *debug;
> 
> This conflicts with other symbols called "debug" and doesn't compile.
> Please be sure that your patch set compiles before submitting.
> 
> Mike
> 
> >  
> >  #ifdef CONFIG_BCACHE_DEBUG
> >  
> > diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> > index 1a9fdab..b784292 100644
> > --- a/drivers/md/bcache/super.c
> > +++ b/drivers/md/bcache/super.c
> > @@ -2133,7 +2133,6 @@ static int __init bcache_init(void)
> >  	mutex_init(&bch_register_lock);
> >  	init_waitqueue_head(&unregister_wait);
> >  	register_reboot_notifier(&reboot);
> > -	closure_debug_init();
> >  
> >  	bcache_major = register_blkdev(0, "bcache");
> >  	if (bcache_major < 0) {
> > @@ -2145,7 +2144,7 @@ static int __init bcache_init(void)
> >  	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
> >  	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
> >  	    bch_request_init() ||
> > -	    bch_debug_init(bcache_kobj) ||
> > +	    bch_debug_init(bcache_kobj) || closure_debug_init() ||
> >  	    sysfs_create_files(bcache_kobj, files))
> >  		goto err;
> >  
> > 
> 
> 
