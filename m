Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A3AC05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 05:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBIFf2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 00:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIFf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 00:35:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF0303F2
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 21:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6xkg7wCJfrkIZGacEqi5Aow/jy7gFYR4w7i6+ZHEZ3c=; b=h1AbxNFDyTVCxxkAcaplu76o2T
        3vYVrC5DpagVOV3vmk82mAyJupxtfDHlk/XWD+ZQjGCUwgSYzW1YqVB6C02H5R6FSUzYPru6hAfs6
        QnNWGSftoKO9g2TOrLboslLnVrYt8QdKA8uDQQfDRKLYFRwFhBxlZmHlwEj9rZOeOPB+vadONWmqK
        XD9hL+88/f2YD5de0nkaX/eDUSgBNcyFGwG74dsvuVBYI5iREV6ITImk///LYUGh2KI+M8NQrMZ3W
        DcsY2uCdcl74vC1QUxAS64MUDDOJn1qJdjyNx1+lfl98i7aZxnk0A+mmuYR6OdN2tcm6iWyMCPTHu
        XLu6f5uA==;
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPzaf-000DUd-Eu; Thu, 09 Feb 2023 05:35:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     error27@gmail.com, linux-block@vger.kernel.org
Subject: [PATCH] Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"
Date:   Thu,  9 Feb 2023 06:35:23 +0100
Message-Id: <20230209053523.437927-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It turns out this was too soon.  blkg_conf_prep does to funky locking games
with the queue lock for this to work properly.

This reverts commit 27b642b07a4a5eb44dffa94a5171ce468bdc46f9.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d8fe607138b96d..935028912e7abf 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -114,8 +114,10 @@ static bool blkcg_policy_enabled(struct gendisk *disk,
 	return pol && test_bit(pol->plid, disk->blkcg_pols);
 }
 
-static void blkg_free(struct blkcg_gq *blkg)
+static void blkg_free_workfn(struct work_struct *work)
 {
+	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
+					     free_work);
 	int i;
 
 	/*
@@ -140,9 +142,23 @@ static void blkg_free(struct blkcg_gq *blkg)
 	kfree(blkg);
 }
 
-static void blkg_free_workfn(struct work_struct *work)
+/**
+ * blkg_free - free a blkg
+ * @blkg: blkg to free
+ *
+ * Free @blkg which may be partially allocated.
+ */
+static void blkg_free(struct blkcg_gq *blkg)
 {
-	blkg_free(container_of(work, struct blkcg_gq, free_work));
+	if (!blkg)
+		return;
+
+	/*
+	 * Both ->pd_free_fn() and request queue's release handler may
+	 * sleep, so free us by scheduling one work func
+	 */
+	INIT_WORK(&blkg->free_work, blkg_free_workfn);
+	schedule_work(&blkg->free_work);
 }
 
 static void __blkg_release(struct rcu_head *rcu)
@@ -153,10 +169,7 @@ static void __blkg_release(struct rcu_head *rcu)
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
-
-	/* ->pd_free_fn() may sleep, so free from a work queue */
-	INIT_WORK(&blkg->free_work, blkg_free_workfn);
-	schedule_work(&blkg->free_work);
+	blkg_free(blkg);
 }
 
 /*
-- 
2.39.1

