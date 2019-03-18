Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC34C10F00
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612F620857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7Y3ezU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCRTs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35356 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XeFOH0Emf0RE77WFecTAZfQFGbklgmlnZ9THg2NYuS4=; b=G7Y3ezU/MdqxXOvW1isjW56Rw
        Xsr0XlfC/7e3GHzyLRDzti24uC7PhIFqK3vJlu/OdDilqb9bGbInotCuAGHP3hqiONkNZamWTeFKC
        5c0pSKlaqpn035ngStoXDjacpjoFxwrV0FJ1gDBRAs/yhXjJr3SdshvCTCiic0tJE9IKo0k48bxUZ
        gyyuZPbOxDXz/SMncAPnShQjX8dEkJPWmXmcBllWqhzHNW2ph0r1+NjBpKKWdknLE72zvKsWsY7fC
        zOsL8ui/cF4sKyeysRN0XHox9FA+LCzTJ7orszexHwWLnW1CPwBOJ4slh7xMGQGkaZt/KPs7OLy6a
        JUEj+Jt0w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vH-4B; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 03/14] blk-cgroup: Reduce scope of blkg_array lock
Date:   Mon, 18 Mar 2019 12:48:10 -0700
Message-Id: <20190318194821.3470-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can now take and release the blkg_array lock within blkg_destroy()
instead of forcing the caller to hold it across the call.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/blk-cgroup.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd6eea0587fb..6962e2fc612d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -367,7 +367,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	int i;
 
 	lockdep_assert_held(&blkg->q->queue_lock);
-	lockdep_assert_held(&blkcg->blkg_array.xa_lock);
 
 	/* Something wrong if we are trying to remove same group twice */
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
@@ -386,7 +385,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 
 	blkg->online = false;
 
-	__xa_erase(&blkcg->blkg_array, blkg->q->id);
+	xa_erase(&blkcg->blkg_array, blkg->q->id);
 	list_del_init(&blkg->q_node);
 
 	/*
@@ -416,11 +415,7 @@ static void blkg_destroy_all(struct request_queue *q)
 
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
-		struct blkcg *blkcg = blkg->blkcg;
-
-		xa_lock(&blkcg->blkg_array);
 		blkg_destroy(blkg);
-		xa_unlock(&blkcg->blkg_array);
 	}
 
 	q->root_blkg = NULL;
@@ -1080,9 +1075,7 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 		struct request_queue *q = blkg->q;
 
 		spin_lock_irq(&q->queue_lock);
-		xa_lock(&blkcg->blkg_array);
 		blkg_destroy(blkg);
-		xa_unlock(&blkcg->blkg_array);
 		spin_unlock_irq(&q->queue_lock);
 	}
 }
-- 
2.20.1

