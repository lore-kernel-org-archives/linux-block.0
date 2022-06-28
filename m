Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiF1RTK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiF1RTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 13:19:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0551C30550
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ClnuW8bWSvnJCRR1id7GPzNrUWMXxCR7E38O98YpTl4=; b=HEmoZTw1hlUTjxIC40Ug1QVcyS
        46IuD8Ps4dWb6jw6QTOBei3RPwHG0z2NTlFaQrt5ucY2ZTsnzMAZ2VKjKsvt98z2LaczUW/ULh6tS
        ZdGl2HrY+L7sBxVUztQ6pwqjPEriDSMpW+efikpcarYmTeC8BKXVLWBB0JuPfevw3guezVs+PTC0e
        zv/Xm9VIGPuB9MvX0SEORaK+EsbkWr0DQwSQTk/jp0uyCz874uAqCBCQ+TMjGzNAhi3y7Mxcl8ZbE
        viW2W9uNlkpXvNxTfo/ofFXdu9ERSZr2rtyom/yS8qW/03Oudc4cXn1jXCFXFv10h3NvKrc2K1AL+
        ft896AiQ==;
Received: from [2001:4bb8:199:3788:e965:1541:b076:2977] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o6Erg-007NUU-8A; Tue, 28 Jun 2022 17:19:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/6] block: remove the extra gendisk reference in __blk_mq_register_dev
Date:   Tue, 28 Jun 2022 19:18:48 +0200
Message-Id: <20220628171850.1313069-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628171850.1313069-1-hch@lst.de>
References: <20220628171850.1313069-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add already grabs a reference to the parent, no need to have
another one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

