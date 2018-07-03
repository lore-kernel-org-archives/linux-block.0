Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate context
Date: Tue,  3 Jul 2018 11:14:54 -0400
Message-Id: <20180703151503.2549-6-josef@toxicpanda.com>
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Tejun Heo <tj@kernel.org>

For backcharging we need to know who the page belongs to when swapping
it out.  We don't worry about things that do ->rw_page (zram etc) at the
moment, we're only worried about pages that actually go to a block
device.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
cked-by: Andrew Morton <akpm@linux-foundation.org>
---
 block/bio.c         | 24 ++++++++++++++++++++++++
 include/linux/bio.h |  7 +++++++
 mm/page_io.c        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c9072a54395e..e09f3626ab5b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2015,6 +2015,30 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
+#ifdef CONFIG_MEMCG
+/**
+ * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
+ * @bio: target bio
+ * @page: the page to lookup the blkcg from
+ *
+ * Associate @bio with the blkcg from @page's owning memcg.  This works like
+ * every other associate function wrt references.
+ */
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *blkcg_css;
+
+	if (unlikely(bio->bi_css))
+		return -EBUSY;
+	if (!page->mem_cgroup)
+		return 0;
+	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
+				     &io_cgrp_subsys);
+	bio->bi_css = blkcg_css;
+	return 0;
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a279ba384da9..a00dfff51aa5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -553,6 +553,13 @@ do {						\
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
+#else
+static inline int bio_associate_blkcg_from_page(struct bio *bio,
+						struct page *page) {  return 0; }
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
diff --git a/mm/page_io.c b/mm/page_io.c
index a552cb37e220..aafd19ec1db4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,6 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
+	bio_associate_blkcg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3
