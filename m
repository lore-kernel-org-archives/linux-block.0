Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D3C38A02
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ3KHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJ3KHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB09109C
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vF9QjDRfg7JPomAG4f1wYU6YfOvT7EvAoEEMqxR9FxI=; b=E0kSnL0U9stMckD9rwVOwq32dO
        Xa30K4QcnAXDVCdEXqwIE472jBd4ph9u+wq8+yAjPAHRKsHM5VdYYZ15Y7HDlgBi8FOSZScnq0Pj9
        N747AXXwCc8L65zcHP1WRSIgj9GivnLAPUa1cWRckyaG9ompPI70n+Ri/UbB28qxVbbxz4u+EFotA
        XnvnKhV833q0Poktvkhishd2KXaN3ZPHgLOlMrBQmIOJwChVBZdQHPoISE+S4enAbIcx9ZORXtgzM
        LSFkjopvopywAzm+E6aPYh2cjMjEQBNwjY/4Ek9T4yHkw5ICKIvvjJtn6n+cgzVu59EdJfssaaLEc
        lTP/WrvQ==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5E1-00F8KI-WC; Sun, 30 Oct 2022 10:07:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/7] block: cleanup elevator_get
Date:   Sun, 30 Oct 2022 11:07:09 +0100
Message-Id: <20221030100714.876891-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Do the request_module and repeated lookup in the only caller that cares,
pick a saner name that explains where are actually doing a lookup and
use a sane calling conventions that passes the queue first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index ef9af17293ffb..d0e48839f6764 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -132,24 +132,15 @@ static struct elevator_type *elevator_find(const char *name,
 	return NULL;
 }
 
-static struct elevator_type *elevator_get(struct request_queue *q,
-					  const char *name, bool try_loading)
+static struct elevator_type *elevator_find_get(struct request_queue *q,
+		const char *name)
 {
 	struct elevator_type *e;
 
 	spin_lock(&elv_list_lock);
-
 	e = elevator_find(name, q->required_elevator_features);
-	if (!e && try_loading) {
-		spin_unlock(&elv_list_lock);
-		request_module("%s-iosched", name);
-		spin_lock(&elv_list_lock);
-		e = elevator_find(name, q->required_elevator_features);
-	}
-
 	if (e && !elevator_tryget(e))
 		e = NULL;
-
 	spin_unlock(&elv_list_lock);
 	return e;
 }
@@ -628,7 +619,7 @@ static struct elevator_type *elevator_get_default(struct request_queue *q)
 	    !blk_mq_is_shared_tags(q->tag_set->flags))
 		return NULL;
 
-	return elevator_get(q, "mq-deadline", false);
+	return elevator_find_get(q, "mq-deadline");
 }
 
 /*
@@ -751,9 +742,13 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name, 0))
 		return 0;
 
-	e = elevator_get(q, elevator_name, true);
-	if (!e)
-		return -EINVAL;
+	e = elevator_find_get(q, elevator_name);
+	if (!e) {
+		request_module("%s-iosched", elevator_name);
+		e = elevator_find_get(q, elevator_name);
+		if (!e)
+			return -EINVAL;
+	}
 	ret = elevator_switch(q, e);
 	elevator_put(e);
 	return ret;
-- 
2.30.2

