Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH] aio: Add memcg accounting of user used data
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, tj@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-aio@kvack.org, ktkhai@virtuozzo.com,
 jmoyer@redhat.com
Date: Tue, 05 Dec 2017 13:00:54 +0300
Message-ID: <151246799787.29619.13497559380263553588.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

Currently, number of available aio requests may be
limited only globally. There are two sysctl variables
aio_max_nr and aio_nr, which implement the limitation
and request accounting. They help to avoid
the situation, when all the memory is eaten in-flight
requests, which are written by slow block device,
and which can't be reclaimed by shrinker.

This meets the problem in case of many containers
are used on the hardware node. Since aio_max_nr is
a global limit, any container may occupy the whole
available aio requests, and to deprive others the
possibility to use aio at all. The situation may
happen because of evil intentions of the container's
user or because of the program error, when the user
makes this occasionally

The patch allows to fix the problem. It adds memcg
accounting of user used aio data (the biggest is
the bunch of aio_kiocb; ring buffer is the second
biggest), so a user of a certain memcg won't be able
to allocate more aio requests memory, then the cgroup
allows, and he will bumped into the limit.

This may be useful for LXC and for protection of some
critical microservices.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/aio.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index e6de7715228c..1431d0867a7e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -481,7 +481,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->ring_pages = ctx->internal_pages;
 	if (nr_pages > AIO_RING_PAGES) {
 		ctx->ring_pages = kcalloc(nr_pages, sizeof(struct page *),
-					  GFP_KERNEL);
+					  GFP_KERNEL_ACCOUNT);
 		if (!ctx->ring_pages) {
 			put_aio_ring_file(ctx);
 			return -ENOMEM;
@@ -490,8 +490,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
-		page = find_or_create_page(file->f_mapping,
-					   i, GFP_HIGHUSER | __GFP_ZERO);
+		page = find_or_create_page(file->f_mapping, i,
+				GFP_HIGHUSER | __GFP_ZERO | __GFP_ACCOUNT);
 		if (!page)
 			break;
 		pr_debug("pid(%d) page[%d]->count=%d\n",
@@ -670,7 +670,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 		spin_unlock(&mm->ioctx_lock);
 
 		table = kzalloc(sizeof(*table) + sizeof(struct kioctx *) *
-				new_nr, GFP_KERNEL);
+				new_nr, GFP_KERNEL_ACCOUNT);
 		if (!table)
 			return -ENOMEM;
 
@@ -740,7 +740,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (!nr_events || (unsigned long)max_reqs > aio_max_nr)
 		return ERR_PTR(-EAGAIN);
 
-	ctx = kmem_cache_zalloc(kioctx_cachep, GFP_KERNEL);
+	ctx = kmem_cache_zalloc(kioctx_cachep, GFP_KERNEL_ACCOUNT);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -1030,7 +1030,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 			return NULL;
 	}
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
+	req = kmem_cache_zalloc(kiocb_cachep, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!req))
 		goto out_put;
 
