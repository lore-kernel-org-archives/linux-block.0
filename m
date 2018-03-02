Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:49686 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164291AbeCBGcH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Mar 2018 01:32:07 -0500
From: tang.junhui@zte.com.cn
To: cgxu519@icloud.com
Cc: mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, tang.junhui@zte.com.cn
Subject: Re: [PATCH] bcache: remove closure debug file when unloading module
Date: Fri, 2 Mar 2018 14:34:33 +0800
Message-Id: <1519972473-8826-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello Chengguang

>When unloading bcache module there is lack of removing
>operation for closure debug file, so it will cause
>creating error when trying to reload module.
>

Yes, This issue is true. 
Actually, the original code try to remove closure debug file
by bch_debug_exit(), which remove all the debug file in
bcache directory, and closure debug file is expected to be
one debug file in bcache debug directory.

But currently code, closure_debug_init() is called to create
closure debug file before the bcache debug crated in 
bch_debug_init(), so closure debug file created outside
the bcache directory, then when bch_debug_exit() being called,
bcache diretory removed, but closure debug file didn't removed.

So the best way to resolve this issue is not remove the 
closure debug file again, but to take the closure debug file
under the bcache directory in debug sysfs.

>This fix introduces closure_debug_exit to handle removing
>operation properly.
>
>Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>---
> drivers/md/bcache/closure.c | 5 +++++
> drivers/md/bcache/closure.h | 2 ++
> drivers/md/bcache/super.c   | 2 ++
> 3 files changed, 9 insertions(+)
>
>diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
>index 7f12920..8fcd737 100644
>--- a/drivers/md/bcache/closure.c
>+++ b/drivers/md/bcache/closure.c
>@@ -204,6 +204,11 @@ void __init closure_debug_init(void)
>     debug = debugfs_create_file("closures", 0400, NULL, NULL, &debug_ops);
> }
> 
>+void closure_debug_exit(void)
>+{
>+    debugfs_remove(debug);
>+}
>+
> #endif
> 
> MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
>diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
>index 3b9dfc9..1aa0f7e 100644
>--- a/drivers/md/bcache/closure.h
>+++ b/drivers/md/bcache/closure.h
>@@ -186,12 +186,14 @@ static inline void closure_sync(struct closure *cl)
> #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> 
> void closure_debug_init(void);
>+void closure_debug_exit(void);
> void closure_debug_create(struct closure *cl);
> void closure_debug_destroy(struct closure *cl);
> 
> #else
> 
> static inline void closure_debug_init(void) {}
>+static inline void closure_debug_exit(void) {}
> static inline void closure_debug_create(struct closure *cl) {}
> static inline void closure_debug_destroy(struct closure *cl) {}
> 
>diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>index 1a9fdab..38e2e21 100644
>--- a/drivers/md/bcache/super.c
>+++ b/drivers/md/bcache/super.c
>@@ -2118,6 +2118,7 @@ static void bcache_exit(void)
>         destroy_workqueue(bcache_wq);
>     if (bcache_major)
>         unregister_blkdev(bcache_major, "bcache");
>+    closure_debug_exit();
>     unregister_reboot_notifier(&reboot);
>     mutex_destroy(&bch_register_lock);
> }
>@@ -2137,6 +2138,7 @@ static int __init bcache_init(void)
> 
>     bcache_major = register_blkdev(0, "bcache");
>     if (bcache_major < 0) {
>+        closure_debug_exit();
>         unregister_reboot_notifier(&reboot);
>         mutex_destroy(&bch_register_lock);
>         return bcache_major;
>-- 
>1.8.3.1

Thanks
Tang Junhui
