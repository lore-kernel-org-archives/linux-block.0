Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC68C6FA8B
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIUSFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIUSFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB18649B4B
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nlmFeHkQdtq4JzNHsw+PhE+FYbQ7mLLsw9GlBabItYY=; b=MY8/XpeFqbueaKoaKN5nXrkj51
        wmuck65Ju4ZiQoTiCJRdtnDoRQBXi8Lm4+/mx/rrAr4MUx3yL3nv1DMV/IUakEq6s1jXK0mncxSwk
        2mD1ARN4sqSRSQJ98jAVD6YSc1AHzdKqqmsTIVykdotPb904atVxqBR86xmW3akDIEzr0SWNrjddP
        CC3BZmvpnj+n36P0H8Th0+8PAQXomjUt/h9Vfamc6DIZg6yUHBxdzYL2TEdHoL09q8vb1pIN33BEj
        iLr+sszjXoTq0iOFEckV0zE2Zx4ryy+kd4R8xN4XSlTJqNu/08E9utNfe+Ga+Ex+2VQNciaDuJeJL
        fVTw7pXw==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob45v-00CGWT-BE; Wed, 21 Sep 2022 18:05:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 03/17] blk-cgroup: remove open coded blkg_lookup instances
Date:   Wed, 21 Sep 2022 20:04:47 +0200
Message-Id: <20220921180501.1539876-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blkg_lookup instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 6 +++---
 block/blk-cgroup.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4180de4cbb3e1..b9a1dcee5a244 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -324,7 +324,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
-		blkg->parent = __blkg_lookup(blkcg_parent(blkcg), q, false);
+		blkg->parent = blkg_lookup(blkcg_parent(blkcg), q);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
 			goto err_put_css;
@@ -412,7 +412,7 @@ static struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 		struct blkcg_gq *ret_blkg = q->root_blkg;
 
 		while (parent) {
-			blkg = __blkg_lookup(parent, q, false);
+			blkg = blkg_lookup(parent, q);
 			if (blkg) {
 				/* remember closest blkg */
 				ret_blkg = blkg;
@@ -724,7 +724,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		struct blkcg_gq *new_blkg;
 
 		parent = blkcg_parent(blkcg);
-		while (parent && !__blkg_lookup(parent, q, false)) {
+		while (parent && !blkg_lookup(parent, q)) {
 			pos = parent;
 			parent = blkcg_parent(parent);
 		}
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index c1fb00a1dfc03..30396cad50e9a 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -362,8 +362,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  */
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
-					      (p_blkg)->q, false)))
+		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
+					    (p_blkg)->q)))
 
 /**
  * blkg_for_each_descendant_post - post-order walk of a blkg's descendants
@@ -377,8 +377,8 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  */
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
-					      (p_blkg)->q, false)))
+		if (((d_blkg) = blkg_lookup(css_to_blkcg(pos_css),	\
+					    (p_blkg)->q)))
 
 bool __blkcg_punt_bio_submit(struct bio *bio);
 
-- 
2.30.2

