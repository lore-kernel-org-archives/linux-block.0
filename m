Return-Path: <SRS0=phs8=AI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE555C433E1
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 07:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863222137B
	for <linux-block@archiver.kernel.org>; Sat, 27 Jun 2020 07:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T1TDJ0/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgF0HdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgF0Hc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jun 2020 03:32:59 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC4C03E97A;
        Sat, 27 Jun 2020 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EZ7JERHE6/tvgP05nSclplXZEEiO4tv/M9Y5/s349gU=; b=T1TDJ0/J5jy3E+tsjXEkkkQ57r
        DhTeVGJD6SyfqR7bG4EpVAZ4on6AuyexkciKBJq5jqo6yUrmcUIWGJFK18KEzuQjvYqHVKxsJAv7O
        CrWwF/zVPEGAGC11hBr6joU3qnoPHNwqJfip9BYtxtGUfFQ9nWnOQKO8uoCzQ0ERlalMvcsD9VPTd
        TZ02agzs3BQbsAFYWFHNFA9IB+Zx12YJRY0Kh5i2WO13j3+uy0OuRvvC8IEj3b+v5ZoXTdGzyQt7l
        sBnCrwjHbU9OdYu405TDLDw6RTpQiloFPnA1ntOXm91l3yJZI0shWxBSBteMEqGJwOMjzSq27xYrR
        R+6srrvQ==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5KB-0006na-7G; Sat, 27 Jun 2020 07:32:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/14] block: move the initial blkg lookup into blkg_tryget_closest
Date:   Sat, 27 Jun 2020 09:31:54 +0200
Message-Id: <20200627073159.2447325-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By moving the initial blkg lookup into blkg_tryget_closest we get
a nicely self contained routines that does all the RCU locking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0912820d4f8194..d21ec2acd716e7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1716,19 +1716,20 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 
 /**
  * blkg_tryget_closest - try and get a blkg ref on the closet blkg
- * @blkg: blkg to get
+ * @bio: target bio
+ * @css: target css
  *
- * This needs to be called rcu protected.  As the failure mode here is to walk
- * up the blkg tree, this ensure that the blkg->parent pointers are always
- * valid.  This returns the blkg that it ended up taking a reference on or %NULL
- * if no reference was taken.
+ * As the failure mode here is to walk up the blkg tree, this ensure that the
+ * blkg->parent pointers are always valid.  This returns the blkg that it ended
+ * up taking a reference on or %NULL if no reference was taken.
  */
-static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
+static inline struct blkcg_gq *blkg_tryget_closest(struct bio *bio,
+		struct cgroup_subsys_state *css)
 {
-	struct blkcg_gq *ret_blkg = NULL;
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	struct blkcg_gq *blkg, *ret_blkg = NULL;
 
+	rcu_read_lock();
+	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_disk->queue);
 	while (blkg) {
 		if (blkg_tryget(blkg)) {
 			ret_blkg = blkg;
@@ -1736,6 +1737,7 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 		}
 		blkg = blkg->parent;
 	}
+	rcu_read_unlock();
 
 	return ret_blkg;
 }
@@ -1757,21 +1759,14 @@ static inline struct blkcg_gq *blkg_tryget_closest(struct blkcg_gq *blkg)
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css)
 {
-	struct request_queue *q = bio->bi_disk->queue;
-
 	if (bio->bi_blkg)
 		blkg_put(bio->bi_blkg);
 
 	if (css && css->parent) {
-		struct blkcg_gq *blkg;
-
-		rcu_read_lock();
-		blkg = blkg_lookup_create(css_to_blkcg(css), q);
-		bio->bi_blkg = blkg_tryget_closest(blkg);
-		rcu_read_unlock();
+		bio->bi_blkg = blkg_tryget_closest(bio, css);
 	} else {
-		blkg_get(q->root_blkg);
-		bio->bi_blkg = q->root_blkg;
+		blkg_get(bio->bi_disk->queue->root_blkg);
+		bio->bi_blkg = bio->bi_disk->queue->root_blkg;
 	}
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
-- 
2.26.2

