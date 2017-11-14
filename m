Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753105AbdKNSGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Nov 2017 13:06:16 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAEI20D8007772
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2017 10:06:16 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2e85cc018n-9
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 14 Nov 2017 10:06:15 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, <Kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] blkcg: correctly update stat
Date: Tue, 14 Nov 2017 10:05:07 -0800
Message-ID: <2fefc7364715a5c7d928fd02e4edeb7f80633c7f.1510682654.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blkcg_bio_issue_check() checks throtl for stat update, which isn't good
because the bio could be splitted into small bios, the samll bios go
into blkcg_bio_issue_check again and we update stat for the small bios,
so we the stat is double charged. To fix this, we only update stat if
the bio doesn't have BIO_THROTTLED flag. The fix will update stat ahead
of bio skips from blk-throttle, but eventually the stat is correct.

This patch is on top of patch:
https://marc.info/?l=linux-block&m=151060860608914&w=2

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 include/linux/blk-cgroup.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 58f3d25..6fbd9ea 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -690,7 +690,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 {
 	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
-	bool throtl = false;
+	bool throtl;
+	bool charged;
 
 	rcu_read_lock();
 	blkcg = bio_blkcg(bio);
@@ -707,9 +708,10 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 		spin_unlock_irq(q->queue_lock);
 	}
 
+	charged = bio_flagged(bio, BIO_THROTTLED);
 	throtl = blk_throtl_bio(q, blkg, bio);
 
-	if (!throtl) {
+	if (!charged) {
 		blkg = blkg ?: q->root_blkg;
 		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
-- 
2.9.5
