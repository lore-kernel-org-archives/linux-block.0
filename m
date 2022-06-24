Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29488CCA473
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiFXFZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiFXFZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0534EF4D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nsAorcAEs6GcEiUYfqjLUKCuZsJirYig+vpdJ9aprbU=; b=JIuvul/G2qE+eutc5DL5lqQ1d9
        x5d+Fe67D4oxT9QW6ofaEItRMnMwpaMPKElnMo7+MC4bDpfmas036BJlXPeNdurN1j8DJ2yX6TO0s
        xzzLLz1VYP/oOg8qvnCwDw4wkuxLsPeJqxtSdgstMgylVrBoN3VI1JczMmKehCB2luCu6NLzX1hKf
        qJ+jAFaKg1YAAWCeixv1Hb0DJ311Jf0PI0iwKQCM2KomKTkLpoyettP49hxiInU7GmRS7tekpSr9S
        bjfbVdJpGpImET6KQP0glz7nG0JAOlhBtMTx8SMNT+4N93+V215QRIksy3h8QoZFBcs3+uKqucGW2
        /pdyVP4A==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4bom-000cBK-CN; Fri, 24 Jun 2022 05:25:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/6] block: use default groups to register the queue attributes
Date:   Fri, 24 Jun 2022 07:25:07 +0200
Message-Id: <20220624052510.3996673-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624052510.3996673-1-hch@lst.de>
References: <20220624052510.3996673-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set up the default_groups for blk_queue_ktype instead of manually calling
sysfs_create_group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 520ff9aa6dd45..80f506411f92f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -788,7 +788,13 @@ static const struct sysfs_ops queue_sysfs_ops = {
 	.store	= queue_attr_store,
 };
 
+static const struct attribute_group *blk_queue_attr_groups[] = {
+	&queue_attr_group,
+	NULL
+};
+
 struct kobj_type blk_queue_ktype = {
+	.default_groups = blk_queue_attr_groups,
 	.sysfs_ops	= &queue_sysfs_ops,
 	.release	= blk_release_queue,
 };
@@ -809,12 +815,6 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret < 0)
 		goto unlock;
 
-	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
-	if (ret) {
-		kobject_del(&q->kobj);
-		goto unlock;
-	}
-
 	if (queue_is_mq(q))
 		__blk_mq_register_dev(dev, q);
 	mutex_lock(&q->sysfs_lock);
-- 
2.30.2

