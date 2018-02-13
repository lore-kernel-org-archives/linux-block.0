Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:24146 "EHLO
        mr11p00im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbeBMHrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Feb 2018 02:47:11 -0500
From: Chengguang Xu <cgxu519@icloud.com>
To: tj@kernel.org, axboe@fb.com
Cc: shli@fb.com, vgoyal@redhat.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] blk-throttle: avoid multiple counting for same bio
Date: Tue, 13 Feb 2018 14:45:50 +0800
Message-id: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In current throttling/upper limit policy of blkio cgroup
blkio.throttle.io_service_bytes does not exactly represent
the number of bytes issued to the disk by the group, sometimes
this number could be counted multiple times of real bytes.
This fix introduces BIO_COUNTED flag to avoid multiple counting
for same bio.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 include/linux/blk-cgroup.h | 4 ++++
 include/linux/blk_types.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 69bea82..6c77711 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -686,6 +686,9 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	struct blkcg_gq *blkg;
 	bool throtl = false;
 
+	if (bio_flagged(bio, BIO_COUNTED))
+		return !throtl;
+
 	rcu_read_lock();
 	blkcg = bio_blkcg(bio);
 
@@ -708,6 +711,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
 		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
+		bio_set_flag(bio, BIO_COUNTED);
 	}
 
 	rcu_read_unlock();
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index bf18b95..23b83e7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -181,6 +181,7 @@ struct bio {
 				 * throttling rules. Don't do it again. */
 #define BIO_TRACE_COMPLETION 10	/* bio_endio() should trace the final completion
 				 * of this bio. */
+#define BIO_COUNTED	11	/* This bio has already been counted. */
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
 /*
-- 
1.8.3.1
