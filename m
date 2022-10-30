Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B9FA373D
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJ3KHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiJ3KHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83661109C
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8E9jHUul2ENUPFNvA22LdJAcaZPRKzhTn6XK4J10fb0=; b=Aw11N/+rgZJcEGBkIQEjpmY84i
        k+yVgrjks5DHiCiQHCqrthEcg0VJQpVMlgySgZWZm5g/1DqWmEFsq4INTOiH46ADDtNW+T7m0UVMb
        soXsvkd2Lkr/QQ97Y69B33ggT7gc5ytIhjxxojFGNJubSH+u8zN1hQaRLiTOpMrOe6mf1lHty9x0U
        +cM+iZ3QA3F1xNedWs5P3jviKNQ7XKmjN0fu+Rko0GqclFfZi1VF9J3wg/ff1LpFwHttgrxw0ML2K
        1IpF40rLTwxdXtgLxk2oRdDK3qvBvA06TxmdrV9iibM8IGIcolmPluUmUuNSspANp3X8BI/kbWLM1
        dL1wy40g==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5E6-00F8O8-Qt; Sun, 30 Oct 2022 10:07:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/7] block: cleanup the variable naming in elv_iosched_store
Date:   Sun, 30 Oct 2022 11:07:11 +0100
Message-Id: <20221030100714.876891-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use eq for the elevator_queue as done elsewhere.  This frees e to be used
for the loop iterator instead of the odd __ prefix.  In addition rename
elv to cur to make it more clear it is the currently selected elevator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 92096e5aabd36..4fc0d2f539295 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -772,9 +772,8 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *buf,
 
 ssize_t elv_iosched_show(struct request_queue *q, char *name)
 {
-	struct elevator_queue *e = q->elevator;
-	struct elevator_type *elv = NULL;
-	struct elevator_type *__e;
+	struct elevator_queue *eq = q->elevator;
+	struct elevator_type *cur = NULL, *e;
 	int len = 0;
 
 	if (!elv_support_iosched(q))
@@ -783,17 +782,17 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 	if (!q->elevator)
 		len += sprintf(name+len, "[none] ");
 	else
-		elv = e->type;
+		cur = eq->type;
 
 	spin_lock(&elv_list_lock);
-	list_for_each_entry(__e, &elv_list, list) {
-		if (elv && elevator_match(elv, __e->elevator_name, 0)) {
-			len += sprintf(name+len, "[%s] ", elv->elevator_name);
+	list_for_each_entry(e, &elv_list, list) {
+		if (cur && elevator_match(cur, e->elevator_name, 0)) {
+			len += sprintf(name+len, "[%s] ", cur->elevator_name);
 			continue;
 		}
-		if (elevator_match(__e, __e->elevator_name,
+		if (elevator_match(e, e->elevator_name,
 				   q->required_elevator_features))
-			len += sprintf(name+len, "%s ", __e->elevator_name);
+			len += sprintf(name+len, "%s ", e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
 
-- 
2.30.2

