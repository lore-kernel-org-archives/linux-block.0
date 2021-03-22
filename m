Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B0C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 20:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E29B61992
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 20:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhCVUmC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 16:42:02 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:45875 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCVUl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 16:41:59 -0400
Received: by mail-pg1-f181.google.com with SMTP id n11so9508821pgm.12;
        Mon, 22 Mar 2021 13:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=en4BQ34M1pxK6UhaUManP95I8NvkTcLNHNMPfN5mTrk=;
        b=l/A5ztbOE1YnLJSJWKDOmQRD2TpANKsj/sTR8R443/MscqXWvJF40pagQCw5kuMvk2
         /0gCpW0KAjbFbId0REenhOQTcSFfwOsxXZRLROO0p3YIgDJ3Oi3b4Ok6JrRJ8b0s/WYT
         ubSvC29iURLvtdikgfjZ7ZopTcV8367ckcXcYU++48cnYg4ODKd8dj6p9o/6jmxSMPRg
         CDB5/dDT3guxVLNZekRvfcTxPaOVNbMI66oxBbFU8cxJ2opz/6Qrb/iWZw6NmOpvPpCZ
         sbUSV3aqHBWdYaH5wuA6whb383hrPN/17cgqigfFWwo54lFk8ZQoBXfLCoe4p35ZWCgI
         i+Sg==
X-Gm-Message-State: AOAM533jQUho/rdJJo/CiEUTr9VKLUPkoXhp/WNbF7zI4Q0Flgyoko0r
        k+DbjvMpwpVx3nG7e5zchq7dEo6LdZqaXQ==
X-Google-Smtp-Source: ABdhPJz4ZexGvP5u+pS3OTDRw79cR4+USKtVGpeiwSfCqbL9opr3uYZZ0Wd9n9Jh2kvRtBpqG6LGPw==
X-Received: by 2002:a62:f207:0:b029:1f6:11a4:1b81 with SMTP id m7-20020a62f2070000b02901f611a41b81mr1544622pfh.19.1616445719186;
        Mon, 22 Mar 2021 13:41:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t22sm279319pjw.54.2021.03.22.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:41:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AED65402A1; Mon, 22 Mar 2021 20:41:56 +0000 (UTC)
Date:   Mon, 22 Mar 2021 20:41:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210322204156.GM4332@42.do-not-panic.com>
References: <20210306022035.11266-1-mcgrof@kernel.org>
 <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjHvUolScp3btJ9@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 09:37:17AM -0700, Minchan Kim wrote:
> On Fri, Mar 19, 2021 at 07:09:24PM +0000, Luis Chamberlain wrote:
> > Indeed one issue is a consequence of the other but a bit better
> > description can be put together for both separately.
> > 
> > The warning comes up when cpu hotplug detects that the callback
> > is being removed, but yet "instances" for multistate are left behind,
> > ie, not removed. CPU hotplug multistate allows us to dedicate a callback
> > for zram so that it gets called every time a CPU hot plugs or unplugs.
> > In the zram driver's case we want to trigger the callback per each
> > struct zcomp, one is used per supported and used supported compression
> 
>      you meant "each one is used per supported compression"?

Yup.

> > algorithm. The zram driver allocates a struct zcomp for an compression
> > algorithm on a need basis. The default compressor is CONFIG_ZRAM_DEF_COMP
> > which today is CONFIG_ZRAM_DEF_COMP_LZORLE ("lzo-rle"). Although we may
> > have different zram devices, zram devices which use the same compression
> > algorithm share the same struct zcomp. The "multi" in CPU hotplug multstate
> 
> It allocates each own zcomp, not sharing even though zram devices
> use the same compression algorithm.

Right.

