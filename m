Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:36924 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932600AbeCEIba (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Mar 2018 03:31:30 -0500
From: tang.junhui@zte.com.cn
To: cgxu519@gmx.com
Cc: mlyle@lyle.org, kent.overstreet@gmail.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH v2] bcache: move closure debug file into debug direcotry
Date: Mon, 5 Mar 2018 16:34:40 +0800
Message-Id: <1520238880-8595-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

LGTM.

Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>

> In current code closure debug file is outside of debug directory
> and when unloading module there is lack of removing operation
> for closure debug file, so it will cause creating error when trying
> to reload  module.
> 
> This patch move closure debug file into "bcache" debug direcory
> so that the file can get deleted properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
> Changes since v1:
> - Move closure debug file into "bcache" debug direcory instead of
> deleting it individually.
> - Change Signed-off-by mail address.
> 
>  drivers/md/bcache/closure.c | 9 +++++----
>  drivers/md/bcache/closure.h | 5 +++--
>  drivers/md/bcache/debug.c   | 2 +-
>  drivers/md/bcache/super.c   | 3 +--
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
> index 7f12920..64b123c 100644
> --- a/drivers/md/bcache/closure.c
> +++ b/drivers/md/bcache/closure.c
> @@ -157,7 +157,7 @@ void closure_debug_destroy(struct closure *cl)
>  }
>  EXPORT_SYMBOL(closure_debug_destroy);
>  
> -static struct dentry *debug;
> +static struct dentry *closure_debug;
>  
>  static int debug_seq_show(struct seq_file *f, void *data)
>  {
> @@ -199,11 +199,12 @@ static int debug_seq_open(struct inode *inode, struct file *file)
>      .release    = single_release
>  };
>  
> -void __init closure_debug_init(void)
> +int __init closure_debug_init(void)
>  {
> -    debug = debugfs_create_file("closures", 0400, NULL, NULL, &debug_ops);
> +    closure_debug = debugfs_create_file("closures",
> +                0400, debug, NULL, &debug_ops);
> +    return IS_ERR_OR_NULL(closure_debug);
>  }
> -
>  #endif
>  
>  MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
> diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
> index 3b9dfc9..0fb704d 100644
> --- a/drivers/md/bcache/closure.h
> +++ b/drivers/md/bcache/closure.h
> @@ -105,6 +105,7 @@
>  struct closure;
>  struct closure_syncer;
>  typedef void (closure_fn) (struct closure *);
> +extern struct dentry *debug;
>  
>  struct closure_waitlist {
>      struct llist_head    list;
> @@ -185,13 +186,13 @@ static inline void closure_sync(struct closure *cl)
>  
>  #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
>  
> -void closure_debug_init(void);
> +int closure_debug_init(void);
>  void closure_debug_create(struct closure *cl);
>  void closure_debug_destroy(struct closure *cl);
>  
>  #else
>  
> -static inline void closure_debug_init(void) {}
> +static inline int closure_debug_init(void) { return 0; }
>  static inline void closure_debug_create(struct closure *cl) {}
>  static inline void closure_debug_destroy(struct closure *cl) {}
>  
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index af89408..5db02de 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -17,7 +17,7 @@
>  #include <linux/random.h>
>  #include <linux/seq_file.h>
>  
> -static struct dentry *debug;
> +struct dentry *debug;
>  
>  #ifdef CONFIG_BCACHE_DEBUG
>  
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 1a9fdab..b784292 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2133,7 +2133,6 @@ static int __init bcache_init(void)
>      mutex_init(&bch_register_lock);
>      init_waitqueue_head(&unregister_wait);
>      register_reboot_notifier(&reboot);
> -    closure_debug_init();
>  
>      bcache_major = register_blkdev(0, "bcache");
>      if (bcache_major < 0) {
> @@ -2145,7 +2144,7 @@ static int __init bcache_init(void)
>      if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
>          !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
>          bch_request_init() ||
> -        bch_debug_init(bcache_kobj) ||
> +        bch_debug_init(bcache_kobj) || closure_debug_init() ||
>          sysfs_create_files(bcache_kobj, files))
>          goto err;
>  
> -- 
> 1.8.3.1

Thanks
Tang Junhui
