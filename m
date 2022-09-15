Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7ADECAAD8
	for <linux-block@archiver.kernel.org>; Thu, 15 Sep 2022 02:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIOCAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Sep 2022 22:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIOCAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 22:00:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1872A418
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 19:00:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MSgKt41N3z14QT1;
        Thu, 15 Sep 2022 09:56:34 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 10:00:32 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 10:00:32 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify aoe_debugfs
Date:   Thu, 15 Sep 2022 10:34:24 +0800
Message-ID: <20220915023424.3198940-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/block/aoe/aoeblk.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 12b3ca8f6f4a..128722cf6c3c 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -108,7 +108,7 @@ static ssize_t aoedisk_show_payload(struct device *dev,
 	return sysfs_emit(page, "%lu\n", d->maxbcnt);
 }
 
-static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
+static int aoe_debugfs_show(struct seq_file *s, void *ignored)
 {
 	struct aoedev *d;
 	struct aoetgt **t, **te;
@@ -151,11 +151,7 @@ static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
 
 	return 0;
 }
-
-static int aoe_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aoedisk_debugfs_show, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(aoe_debugfs);
 
 static DEVICE_ATTR(state, 0444, aoedisk_show_state, NULL);
 static DEVICE_ATTR(mac, 0444, aoedisk_show_mac, NULL);
@@ -184,13 +180,6 @@ static const struct attribute_group *aoe_attr_groups[] = {
 	NULL,
 };
 
-static const struct file_operations aoe_debugfs_fops = {
-	.open = aoe_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static void
 aoedisk_add_debugfs(struct aoedev *d)
 {
-- 
2.25.1

