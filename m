Return-Path: <neilb@suse.de>
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu, 20 Apr 2017 15:38:49 +1000
Subject: [PATCH 06/11] drbd: use bio_clone_fast() instead of bio_clone()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
Message-ID: <149266672944.27388.18032655582081459017.stgit@noble>
In-Reply-To: <149266645258.27388.14083229348123176454.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

drbd does not modify the bi_io_vec of the cloned bio,
so there is no need to clone that part.  So bio_clone_fast()
is the better choice.
For bio_clone_fast() we need to specify a bio_set.
We could use fs_bio_set, which bio_clone() uses, or
drbd_md_io_bio_set, which drbd uses for metadata, but it is
generally best to avoid sharing bio_sets unless you can
be certain that there are no interdependencies.

So create a new bio_set, drbd_io_bio_set, and use bio_clone_fast().

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/drbd/drbd_int.h  |    3 +++
 drivers/block/drbd/drbd_main.c |    9 +++++++++
 drivers/block/drbd/drbd_req.h  |    2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index d5da45bb03a6..f91982515a6b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1441,6 +1441,9 @@ extern struct bio_set *drbd_md_io_bio_set;
 /* to allocate from that set */
 extern struct bio *bio_alloc_drbd(gfp_t gfp_mask);
 
+/* And a bio_set for cloning */
+extern struct bio_set *drbd_io_bio_set;
+
 extern struct mutex resources_mutex;
 
 extern int conn_lowest_minor(struct drbd_connection *connection);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 84455c365f57..0cc50a7ca1c8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -128,6 +128,7 @@ mempool_t *drbd_request_mempool;
 mempool_t *drbd_ee_mempool;
 mempool_t *drbd_md_io_page_pool;
 struct bio_set *drbd_md_io_bio_set;
+struct bio_set *drbd_io_bio_set;
 
 /* I do not use a standard mempool, because:
    1) I want to hand out the pre-allocated objects first.
@@ -2098,6 +2099,8 @@ static void drbd_destroy_mempools(void)
 
 	/* D_ASSERT(device, atomic_read(&drbd_pp_vacant)==0); */
 
+	if (drbd_io_bio_set)
+		bioset_free(drbd_io_bio_set);
 	if (drbd_md_io_bio_set)
 		bioset_free(drbd_md_io_bio_set);
 	if (drbd_md_io_page_pool)
@@ -2115,6 +2118,7 @@ static void drbd_destroy_mempools(void)
 	if (drbd_al_ext_cache)
 		kmem_cache_destroy(drbd_al_ext_cache);
 
+	drbd_io_bio_set      = NULL;
 	drbd_md_io_bio_set   = NULL;
 	drbd_md_io_page_pool = NULL;
 	drbd_ee_mempool      = NULL;
@@ -2142,6 +2146,7 @@ static int drbd_create_mempools(void)
 	drbd_pp_pool         = NULL;
 	drbd_md_io_page_pool = NULL;
 	drbd_md_io_bio_set   = NULL;
+	drbd_io_bio_set      = NULL;
 
 	/* caches */
 	drbd_request_cache = kmem_cache_create(
@@ -2165,6 +2170,10 @@ static int drbd_create_mempools(void)
 		goto Enomem;
 
 	/* mempools */
+	drbd_io_bio_set = bioset_create(BIO_POOL_SIZE, 0);
+	if (drbd_io_bio_set == NULL)
+		goto Enomem;
+
 	drbd_md_io_bio_set = bioset_create(DRBD_MIN_POOL_PAGES, 0);
 	if (drbd_md_io_bio_set == NULL)
 		goto Enomem;
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.h
index eb49e7f2da91..a24e870853eb 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -263,7 +263,7 @@ enum drbd_req_state_bits {
 static inline void drbd_req_make_private_bio(struct drbd_request *req, struct bio *bio_src)
 {
 	struct bio *bio;
-	bio = bio_clone(bio_src, GFP_NOIO); /* XXX cannot fail?? */
+	bio = bio_clone_fast(bio_src, GFP_NOIO, drbd_io_bio_set); /* XXX cannot fail!! */
 
 	req->private_bio = bio;
 
