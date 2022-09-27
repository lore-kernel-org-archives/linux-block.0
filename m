Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B9C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 06:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiI0Gyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0Gyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 02:54:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F639F8DC
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Sw92u1u1+/OL/MbQ/Ya3ElrrGqtD4hSahLiY4jDFJoo=; b=r3AryFUNukvqE1AQ7iVcLIfJdN
        a0rvldKzN2sfmO20W15VZ+M3exZdtBUf/wFCpkAuNzsYJgn5fU+uNw4Nhg5CRHkXoqzkg0ww1bI9D
        lpzyof2bobTVYPaHHtYYPn1Sszy1PQya7LEXyp0edEP01VDeNrKBmmSQUid5IREvlyPjkbv8UIu3h
        CVS5xzbfmmjPrV6JV/UIV9g0wlsG0X/MmVbkfGGkLHvwjPugDxOfqduoiVrEa4tAaKoe3usHMjfAt
        PLxKDps7OylSS/5qse17HuCmXq5uw4q3Tgnj7i/L5WQtLbDWXtPzpQZSNe02839l1rJEWkoH5pdIS
        kQdunOug==;
Received: from [2001:4bb8:180:b903:a982:5e85:edf4:3fb5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1od4U7-008fWN-Hd; Tue, 27 Sep 2022 06:54:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     tj@kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] blk-cgroup: don't update the blkg lookup hint in blkg_conf_prep
Date:   Tue, 27 Sep 2022 08:54:25 +0200
Message-Id: <20220927065425.257876-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg_conf_prep just creates a new blkg structure, there is no real
need to update the lookup hint which should only be done on a
successful lookup in the I/O path.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 94af5f3f3620b..6a5c849ee061b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -263,14 +263,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	return NULL;
 }
 
-static void blkg_update_hint(struct blkcg *blkcg, struct blkcg_gq *blkg)
-{
-	lockdep_assert_held(&blkg->q->queue_lock);
-
-	if (blkcg != &blkcg_root && blkg != rcu_dereference(blkcg->blkg_hint))
-		rcu_assign_pointer(blkcg->blkg_hint, blkg);
-}
-
 /*
  * If @new_blkg is %NULL, this function tries to allocate a new one as
  * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
@@ -383,7 +375,9 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	spin_lock_irqsave(&q->queue_lock, flags);
 	blkg = blkg_lookup(blkcg, q);
 	if (blkg) {
-		blkg_update_hint(blkcg, blkg);
+		if (blkcg != &blkcg_root &&
+		    blkg != rcu_dereference(blkcg->blkg_hint))
+			rcu_assign_pointer(blkcg->blkg_hint, blkg);
 		goto found;
 	}
 
@@ -680,10 +674,8 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	}
 
 	blkg = blkg_lookup(blkcg, q);
-	if (blkg) {
-		blkg_update_hint(blkcg, blkg);
+	if (blkg)
 		goto success;
-	}
 
 	/*
 	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
@@ -727,7 +719,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 
 		blkg = blkg_lookup(pos, q);
 		if (blkg) {
-			blkg_update_hint(pos, blkg);
 			blkg_free(new_blkg);
 		} else {
 			blkg = blkg_create(pos, disk, new_blkg);
-- 
2.30.2

