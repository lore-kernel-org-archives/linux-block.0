Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5CC433E6
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 07:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D5D64FCC
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 07:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBFHNX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Feb 2021 02:13:23 -0500
Received: from m12-14.163.com ([220.181.12.14]:45331 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBFHNW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Feb 2021 02:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XTjul6edC9FmtB9jkA
        AnYebdbC+m5/JicB+b/cgtNbU=; b=ZvyL5N+srJabKV3KJATl6BynrlSfxMUbQf
        ZuqtO6OOO1NDsIjzdK8CaIBcNRP7lXFQjciNbdzNrDeoLc4xPz/agkK/HY4FNAyz
        IdJf2gT+ZqofDY6Zr/c+NA0TDAFkVK/Bh8cSmdD/w1nXSLJDGQ3r+WLE1Anu+26G
        PMKsPBODA=
Received: from localhost.localdomain.localdomain (unknown [182.150.162.248])
        by smtp10 (Coremail) with SMTP id DsCowACntpoKQR5g_q3Ajg--.62473S2;
        Sat, 06 Feb 2021 15:11:07 +0800 (CST)
From:   winndows@163.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Liao Pingfang <winndows@163.com>
Subject: [PATCH] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  6 Feb 2021 15:10:55 +0800
Message-Id: <1612595455-4050-1-git-send-email-winndows@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsCowACntpoKQR5g_q3Ajg--.62473S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF13tw1DCr4kZr45KFW3ZFb_yoW8uFW7pF
        s3Ca1DCFW0kw4UWrs5tFsxZa4S93Z7try0gry2v34SyryDurWSyFs5WFWftFyrKFWrJrsr
        XFn8GFy8J3WUCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO0eLUUUUU=
X-Originating-IP: [182.150.162.248]
X-CM-SenderInfo: hzlq0vxrzvqiywtou0bp/1tbi8QsxmV-PKDed+AAAs4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Liao Pingfang <winndows@163.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liao Pingfang <winndows@163.com>
---
 drivers/block/nbd.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e6ea5d3..8b9622e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1529,17 +1529,7 @@ static int nbd_dbg_tasks_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_tasks_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_tasks_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_tasks_ops = {
-	.open = nbd_dbg_tasks_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_tasks);
 
 static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 {
@@ -1564,17 +1554,7 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int nbd_dbg_flags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nbd_dbg_flags_show, inode->i_private);
-}
-
-static const struct file_operations nbd_dbg_flags_ops = {
-	.open = nbd_dbg_flags_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(nbd_dbg_flags);
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd)
 {
@@ -1592,11 +1572,11 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
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
1.8.3.1


