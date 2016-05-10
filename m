Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	stable@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block: add missing group association in bio-cloning functions
Date: Tue, 10 May 2016 22:23:41 +0200
Message-Id: <1462911821-7354-1-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <x4960ul7uyw.fsf@segfault.boston.devel.redhat.com>
References: <x4960ul7uyw.fsf@segfault.boston.devel.redhat.com>
List-ID: <linux-block@vger.kernel.org>

When a bio is cloned, the newly created bio must be associated with
the same blkcg as the original bio (if BLK_CGROUP is enabled). If
this operation is not performed, then the new bio is not associated
with any group, and the group of the current task is returned when
the group of the bio is requested.

Depending on the cloning frequency, this may cause a large
percentage of the bios belonging to a given group to be treated
as if belonging to other groups (in most cases as if belonging to
the root group). The expected group isolation may thereby be broken.

This commit adds the missing association in bio-cloning functions.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bio.c          | 17 +++++++++++++++++
 fs/btrfs/extent_io.c |  6 ------
 include/linux/bio.h  |  2 ++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 807d25e..e9b136a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -622,6 +622,8 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 		}
 	}
 
+	bio_clone_blkcg_association(b, bio);
+
 	return b;
 }
 EXPORT_SYMBOL(bio_clone_fast);
@@ -695,6 +697,8 @@ integrity_clone:
 		}
 	}
 
+	bio_clone_blkcg_association(bio, bio_src);
+
 	return bio;
 }
 EXPORT_SYMBOL(bio_clone_bioset);
@@ -1811,6 +1815,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	bio_advance(bio, split->bi_iter.bi_size);
 
+	bio_clone_blkcg_association(split, bio);
+
 	return split;
 }
 EXPORT_SYMBOL(bio_split);
@@ -2016,6 +2022,17 @@ void bio_disassociate_task(struct bio *bio)
 	}
 }
 
+/**
+ * bio_clone_blkcg_association - clone blkcg association from src to dst bio
+ * @dst: destination bio
+ * @src: source bio
+ */
+void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
+{
+	if (src->bi_css)
+		WARN_ON(bio_associate_blkcg(dst, src->bi_css));
+}
+
 #endif /* CONFIG_BLK_CGROUP */
 
 static void __init biovec_init_slabs(void)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d247fc0..19f6739 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2686,12 +2686,6 @@ struct bio *btrfs_bio_clone(struct bio *bio, gfp_t gfp_mask)
 		btrfs_bio->csum = NULL;
 		btrfs_bio->csum_allocated = NULL;
 		btrfs_bio->end_io = NULL;
-
-#ifdef CONFIG_BLK_CGROUP
-		/* FIXME, put this into bio_clone_bioset */
-		if (bio->bi_css)
-			bio_associate_blkcg(new, bio->bi_css);
-#endif
 	}
 	return new;
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 6b7481f..a9ff116 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -527,11 +527,13 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_current(struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
+void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
 static inline void bio_disassociate_task(struct bio *bio) { }
+void bio_clone_blkcg_association(struct bio *dst, struct bio *src) { return 0; }
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_HIGHMEM
-- 
1.9.1