> > refers to these different struct zcomp instances, each of these will
> > have the callback routine registered run for it. The kernel's CPU
> > hotplug multistate keeps a linked list of these different structures
> > so that it will iterate over them on CPU transitions. By default at
> > driver initialization we will create just one zram device (num_devices=1)
> > and a zcomp structure then set for the lzo-rle comrpession algorithm.
> > At driver removal we first remove each zram device, and so we destroy
> > the struct zcomp. But since we expose sysfs attributes to create new
> > devices or reset / initialize existing ones, we can easily end up
> > re-initializing a struct zcomp before the exit routine of the module
> > removes the cpu hotplug callback. When this happens the kernel's
> > CPU hotplug will detect that at least one instance (struct zcomp for
> > us) exists.
> 
> It's very helpful to understand. Thanks a lot!S
> 
> So IIUC, it's fundamentally race between destroy_devices(i.e., module
> unload) and every sysfs knobs in zram. Isn't it?

I would not call it *every* syfs knob as not all deal with things which
are related to CPU hotplug multistate, right? Note that using just
try_module_get() alone (that is the second patch only, does not fix the
race I am describing above).

There are two issues.

> Below specific example is one of them and every sysfs code in zram
> could access freed object(e.g., zram->something).
> And you are claiming there isn't good way to fix it in kernfs(please
> add it in the description, too) even though it's general problem.

Correct, the easier route would have been through the block layer as
its the one adding our syfs attributes for us but even it canno deal
with this race on behalf of drivers given the currently exposed
semantics on kernfs.

> (If we had, we may detect the race and make zram_remove_cb fails
> so unloading modulies fails, finally)
> 
> So, shouldn't we introcude a global rw_semaphore?
> 
> destroy_devices
>   class_unregister
>   down_write(&zram_unload);
>   idr_for_each(zram_remove_cb);
>   up_write(&zram_unload);
> 
> And every sysfs code hold the lock with down_read in the first place
> and release the lock right before return. So, introduce a zram sysfs
> wrapper to centralize all of locking logic.

Actually that does work but only if we use write lock attempts so to
be able to knock two birds with one stone, so to address the deadlock
with sysfs attribute removal. We're not asking politely to read some
value off of a zram devices with these locks, we're ensuring to not
run if our driver is going to be removed, so replacing the
try_module_get() with something similar.

