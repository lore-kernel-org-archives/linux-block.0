Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/13] blk: introduce REQ_SWAP
Date: Tue, 29 May 2018 17:17:15 -0400
Message-Id: <20180529211724.4531-5-josef@toxicpanda.com>
In-Reply-To: <20180529211724.4531-1-josef@toxicpanda.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Just like REQ_META, it's important to know the IO coming down is swap
in order to guard against potential IO priority inversion issues with
cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
bio_issue_as_root_blkg helper.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 include/linux/blk-cgroup.h | 2 +-
 include/linux/blk_types.h  | 3 ++-
 mm/page_io.c               | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b41292726c0f..a8f9ba8f33a4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -254,7 +254,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
  */
 static inline bool bio_issue_as_root_blkg(struct bio *bio)
 {
-	return (bio->bi_opf & REQ_META);
+	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
 }
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ff181df8c195..4f7ba397d37d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -327,7 +327,7 @@ enum req_flag_bits {
 
 	/* for driver use */
 	__REQ_DRV,
-
+	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -349,6 +349,7 @@ enum req_flag_bits {
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
+#define REQ_SWAP		(1ULL << __REQ_SWAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..a552cb37e220 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -338,7 +338,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		ret = -ENOMEM;
 		goto out;
 	}
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3
