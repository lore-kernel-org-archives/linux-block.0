Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44881 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752892AbdFREkN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:40:13 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:58 +1000
Subject: [PATCH 06/13] rbd: use bio_clone_fast() instead of bio_clone()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776073802.23258.14608712010143858524.stgit@noble>
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_clone() makes a copy of the bi_io_vec, but rbd never changes that,
so there is no need for a copy.
bio_clone_fast() can be used instead, which avoids making the copy.

This requires that we provide a bio_set.  bio_clone() uses fs_bio_set,
but it isn't, in general, safe to use the same bio_set at different
levels of the stack, as that can lead to deadlocks.  As filesystems
use fs_bio_set, block devices shouldn't.

As rbd never stacks, it is safe to have a single global bio_set for
all rbd devices to use.  So allocate that when the module is
initialised, and use it with bio_clone_fast().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/block/rbd.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5420bc40c544..b008b6a98098 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -442,6 +442,8 @@ static DEFINE_SPINLOCK(rbd_client_list_lock);
 static struct kmem_cache	*rbd_img_request_cache;
 static struct kmem_cache	*rbd_obj_request_cache;
 
+static struct bio_set		*rbd_bio_clone;
+
 static int rbd_major;
 static DEFINE_IDA(rbd_dev_id_ida);
 
@@ -1363,7 +1365,7 @@ static struct bio *bio_clone_range(struct bio *bio_src,
 {
 	struct bio *bio;
 
-	bio = bio_clone(bio_src, gfpmask);
+	bio = bio_clone_fast(bio_src, gfpmask, rbd_bio_clone);
 	if (!bio)
 		return NULL;	/* ENOMEM */
 
@@ -6416,8 +6418,16 @@ static int rbd_slab_init(void)
 	if (!rbd_obj_request_cache)
 		goto out_err;
 
+	rbd_assert(!rbd_bio_clone);
+	rbd_bio_clone = bioset_create(BIO_POOL_SIZE, 0, 0);
+	if (!rbd_bio_clone)
+		goto out_err_clone;
+
 	return 0;
 
+out_err_clone:
+	kmem_cache_destroy(rbd_obj_request_cache);
+	rbd_obj_request_cache = NULL;
 out_err:
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
@@ -6433,6 +6443,10 @@ static void rbd_slab_exit(void)
 	rbd_assert(rbd_img_request_cache);
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
+
+	rbd_assert(rbd_bio_clone);
+	bioset_free(rbd_bio_clone);
+	rbd_bio_clone = NULL;
 }
 
 static int __init rbd_init(void)