> Does it make sense?
> 
> > 
> > And so we can have:
> > 
> > static void destroy_devices(void)
> > {
> > 	class_unregister(&zram_control_class);
> > 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
> > 	zram_debugfs_destroy();
> > 	idr_destroy(&zram_index_idr);
> > 	unregister_blkdev(zram_major, "zram");
> > 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
> > }
> > 
> > While destroy_devices() runs we can have this race:
> > 
> > 
> > CPU 1                            CPU 2
> > 
> > class_unregister(...);
> > idr_for_each(...);
> 				  I think sysfs was already remove here.
> > zram_debugfs_destroy();
> >                                 disksize_store(...)
> > idr_destroy(...);
> > unregister_blkdev(...);
> > cpuhp_remove_multi_state(...);
> 
> So,
> 
> 	CPU 1                            CPU 2
>  
> destroy_devices
> ..
> 				 disksize_store()
> 				   zcomp_create
> 				   zcomp_init
> idr_for_each(zram_remove_cb
>   zram_remove
>   zram_reset
>   zcomp_destroy
>   cpuhp_state_remove_instance
> 				   cpuhp_state_add_instance
> ..
> 
> cpuhp_remove_multi_state(...)
>   Detect!
>     kernel: Error: Removing state 63 which has instances left.

Yup true.

> > The warning comes up on cpuhp_remove_multi_state() when it sees
> > that the state for CPUHP_ZCOMP_PREPARE does not have an empty
> > instance linked list.
> > 
> > After the idr_destory() its also easy to run into a crash. The
> > above predicament also leads to memory leaks.
> > 
> > And so we need to have a state machine for when we're up and when
> > we're going down generically.
> > 
> > Let me know if it makes sense now, if so I can amend the commit log
> > accordingly.
> 
> Yub, It's much better. Let's have it in the commit log.

Sure OK, well the following is what I end up with. With this approach
only one patch is needed.

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a711a2e2a794..3b86ee94309e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,6 +41,15 @@ static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
 
+/*
+ * Protects against:
+ * a) Hotplug cpu multistate races against compression algorithm removals
+ *    and additions prior to its removal of the zram CPU hotplug callback
+ * b) Deadlock which is possible when sysfs attributes are used and we
+ *    share a lock on removal.
+ */
+DECLARE_RWSEM(zram_unload);
+
 static int zram_major;
 static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
@@ -1723,6 +1732,9 @@ static ssize_t disksize_store(struct device *dev,
 	if (!disksize)
 		return -EINVAL;
 
+	if (!down_write_trylock(&zram_unload))
+		return -ENODEV;
+
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
 		pr_info("Cannot change disksize for initialized device\n");
@@ -1748,6 +1760,7 @@ static ssize_t disksize_store(struct device *dev,
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
+	up_write(&zram_unload);
 
 	return len;
 
@@ -1755,6 +1768,7 @@ static ssize_t disksize_store(struct device *dev,
 	zram_meta_free(zram, disksize);
 out_unlock:
 	up_write(&zram->init_lock);
+	up_write(&zram_unload);
 	return err;
 }
 
@@ -1773,14 +1787,17 @@ static ssize_t reset_store(struct device *dev,
 	if (!do_reset)
 		return -EINVAL;
 
+	if (!down_write_trylock(&zram_unload))
+		return -ENODEV;
+
 	zram = dev_to_zram(dev);
 	bdev = zram->disk->part0;
 
 	mutex_lock(&bdev->bd_mutex);
 	/* Do not reset an active device or claimed device */
 	if (bdev->bd_openers || zram->claim) {
-		mutex_unlock(&bdev->bd_mutex);
-		return -EBUSY;
+		len = -EBUSY;
+		goto out;
 	}
 
 	/* From now on, anyone can't open /dev/zram[0-9] */
@@ -1793,7 +1810,10 @@ static ssize_t reset_store(struct device *dev,
 
 	mutex_lock(&bdev->bd_mutex);
 	zram->claim = false;
+
+out:
 	mutex_unlock(&bdev->bd_mutex);
+	up_write(&zram_unload);
 
 	return len;
 }
@@ -2015,10 +2035,15 @@ static ssize_t hot_add_show(struct class *class,
 {
 	int ret;
 
+	if (!down_write_trylock(&zram_unload))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 	ret = zram_add();
 	mutex_unlock(&zram_index_mutex);
 
+	up_write(&zram_unload);
+
 	if (ret < 0)
 		return ret;
 	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
@@ -2041,6 +2066,9 @@ static ssize_t hot_remove_store(struct class *class,
 	if (dev_id < 0)
 		return -EINVAL;
 
+	if (!down_write_trylock(&zram_unload))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	zram = idr_find(&zram_index_idr, dev_id);
@@ -2053,6 +2081,7 @@ static ssize_t hot_remove_store(struct class *class,
 	}
 
 	mutex_unlock(&zram_index_mutex);
+	up_write(&zram_unload);
 	return ret ? ret : count;
 }
 static CLASS_ATTR_WO(hot_remove);
@@ -2078,12 +2107,14 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 
 static void destroy_devices(void)
 {
+	down_write(&zram_unload);
 	class_unregister(&zram_control_class);
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	zram_debugfs_destroy();
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+	up_write(&zram_unload);
 }
 
 static int __init zram_init(void)
@@ -2095,10 +2126,13 @@ static int __init zram_init(void)
 	if (ret < 0)
 		return ret;
 
+	down_write(&zram_unload);
+
 	ret = class_register(&zram_control_class);
 	if (ret) {
 		pr_err("Unable to register zram-control class\n");
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		up_write(&zram_unload);
 		return ret;
 	}
 
@@ -2108,6 +2142,7 @@ static int __init zram_init(void)
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		up_write(&zram_unload);
 		return -EBUSY;
 	}
 
@@ -2119,10 +2154,12 @@ static int __init zram_init(void)
 			goto out_error;
 		num_devices--;
 	}
+	up_write(&zram_unload);
 
 	return 0;
 
 out_error:
+	up_write(&zram_unload);
 	destroy_devices();
 	return ret;
 }
