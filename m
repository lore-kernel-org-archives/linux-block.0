Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB20DC07E95
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AE2611AB
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 08:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhGMIVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:21:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21793 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIVa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1626164320; x=1657700320;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Erd4UruOIhH9MWFQzDkFvEPxiSHNH4RzYIul1nAZm30=;
  b=jSl6R3ZAKEwbHu+N/7fDtwCUcw6xNnQs6VuncxxEs/+Sq9RGErD7MvW3
   sH9/En/FifkmY+OlHfY1xTjm7aFrytP0nroqyIi1rkF4pfnLGs+rva1OQ
   Q2UzDIRu21kx90bebDzZou9W57t7+UrAVQWZl13tEk4/AZJ4NF6QrEkoz
   GPIlla2bSkD6Kdnn8o1+vOm/4HjSbEdGN/9V9acwCOPE9YkxU+t/RLdke
   rOYXpAlb1Z0Nl586ZJPd0tRHuCPj8OK1ENFG93Em+njmN62VBM0zYLg2g
   1nSEl2NrA2a03UTV7v5vbgQsE+vRfB8pzJn1xeqh0FoyKUueAH6gTGvRR
   g==;
IronPort-SDR: EVPAK9ugVksFN/LjCAWiNyeKNxSrJFOP+FaHs3k3p7tE+4vtqphdsU+D9BsDujPmrSON+uzUGF
 pwWVHDygNwSMV9kmeqKMSJnZybcbg4XFHwYur4l731KCZN/yoPJ7XYlTnC9d0RTRCtMlrRz+Ma
 +3fpYhpN3pvaFpUDrHZTyQ6RVqqjDCXgVKBnRS3om6JJAiIdWAKHsUXcKVx2PiZ+H20a8Y1EkU
 rRp1r07x9q8RQyAbwzF+3DVD76ZKgVWEBt10XWFSVZXjNarCyqyA0PW2kmdRacgXV3s03qGnBK
 NgA=
X-IronPort-AV: E=Sophos;i="5.84,236,1620662400"; 
   d="scan'208";a="179249431"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2021 16:18:40 +0800
IronPort-SDR: hDfDwt4tfsXSnYiQ0P7zCuhBiqXd9VhmwTSlwFjjhVMNCNMmDM0dLRNNRiZ/SF+2oP1cujaL5D
 7oGfr8j2mapt+oWY1Ex8N8adrYQPZa3x8xcMGmlDF1d7EA1MeZPEe4CbzOP4D+XdLNOi65tGJP
 jFu+zAXZadJCOXFmfmLua3cpKdd/qjZ+6iCAEfIISFKxmOVtm+sJO8dmsJ76drkqtxU+fGn5p8
 rncq2zHo/GxqdSN4YyBJAIKsgVcYlshrvIeKMyOLubdx7b4l+6ftTOAHL9//eJxBkCIWOhsNq1
 u1lmfRX71dfz/Sok5gKIQOEV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 00:55:23 -0700
IronPort-SDR: FZini2tExTGFePXDkHYknKelRORYr52rTw6aW7pwTjR7XUFzH+BGpqQ7cpA+WZZtI3Ru9FN2HT
 QD/7qIA4oQ/zMrPzesCekR4H4nBFCM7X/Gnt1awPpyfjoB/tLyTPE8Fn089bY8B6kZtfDfQWMk
 qaduvahcsECr+hkehgF7cBLGASjGPa0c1ec8/gBsPkYwHUqFO082A+IEc1lodIYzcNI68BBjGK
 2EqJdu5B/iOg8waeVwJG/wGPg+svQUDyKATmnYNDI82WEUL/2fCiVXwpZJ8k2vqah3/K0kSH1S
 EpU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2021 01:18:40 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: remove blk-mq-sysfs dead code
Date:   Tue, 13 Jul 2021 17:18:37 +0900
Message-Id: <20210713081837.524422-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In block/blk-mq-sysfs.c, struct blk_mq_ctx_sysfs_entry is not used to
define any attribute since the "mq" sysfs directory contains only
sub-directories (no attribute files). As a result, blk_mq_sysfs_show(),
blk_mq_sysfs_store(), and struct sysfs_ops blk_mq_sysfs_ops are all
unused and unnecessary. Remove all this unused code.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-mq-sysfs.c | 55 --------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 7b52e7657b2d..253c857cba47 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -45,60 +45,12 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	kfree(hctx);
 }
 
-struct blk_mq_ctx_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct blk_mq_ctx *, char *);
-	ssize_t (*store)(struct blk_mq_ctx *, const char *, size_t);
-};
-
 struct blk_mq_hw_ctx_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct blk_mq_hw_ctx *, char *);
 	ssize_t (*store)(struct blk_mq_hw_ctx *, const char *, size_t);
 };
 
-static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
-				 char *page)
-{
-	struct blk_mq_ctx_sysfs_entry *entry;
-	struct blk_mq_ctx *ctx;
-	struct request_queue *q;
-	ssize_t res;
-
-	entry = container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);
-	ctx = container_of(kobj, struct blk_mq_ctx, kobj);
-	q = ctx->queue;
-
-	if (!entry->show)
-		return -EIO;
-
-	mutex_lock(&q->sysfs_lock);
-	res = entry->show(ctx, page);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
-}
-
-static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
-				  const char *page, size_t length)
-{
-	struct blk_mq_ctx_sysfs_entry *entry;
-	struct blk_mq_ctx *ctx;
-	struct request_queue *q;
-	ssize_t res;
-
-	entry = container_of(attr, struct blk_mq_ctx_sysfs_entry, attr);
-	ctx = container_of(kobj, struct blk_mq_ctx, kobj);
-	q = ctx->queue;
-
-	if (!entry->store)
-		return -EIO;
-
-	mutex_lock(&q->sysfs_lock);
-	res = entry->store(ctx, page, length);
-	mutex_unlock(&q->sysfs_lock);
-	return res;
-}
-
 static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 				    struct attribute *attr, char *page)
 {
@@ -198,23 +150,16 @@ static struct attribute *default_hw_ctx_attrs[] = {
 };
 ATTRIBUTE_GROUPS(default_hw_ctx);
 
-static const struct sysfs_ops blk_mq_sysfs_ops = {
-	.show	= blk_mq_sysfs_show,
-	.store	= blk_mq_sysfs_store,
-};
-
 static const struct sysfs_ops blk_mq_hw_sysfs_ops = {
 	.show	= blk_mq_hw_sysfs_show,
 	.store	= blk_mq_hw_sysfs_store,
 };
 
 static struct kobj_type blk_mq_ktype = {
-	.sysfs_ops	= &blk_mq_sysfs_ops,
 	.release	= blk_mq_sysfs_release,
 };
 
 static struct kobj_type blk_mq_ctx_ktype = {
-	.sysfs_ops	= &blk_mq_sysfs_ops,
 	.release	= blk_mq_ctx_sysfs_release,
 };
 
-- 
2.31.1

