Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block: add missing group association in bio_split
Date: Tue, 10 May 2016 11:08:42 +0200
Message-Id: <1462871322-13217-1-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <5730CFC5.80201@kernel.dk>
References: <5730CFC5.80201@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

When a bio is split, the newly created bio must be associated with the
same blkcg as the original bio (if BLK_CGROUP is enabled). If this
operation is not performed, then the new bio is not associated with
any group, and the group of the current task is returned when the
group of the bio is requested.

Depending on the frequency of splits, this may cause a large
percentage of the bios belonging to a given group to be treated as if
belonging to other groups (in most cases as if belonging to the root
group). The expected group isolation may thereby be then broken.

This commit adds the missing association in bio_split.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bio.c         | 15 +++++++++++++++
 include/linux/bio.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 807d25e..20795eb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1811,6 +1811,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
 
 	bio_advance(bio, split->bi_iter.bi_size);
 
+	bio_clone_blkcg_association(split, bio);
+
 	return split;
 }
 EXPORT_SYMBOL(bio_split);
@@ -2016,6 +2018,19 @@ void bio_disassociate_task(struct bio *bio)
 	}
 }
 
+/**
+ * bio_clone_blkcg_association - clone blkcg association from src to dst bio
+ * @dst: destination bio
+ * @src: source bio
+ */
+int bio_clone_blkcg_association(struct bio *dst, struct bio *src)
+{
+	if (src->bi_css)
+		return bio_associate_blkcg(dst, src->bi_css);
+
+	return 0;
+}
+
 #endif /* CONFIG_BLK_CGROUP */
 
 static void __init biovec_init_slabs(void)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 6b7481f..8535f81 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -527,11 +527,13 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_current(struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
+int bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
 static inline void bio_disassociate_task(struct bio *bio) { }
+int bio_clone_blkcg_association(struct bio *dst, struct bio *src) { return 0; }
 #endif	/* CONFIG_BLK_CGROUP */
 
 #ifdef CONFIG_HIGHMEM
-- 
1.9.1
