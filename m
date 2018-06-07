Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: snitzer@redhat.com,
	kent.overstreet@gmail.com,
	liwang@redhat.com,
	vrbagal1@linux.vnet.ibm.com,
	chuhu.ncepu@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] block: add bioset_init_from_src() helper
Date: Thu,  7 Jun 2018 14:45:40 -0600
Message-Id: <20180607204541.13491-2-axboe@kernel.dk>
In-Reply-To: <20180607204541.13491-1-axboe@kernel.dk>
References: <20180607204541.13491-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Add a helper that allows a caller to initialize a new bio_set,
using the settings from an existing bio_set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         | 18 ++++++++++++++++++
 include/linux/bio.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 595663e0281a..bf516d873ce9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1967,6 +1967,24 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+/*
+ * Initialize and setup a new bio_set, based on the settings from
+ * another bio_set.
+ */
+int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
+{
+	int flags;
+
+	flags = 0;
+	if (src->bvec_pool.min_nr)
+		flags |= BIOSET_NEED_BVECS;
+	if (src->rescue_workqueue)
+		flags |= BIOSET_NEED_RESCUER;
+
+	return bioset_init(bs, src->bio_pool.min_nr, src->front_pad, flags);
+}
+EXPORT_SYMBOL(bioset_init_from_src);
+
 #ifdef CONFIG_BLK_CGROUP
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 810a8bee8f85..84abd1706dcb 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,7 @@ enum {
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
+extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
 extern void bio_put(struct bio *);
-- 
2.17.1
