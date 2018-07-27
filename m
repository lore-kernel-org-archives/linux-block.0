Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39043 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbeG0Whu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 18:37:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id q12-v6so6490176qtp.6
        for <linux-block@vger.kernel.org>; Fri, 27 Jul 2018 14:14:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] block: don't do cgroup accounting for split bio's
Date: Fri, 27 Jul 2018 17:14:07 -0400
Message-Id: <20180727211407.24318-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We need to check in blkcg_bio_issue_check if the bio is flagged as
QUEUE_ENTERED, because if it is then we've already accounted for the IO
in the cgroup stats.

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/blk-cgroup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3bed5e02a873..a977c31688ae 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -767,7 +767,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	throtl = blk_throtl_bio(q, blkg, bio);
 
-	if (!throtl) {
+	if (!throtl &&
+	    !bio_flagged(bio, BIO_QUEUE_ENTERED)) {
 		blkg = blkg ?: q->root_blkg;
 		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
-- 
2.14.3
