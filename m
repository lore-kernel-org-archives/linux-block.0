Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E21FC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 05:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiFXFZZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiFXFZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A3381AC
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oEg67g1JJ2VGDXeVDvQvoJkv0B3bOgef5SNfjmnMEy8=; b=Y5QucFdJZs/33MYCeVggGOYBRa
        3JIEAPnbWIEe2Um8E99+g8jUm1ZcVsEPpdwX6dU0hdmOcdVkRugIaUiAvS8DxHxYm1Z+Jbn5Rtnlt
        /B8WHyRXgIYibhV49goq3WIIicuhB43cMbBiBXgdrVo8acEa09yKtmb7IaFu6A7jZokJScrJ7DnmG
        QHzabNiJ7Keg/PZTmCcKp/Z120g46yU6XMZR8LUj+Sm1wRH5an8L4FfCmCbYdNHglDA8C6OQj834x
        ksY21WyfSB4e7t32HhPRS1Pz1+a0gzL1sPx1borTDwxxfYR5UQ4Ijf8kkgBaNWmSSGIUQGm2sJz5E
        y6Bj5p6Q==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4bop-000cC6-0i; Fri, 24 Jun 2022 05:25:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: remove the extra gendisk reference in __blk_mq_register_dev
Date:   Fri, 24 Jun 2022 07:25:08 +0200
Message-Id: <20220624052510.3996673-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624052510.3996673-1-hch@lst.de>
References: <20220624052510.3996673-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add already grabs a reference to the parent, no need to have
another one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index c08426975856e..f4caaa668e3cf 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -215,7 +215,6 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
-	kobject_put(&dev->kobj);
 
 	q->mq_sysfs_init_done = false;
 }
@@ -261,7 +260,7 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	WARN_ON_ONCE(!q->kobj.parent);
 	lockdep_assert_held(&q->sysfs_dir_lock);
 
-	ret = kobject_add(q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
+	ret = kobject_add(q->mq_kobj, &dev->kobj, "%s", "mq");
 	if (ret < 0)
 		goto out;
 
@@ -286,7 +285,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(q->mq_kobj);
-	kobject_put(&dev->kobj);
 	return ret;
 }
 
-- 
2.30.2

