Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129FDC433E0
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECD7619E3
	for <linux-block@archiver.kernel.org>; Wed, 31 Mar 2021 07:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhCaHe1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 03:34:27 -0400
Received: from m12-17.163.com ([220.181.12.17]:47498 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhCaHeG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 03:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7Vr4f
        CiQXMgkEtD0jp2lje0Un+oKilPC7kaPBeblKvk=; b=ghyXpnAwD+6vdSKxtuNrL
        op9yT4byz0a/TZtIl7BC0qtgrkCAIq64z3qtjK9HSsq0VKkvRQP0bAIObUITJ2G0
        lP8NmpIUjnnI6bguFZhfafL/t8SH+TaUTviX0FpCs7yCcsGhdaq5Bnq2+SEeODyo
        qyCeje+/irH5SbuU1LylFY=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowABHSZGUJWRgEOG7sw--.38716S2;
        Wed, 31 Mar 2021 15:32:37 +0800 (CST)
From:   dingsenjie@163.com
To:     josh.h.morris@us.ibm.com, pjk1939@linux.ibm.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] block: rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed, 31 Mar 2021 15:31:51 +0800
Message-Id: <20210331073151.15836-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABHSZGUJWRgEOG7sw--.38716S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw18Ww1fGF1DGFy3Ar1xGrg_yoW8tF1xpa
        95uw1UAF1kAr1qkr15CayUZasav3Z3J3y8X397u34SyFn5AryagF1DJrWFyF98K3y8Jr4q
        qan8KryUXay5tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bYyIUUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRRVmyFPAK05EBgAAsK
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/block/rsxx/core.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 63f5498..8979843 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -150,16 +150,6 @@ static int rsxx_attr_stats_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static int rsxx_attr_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_stats_show, inode->i_private);
-}
-
-static int rsxx_attr_pci_regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, rsxx_attr_pci_regs_show, inode->i_private);
-}
-
 static ssize_t rsxx_cram_read(struct file *fp, char __user *ubuf,
 			      size_t cnt, loff_t *ppos)
 {
@@ -206,21 +196,9 @@ static ssize_t rsxx_cram_write(struct file *fp, const char __user *ubuf,
 	.write		= rsxx_cram_write,
 };
 
-static const struct file_operations debugfs_stats_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_stats);
 
-static const struct file_operations debugfs_pci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_pci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(rsxx_attr_pci_regs);
 
 static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 {
@@ -234,13 +212,13 @@ static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 
 	debugfs_stats = debugfs_create_file("stats", 0444,
 					    card->debugfs_dir, card,
-					    &debugfs_stats_fops);
+					    &rsxx_attr_stats_fops);
 	if (IS_ERR_OR_NULL(debugfs_stats))
 		goto failed_debugfs_stats;
 
 	debugfs_pci_regs = debugfs_create_file("pci_regs", 0444,
 					       card->debugfs_dir, card,
-					       &debugfs_pci_regs_fops);
+					       &rsxx_attr_pci_regs_fops);
 	if (IS_ERR_OR_NULL(debugfs_pci_regs))
 		goto failed_debugfs_pci_regs;
 
-- 
1.9.1


