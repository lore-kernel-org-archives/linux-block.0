Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D2BC433E3
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973542078C
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgGPJCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:02:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgGPJCX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 05:02:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CAA0674F7CDB51A6087;
        Thu, 16 Jul 2020 17:02:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:02:16 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josef Bacik <josef@toxicpanda.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:06:12 +0800
Message-ID: <20200716090612.14005-1-miaoqinglang@huawei.com>
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
 drivers/block/nbd.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 25208ff71..43f9cfd9a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1540,17 +1540,7 @@ static int nbd_dbg_tasks_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_tasks_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_tasks_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_tasks_ops = {
-	.open = nbd_dbg_tasks_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_tasks);
 
 static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 {
@@ -1575,17 +1565,7 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_flags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_flags_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_flags_ops = {
-	.open = nbd_dbg_flags_open,
-	.read_iter = seq_read_iter,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_flags);
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd)
 {
@@ -1603,11 +1583,11 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 	}
 	config->dbg_dir = dir;
 
-	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_ops);
+	debugfs_create_file("tasks", 0444, dir, nbd, &nbd_dbg_tasks_fops);
 	debugfs_create_u64("size_bytes", 0444, dir, &config->bytesize);
 	debugfs_create_u32("timeout", 0444, dir, &nbd->tag_set.timeout);
 	debugfs_create_u64("blocksize", 0444, dir, &config->blksize);
-	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_ops);
+	debugfs_create_file("flags", 0444, dir, nbd, &nbd_dbg_flags_fops);
 
 	return 0;
 }
-- 
2.17.1

