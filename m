Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBFC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 08:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiLUIDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 03:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiLUIDZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 03:03:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9D21881;
        Wed, 21 Dec 2022 00:03:19 -0800 (PST)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NcQrx22nnzmWjK;
        Wed, 21 Dec 2022 16:02:09 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 16:03:16 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] blk-mq: cleanup unused methods: blk_mq_hw_sysfs_store
Date:   Wed, 21 Dec 2022 16:23:53 +0800
Message-ID: <20221221082353.732275-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We found that the blk_mq_hw_sysfs_store interface has no place to use.
The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
the show method and does not use the store method.

Since this patch:
4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
moved the store method to debuffs, the store method is not used anymore.

So let me do some tiny work to clean up unused code.

Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 block/blk-mq-sysfs.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 93997d297d42..40450e469ba6 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -70,28 +70,6 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	return res;
 }
 
-static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
-				     struct attribute *attr, const char *page,
-				     size_t length)
-{
-	struct blk_mq_hw_ctx_sysfs_entry *entry;
-	struct blk_mq_hw_ctx *hctx;
-	struct request_queue *q;
-	ssize_t res;
-
-	entry = container_of(attr, struct blk_mq_hw_ctx_sysfs_entry, attr);
-	hctx = container_of(kobj, struct blk_mq_hw_ctx, kobj);
-	q = hctx->queue;
-
-	if (!entry->store)
-		return -EIO;
-
-	mutex_lock(&q->sysfs_lock);
-	res = entry->store(hctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
-}
-
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
 					    char *page)
 {
@@ -150,7 +128,6 @@ ATTRIBUTE_GROUPS(default_hw_ctx);
 
 static const struct sysfs_ops blk_mq_hw_sysfs_ops = {
 	.show	= blk_mq_hw_sysfs_show,
-	.store	= blk_mq_hw_sysfs_store,
 };
 
 static struct kobj_type blk_mq_ktype = {
-- 
2.31.1

