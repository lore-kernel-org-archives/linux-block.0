Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BEC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIUSFT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUSFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A548CA9
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=p6I6pcoERqGja62X4Mji2o6cRPWatNfiSj4Na4cmPbs=; b=iujbdOkeiZI4l3c3AWRCtJYl5h
        3RDziOYiO31Sb+AY3bW048NrV1nWYsDeNtW8sHnKBABrd4+ODdknssIxto0nBArOVCQnFfH28UEjR
        +xFU/+gUpGXiNtpITDBmSNKwEaK4teadcVFVpS3Xv1Xb4wwgP80oC51doZhTYsTZNLgddeJbARbZ/
        OxjiIYTYy7whfnJ5aCEE3lUPyS8TCJ61CCzWhFlGJeprL6gyQa8LOd28CT05fFHDdgCsmF8TTmHGN
        2X+H4UkKRGK2+CIeRUh/ACFsw9A3w4UyGsgKj+umnrYIHqcld2BFo8XpGu70zZNIsnuIpiQsnAZpV
        EUAza94Q==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45z-00CGXQ-Kr; Wed, 21 Sep 2022 18:05:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 05/17] blk-cgroup: remove blkg_lookup_check
Date:   Wed, 21 Sep 2022 20:04:49 +0200
Message-Id: <20220921180501.1539876-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The combinations of an error check with an ERR_PTR return and a lookup
with a NULL return leads to ugly handling of the return values in the
callers.  Just open coding the check and the lookup is much simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d1216760d0255..1306112d76486 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -602,25 +602,6 @@ u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 }
 EXPORT_SYMBOL_GPL(__blkg_prfill_u64);
 
-/* Performs queue bypass and policy enabled checks then looks up blkg. */
-static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
-					  const struct blkcg_policy *pol,
-					  struct request_queue *q)
-{
-	struct blkcg_gq *blkg;
-
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	lockdep_assert_held(&q->queue_lock);
-
-	if (!blkcg_policy_enabled(q, pol))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	blkg = blkg_lookup(blkcg, q);
-	if (blkg)
-		blkg_update_hint(blkcg, blkg);
-	return blkg;
-}
-
 /**
  * blkcg_conf_open_bdev - parse and open bdev for per-blkg config update
  * @inputp: input string pointer
@@ -697,14 +678,16 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
 
-	blkg = blkg_lookup_check(blkcg, pol, q);
-	if (IS_ERR(blkg)) {
-		ret = PTR_ERR(blkg);
+	if (!blkcg_policy_enabled(q, pol)) {
+		ret = -EOPNOTSUPP;
 		goto fail_unlock;
 	}
 
-	if (blkg)
+	blkg = blkg_lookup(blkcg, q);
+	if (blkg) {
+		blkg_update_hint(blkcg, blkg);
 		goto success;
+	}
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
@@ -740,14 +723,15 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		rcu_read_lock();
 		spin_lock_irq(&q->queue_lock);
 
-		blkg = blkg_lookup_check(pos, pol, q);
-		if (IS_ERR(blkg)) {
-			ret = PTR_ERR(blkg);
+		if (!blkcg_policy_enabled(q, pol)) {
 			blkg_free(new_blkg);
+			ret = -EOPNOTSUPP;
 			goto fail_preloaded;
 		}
 
+		blkg = blkg_lookup(pos, q);
 		if (blkg) {
+			blkg_update_hint(pos, blkg);
 			blkg_free(new_blkg);
 		} else {
 			blkg = blkg_create(pos, q, new_blkg);
-- 
2.30.2

