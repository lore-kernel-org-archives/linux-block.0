Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH 3/5] blkcg: Add blkcg::blkg_aio_nr and blkcg::blkg_aio_max_nr
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:13:18 +0300
Message-ID: <151240399812.10164.2619089470139011328.stgit@localhost.localdomain>
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

This adds new members of struct blkcg, which will
be used to account numbers of cgroup's aio requests.

Also, blkcg_root is used to store sysctl variables
aio_nr and aio_max_nr.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-cgroup.c         |    4 ++++
 fs/aio.c                   |    2 ++
 include/linux/aio.h        |    6 ++++++
 include/linux/blk-cgroup.h |    4 ++++
 4 files changed, 16 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d3f56baee936..774560469b01 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -27,6 +27,7 @@
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/blk-cgroup.h>
+#include <linux/aio.h>
 #include "blk.h"
 
 #define MAX_KEY_LEN 100
@@ -1101,6 +1102,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
+#endif
+#ifdef CONFIG_AIO
+	blkcg->blkg_aio_max_nr = parent_css ? AIO_NR_INF : AIO_NR_DEF;
 #endif
 	list_add_tail(&blkcg->all_blkcgs_node, &all_blkcgs);
 
diff --git a/fs/aio.c b/fs/aio.c
index 9dc98a29077c..755f97a42ebe 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -189,10 +189,12 @@ struct aio_kiocb {
 };
 
 DEFINE_SPINLOCK(aio_nr_lock);
+#ifndef CONFIG_BLK_CGROUP
 /*------ sysctl variables----*/
 unsigned long aio_nr;		/* current system wide number of aio requests */
 unsigned long aio_max_nr = AIO_NR_DEF; /* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
+#endif
 
 static struct kmem_cache	*kiocb_cachep;
 static struct kmem_cache	*kioctx_cachep;
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 5dda2663802f..de929a8c9c59 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX__AIO_H
 #define __LINUX__AIO_H
 
+#include <linux/blk-cgroup.h>
 #include <linux/aio_abi.h>
 
 struct kioctx;
@@ -26,8 +27,13 @@ static inline void kiocb_set_cancel_fn(struct kiocb *req,
 				       kiocb_cancel_fn *cancel) { }
 #endif /* CONFIG_AIO */
 
+#if !defined(CONFIG_BLK_CGROUP) || !defined(CONFIG_AIO)
 /* for sysctl: */
 extern unsigned long aio_nr;
 extern unsigned long aio_max_nr;
+#else
+#define aio_nr		blkcg_root.blkg_aio_nr
+#define aio_max_nr	blkcg_root.blkg_aio_max_nr
+#endif /* !CONFIG_BLK_CGROUP || !CONFIG_AIO */
 
 #endif /* __LINUX__AIO_H */
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 8bbc3716507a..3d9c176fc173 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -55,6 +55,10 @@ struct blkcg {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
 #endif
+#ifdef CONFIG_AIO
+	unsigned long			blkg_aio_nr;
+	unsigned long			blkg_aio_max_nr;
+#endif
 };
 
 /*
