Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60342C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJ3KHl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJ3KHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A5C2AED
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vRxbU4y5dur/pS0O7i0POtDhkVLpnO8QZLzO4ygGgew=; b=iBwF2okUuO3PQYS6VnpY4ejE16
        MhKEmv8aXJFfy/iPMDrPPQkuH+97fMWzmJZZWuo5jYDRR+U8S9ZPnV0/mdSugMluVlu2JdIEX28Qa
        JDrGqCG1qqPiuV75iWPhG+0bK/SA5+z9tUuQgVWW+qykoBu+T4+AGUZlFIb9tY7VQ4xWxz0VO3OqF
        B26kyi4rFxh/c4iFIpwBsZaty6K2uD4aJXvPNvbD3vT02lImkvw3sCgsMJaCeYucABUjRtld0Ezde
        cXxsdJ98d6KjRqBD9ZYa18/TML09ylWxqi3OWF8gLP1A9g0a0nKTR5p6PtZGi0PPAtMS4VrE/ZlNi
        4/XeBk/g==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5EB-00F8RS-Sy; Sun, 30 Oct 2022 10:07:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: don't check for required features in elevator_match
Date:   Sun, 30 Oct 2022 11:07:13 +0100
Message-Id: <20221030100714.876891-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Checking for the required features in the callers simplifies the code
quite a bit, so do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 49 +++++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 77c16c5ef04ff..4042e524333e0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -83,10 +83,11 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(elv_bio_merge_ok);
 
-static inline bool elv_support_features(unsigned int elv_features,
-					unsigned int required_features)
+static inline bool elv_support_features(struct request_queue *q,
+		const struct elevator_type *e)
 {
-	return (required_features & elv_features) == required_features;
+	return (q->required_elevator_features & e->elevator_features) ==
+		q->required_elevator_features;
 }
 
 /**
@@ -98,37 +99,19 @@ static inline bool elv_support_features(unsigned int elv_features,
  * Return true if the elevator @e name matches @name and if @e provides all
  * the features specified by @required_features.
  */
-static bool elevator_match(const struct elevator_type *e, const char *name,
-			   unsigned int required_features)
+static bool elevator_match(const struct elevator_type *e, const char *name)
 {
-	if (!elv_support_features(e->elevator_features, required_features))
-		return false;
-	if (!strcmp(e->elevator_name, name))
-		return true;
-	if (e->elevator_alias && !strcmp(e->elevator_alias, name))
-		return true;
-
-	return false;
+	return !strcmp(e->elevator_name, name) ||
+		(e->elevator_alias && !strcmp(e->elevator_alias, name));
 }
 
-/**
- * elevator_find - Find an elevator
- * @name: Name of the elevator to find
- * @required_features: Features that the elevator must provide
- *
- * Return the first registered scheduler with name @name and supporting the
- * features @required_features and NULL otherwise.
- */
-static struct elevator_type *elevator_find(const char *name,
-					   unsigned int required_features)
+static struct elevator_type *__elevator_find(const char *name)
 {
 	struct elevator_type *e;
 
-	list_for_each_entry(e, &elv_list, list) {
-		if (elevator_match(e, name, required_features))
+	list_for_each_entry(e, &elv_list, list)
+		if (elevator_match(e, name))
 			return e;
-	}
-
 	return NULL;
 }
 
@@ -138,8 +121,8 @@ static struct elevator_type *elevator_find_get(struct request_queue *q,
 	struct elevator_type *e;
 
 	spin_lock(&elv_list_lock);
-	e = elevator_find(name, q->required_elevator_features);
-	if (e && !elevator_tryget(e))
+	e = __elevator_find(name);
+	if (e && (!elv_support_features(q, e) || !elevator_tryget(e)))
 		e = NULL;
 	spin_unlock(&elv_list_lock);
 	return e;
@@ -633,8 +616,7 @@ static struct elevator_type *elevator_get_by_features(struct request_queue *q)
 	spin_lock(&elv_list_lock);
 
 	list_for_each_entry(e, &elv_list, list) {
-		if (elv_support_features(e->elevator_features,
-					 q->required_elevator_features)) {
+		if (elv_support_features(q, e)) {
 			found = e;
 			break;
 		}
@@ -739,7 +721,7 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 		return elevator_switch(q, NULL);
 	}
 
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name, 0))
+	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
 	e = elevator_find_get(q, elevator_name);
@@ -790,8 +772,7 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 			len += sprintf(name+len, "[%s] ", cur->elevator_name);
 			continue;
 		}
-		if (elevator_match(e, e->elevator_name,
-				   q->required_elevator_features))
+		if (elv_support_features(q, e))
 			len += sprintf(name+len, "%s ", e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
-- 
2.30.2

