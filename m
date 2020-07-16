Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D29DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EAC2071B
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 09:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgGPJCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:02:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7867 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgGPJCf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 05:02:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 05C7D9C5811B2F9A705F;
        Thu, 16 Jul 2020 17:02:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:02:27 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Sanders <justin@coraid.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] aoe: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:06:21 +0800
Message-ID: <20200716090621.14063-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liu Shixin <liushixin2@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/block/aoe/aoeblk.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 57905a495..3502a8325 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -110,7 +110,7 @@ static ssize_t aoedisk_show_payload(struct device *dev,
 	return snprintf(page, PAGE_SIZE, "%lu\n", d->maxbcnt);
 }
 
-static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
+static int aoe_debugfs_show(struct seq_file *s, void *ignored)
 {
 	struct aoedev *d;
 	struct aoetgt **t, **te;
@@ -154,10 +154,7 @@ static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int aoe_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aoedisk_debugfs_show, inode->i_private);
-}
+DEFINE_SHOW_ATTRIBUTE(aoe_debugfs);
 
 static DEVICE_ATTR(state, 0444, aoedisk_show_state, NULL);
 static DEVICE_ATTR(mac, 0444, aoedisk_show_mac, NULL);
@@ -186,13 +183,6 @@ static const struct attribute_group *aoe_attr_groups[] = {
 	NULL,
 };
 
-static const struct file_operations aoe_debugfs_fops = {
-	.open = aoe_debugfs_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 static void
 aoedisk_add_debugfs(struct aoedev *d)
 {
-- 
2.17.1

