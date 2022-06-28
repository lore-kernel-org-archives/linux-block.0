Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiF1RTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiF1RTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:19:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD552FFF1
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E+qCidU0nZsMNWYP3oG5Vcstll36nFfJwrPnKsdJxEo=; b=qPITf5EVmMfRj+5Oz2U4mJc8tJ
        JNLjx+rk0iuFAwYSpX5ulAYJPN8p3jOLMH9CG23XLHTZu2gPpxxjaBPsXwKxwFY1e1tyEEcFLDvuj
        3LmoDILBtRsVNNJz6BoZjws+5KhoU5qizbRYbbTAOyDdv1kGP0U4GFus8CtusjoesSfrGbghp75aX
        3gODVKRSNf1vLmwJ/hiFH6MSB0IxUfgRzNoZpS/YC7+ZL2Q4j8755oiWl7mnL2XuS8DqHEikIkELK
        Hkbn2Yc/RuDtDuHNPwyR3lXLRvKtRe3FeASkYMNtDQ2ZDO9yS8lMhbWt57UKnQwGdqmhhJKjEi51V
        s6JwTCiQ==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Erd-007NU2-Ke; Tue, 28 Jun 2022 17:19:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/6] block: use default groups to register the queue attributes
Date:   Tue, 28 Jun 2022 19:18:47 +0200
Message-Id: <20220628171850.1313069-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set up the default_groups for blk_queue_ktype instead of manually calling
sysfs_create_group.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f9373da591b83..b72506770b97e 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -795,7 +795,13 @@ static const struct sysfs_ops queue_sysfs_ops = {
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
@@ -816,12 +822,6 @@ int blk_register_queue(struct gendisk *disk)
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

