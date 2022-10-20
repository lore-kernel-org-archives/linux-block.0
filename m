Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ABC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 06:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJTGse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 02:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJTGsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:48:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0533354
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=X/W0gmWSXBdCefsG/fXnsNZWKgxHTfh4zx6PG9nhZnM=; b=kzr3EHyAK7idyjDfObN8PKx825
        YK/oRrobawie7WSGOqcMJhmxqNpj4YA9L6T0JLSycyb+lUiMZegrZM90QVzmVG1QP8GIENgdU8qQx
        EcNQ/4chf/TrVbVEsMuIPd6ib1l9ZpCgarC+bnXhxFxik21QkpiWiVtYhyFT9UIHTEy678uRFiJ5/
        yWG04dKXUQ+2eg81Q3j9GKh9VE6Ux9GJp1H3LzhwYKa7wowWqyILufaxAff9peKEj+/6WmZhuePe9
        BlYXHCXBk7pU2O+PjVAuMM3mVxRSCd64ajmgKM+JHvdEDVaFssx8IG8GSbXXXV249wcfqXsLRAfwC
        SkyBQmyQ==;
Received: from [88.128.92.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olPLw-00BJdd-5v; Thu, 20 Oct 2022 06:48:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinlong Chen <nickyc975@zju.edu.cn>, linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: add proper helpers for elevator_type module refcount management
Date:   Thu, 20 Oct 2022 08:48:16 +0200
Message-Id: <20221020064819.1469928-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020064819.1469928-1-hch@lst.de>
References: <20221020064819.1469928-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure we have helpers for all relevant module refcount operations on
the elevator_type in elevator.h, and use them.  Move the call to the get
helper in blk_mq_elv_switch_none a bit so that it is obvious with a less
verbose comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c   | 11 ++---------
 block/elevator.c |  9 ++-------
 block/elevator.h | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d5..9db8814cdd02b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4554,17 +4554,10 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
+	/* keep a reference to the elevator module as we'll switch back */
+	__elevator_get(qe->type);
 	qe->type = q->elevator->type;
 	list_add(&qe->node, head);
-
-	/*
-	 * After elevator_switch, the previous elevator_queue will be
-	 * released by elevator_release. The reference of the io scheduler
-	 * module get by elevator_get will also be put. So we need to get
-	 * a reference of the io scheduler module here to prevent it to be
-	 * removed.
-	 */
-	__module_get(qe->type->elevator_owner);
 	elevator_switch(q, NULL);
 	mutex_unlock(&q->sysfs_lock);
 
diff --git a/block/elevator.c b/block/elevator.c
index bd71f0fc4e4b6..40ba43aa9ece0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -132,11 +132,6 @@ static struct elevator_type *elevator_find(const char *name,
 	return NULL;
 }
 
-static void elevator_put(struct elevator_type *e)
-{
-	module_put(e->elevator_owner);
-}
-
 static struct elevator_type *elevator_get(struct request_queue *q,
 					  const char *name, bool try_loading)
 {
@@ -152,7 +147,7 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 		e = elevator_find(name, q->required_elevator_features);
 	}
 
-	if (e && !try_module_get(e->elevator_owner))
+	if (e && !elevator_tryget(e))
 		e = NULL;
 
 	spin_unlock(&elv_list_lock);
@@ -663,7 +658,7 @@ static struct elevator_type *elevator_get_by_features(struct request_queue *q)
 		}
 	}
 
-	if (found && !try_module_get(found->elevator_owner))
+	if (found && !elevator_tryget(found))
 		found = NULL;
 
 	spin_unlock(&elv_list_lock);
diff --git a/block/elevator.h b/block/elevator.h
index 3f0593b3bf9d3..44e5f35fa740d 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -84,6 +84,21 @@ struct elevator_type
 	struct list_head list;
 };
 
+static inline bool elevator_tryget(struct elevator_type *e)
+{
+	return try_module_get(e->elevator_owner);
+}
+
+static inline void __elevator_get(struct elevator_type *e)
+{
+	__module_get(e->elevator_owner);
+}
+
+static inline void elevator_put(struct elevator_type *e)
+{
+	module_put(e->elevator_owner);
+}
+
 #define ELV_HASH_BITS 6
 
 void elv_rqhash_del(struct request_queue *q, struct request *rq);
-- 
2.30.2

