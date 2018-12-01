Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA7C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733E220834
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 14:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvcjffN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733E220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeLBBg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 20:36:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44538 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeLBBg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 20:36:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so4220876pls.11;
        Sat, 01 Dec 2018 06:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sRQJFeKwcT7e6SsQ8SngzjCV6HOa8md7Jsafg2hqBnE=;
        b=EvcjffN/Xu6OHbcgraUM4SB7a7iWZstLBpdtsEovYLL5L/Oa7R+pHtmMqxKKphIQFU
         T8xqmTDqCQCQmM8fw/iS7QIpPIej2xQtsuwxf+hPXEJbe07wt/t8l9tmfX05Q2CV2fmX
         m6DGYd/txSQKiJaVS/l3DvhzQh3ToVqeq3+lfNXmhHcahrHrhozWYM0Iu6VF1JLTfjvv
         denqZSDT3lj5RCBGxPxEw01eVkYkVfYf6aQpRV5MLUuUJkuoQlqvtwK+gX31n3PBcWa0
         cilL3/XLeYyIzL40/jzesIAXwGeiuBVgjVd0P2gmYkwzJPX32KpesfsMP9kzCUU9pNyp
         jPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sRQJFeKwcT7e6SsQ8SngzjCV6HOa8md7Jsafg2hqBnE=;
        b=rh2yFdTbe+y6ZM54Pdzt93PDnDk7/S/3i9V0+fAk5HBGkn5Pu1+RM2p69M5clv+Le+
         qWKbjN9lzdq1GF9jcA2EEKfT9bqXRiUZW9+aj9iK+thINJ6Z22Qb9Ue5+WNqwaqQma5D
         ub0O/DB2PxEr3M3f4RV+dE0Ywep0K2XmBbH6lg57oJIBfveeq2HSWFSGPvVCReBuQRke
         4ue6I8mrcXFA9bMir4EzPT6Sd2fAKf6SZSFN/rtTQ/m2KSEhvkf7jn5OtPnLBGP8ny7j
         A4apXEa97Z5s3BjpbZG6zIN6niuXNAmO8zGaDT8VVTWTB9tPk7B0p12/D01w/Zun40b5
         utAg==
X-Gm-Message-State: AA+aEWYUnRiL1uayn4lWFCRVlBd2QbkNKiMX5RGLdWy4gISMEnyPhrBn
        TiNbPKSEuvHHwsVzW0BBRek=
X-Google-Smtp-Source: AFSGD/XXJB1GvG5h5EvD9nsFPEPKnikYthIWrF+dMenB0oglR9y2AFY0zgnCf8XEJa73Zwtbu65yXA==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr9392688plc.220.1543674258592;
        Sat, 01 Dec 2018 06:24:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y29sm13322924pga.59.2018.12.01.06.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 06:24:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ed.cashin@acm.org, axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, josef@toxicpanda.com,
        linux-block@vger.kernel.org, josh.h.morris@us.ibm.com,
        pjk1939@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] block: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Sat,  1 Dec 2018 09:24:14 -0500
Message-Id: <20181201142414.7766-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v2:
-Modify some function names to avoid compilation errors
---
 drivers/block/aoe/aoeblk.c        | 16 +++-----------
 drivers/block/drbd/drbd_debugfs.c | 13 +----------
 drivers/block/nbd.c               | 28 ++++--------------------
 drivers/block/pktcdvd.c           | 36 +++++++++++--------------------
 drivers/block/rsxx/core.c         | 35 ++++++------------------------
 5 files changed, 26 insertions(+), 102 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index ed26b7287256..5d2be31ac7f8 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -110,7 +110,7 @@ static ssize_t aoedisk_show_payload(struct device *dev,
 	return snprintf(page, PAGE_SIZE, "%lu\n", d->maxbcnt);
 }
 
-static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
+static int aoe_show(struct seq_file *s, void *ignored)
 {
 	struct aoedev *d;
 	struct aoetgt **t, **te;
@@ -154,11 +154,6 @@ static int aoedisk_debugfs_show(struct seq_file *s, void *ignored)
 	return 0;
 }
 
-static int aoe_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aoedisk_debugfs_show, inode->i_private);
-}
-
 static DEVICE_ATTR(state, 0444, aoedisk_show_state, NULL);
 static DEVICE_ATTR(mac, 0444, aoedisk_show_mac, NULL);
 static DEVICE_ATTR(netif, 0444, aoedisk_show_netif, NULL);
@@ -186,12 +181,7 @@ static const struct attribute_group *aoe_attr_groups[] = {
 	NULL,
 };
 
-static const struct file_operations aoe_debugfs_fops = {
-	.open = aoe_debugfs_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(aoe);
 
 static void
 aoedisk_add_debugfs(struct aoedev *d)
@@ -208,7 +198,7 @@ aoedisk_add_debugfs(struct aoedev *d)
 		p++;
 	BUG_ON(*p == '\0');
 	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
-				    &aoe_debugfs_fops);
+				    &aoe_fops);
 	if (IS_ERR_OR_NULL(entry)) {
 		pr_info("aoe: cannot create debugfs file for %s\n",
 			d->gd->disk_name);
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 5d5e8d6a8a56..e46c198c2e6a 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -892,18 +892,7 @@ static int drbd_version_show(struct seq_file *m, void *ignored)
 	return 0;
 }
 
-static int drbd_version_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, drbd_version_show, NULL);
-}
-
-static const struct file_operations drbd_version_fops = {
-	.owner = THIS_MODULE,
-	.open = drbd_version_open,
-	.llseek = seq_lseek,
-	.read = seq_read,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(drbd_version);
 
 /* not __exit, may be indirectly called
  * from the module-load-failure path as well. */
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4d4d6129ff66..415473cc3b7e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1399,17 +1399,7 @@ static int nbd_dbg_tasks_show(struct seq_file *s, void *unused)
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
@@ -1434,17 +1424,7 @@ static int nbd_dbg_flags_show(struct seq_file *s, void *unused)
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
@@ -1462,11 +1442,11 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
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
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 9381f4e3b221..2db2ac47d87d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -106,7 +106,7 @@ static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
 static int pkt_remove_dev(dev_t pkt_dev);
-static int pkt_seq_show(struct seq_file *m, void *p);
+static int pkt_debugfs_show(struct seq_file *m, void *p);
 
 static sector_t get_zone(sector_t sector, struct pktcdvd_device *pd)
 {
@@ -452,23 +452,7 @@ static void pkt_sysfs_cleanup(void)
 
  *******************************************************************/
 
-static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
-{
-	return pkt_seq_show(m, p);
-}
-
-static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pkt_debugfs_seq_show, inode->i_private);
-}
-
-static const struct file_operations debug_fops = {
-	.open		= pkt_debugfs_fops_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.owner		= THIS_MODULE,
-};
+DEFINE_SHOW_ATTRIBUTE(pkt_debugfs);
 
 static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 {
@@ -479,7 +463,8 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444,
-					     pd->dfs_d_root, pd, &debug_fops);
+					     pd->dfs_d_root, pd,
+					     &pkt_debugfs_fops);
 }
 
 static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
@@ -2501,7 +2486,7 @@ static void pkt_init_queue(struct pktcdvd_device *pd)
 	q->queuedata = pd;
 }
 
-static int pkt_seq_show(struct seq_file *m, void *p)
+static int pkt_debugfs_show(struct seq_file *m, void *p)
 {
 	struct pktcdvd_device *pd = m->private;
 	char *msg;
@@ -2617,7 +2602,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		goto out_mem;
 	}
 
-	proc_create_single_data(pd->name, 0, pkt_proc, pkt_seq_show, pd);
+	proc_create_single_data(pd->name, 0, pkt_proc, pkt_debugfs_show, pd);
 	pkt_dbg(1, pd, "writer mapped to %s\n", bdevname(bdev, b));
 	return 0;
 
@@ -2628,7 +2613,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	return ret;
 }
 
-static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
+static int pkt_ioctl(struct block_device *bdev, fmode_t mode,
+		     unsigned int cmd, unsigned long arg)
 {
 	struct pktcdvd_device *pd = bdev->bd_disk->private_data;
 	int ret;
@@ -2861,7 +2847,8 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
 	mutex_unlock(&ctl_mutex);
 }
 
-static long pkt_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long pkt_ctl_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct pkt_ctrl_command ctrl_cmd;
@@ -2899,7 +2886,8 @@ static long pkt_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 }
 
 #ifdef CONFIG_COMPAT
-static long pkt_ctl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long pkt_ctl_compat_ioctl(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
 	return pkt_ctl_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 0cf4509d575c..b02886cbd0d1 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -61,7 +61,7 @@ static DEFINE_IDA(rsxx_disk_ida);
 
 /* --------------------Debugfs Setup ------------------- */
 
-static int rsxx_attr_pci_regs_show(struct seq_file *m, void *p)
+static int pci_regs_show(struct seq_file *m, void *p)
 {
 	struct rsxx_cardinfo *card = m->private;
 
@@ -123,7 +123,7 @@ static int rsxx_attr_pci_regs_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static int rsxx_attr_stats_show(struct seq_file *m, void *p)
+static int stats_show(struct seq_file *m, void *p)
 {
 	struct rsxx_cardinfo *card = m->private;
 	int i;
@@ -164,16 +164,6 @@ static int rsxx_attr_stats_show(struct seq_file *m, void *p)
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
@@ -220,21 +210,8 @@ static const struct file_operations debugfs_cram_fops = {
 	.write		= rsxx_cram_write,
 };
 
-static const struct file_operations debugfs_stats_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations debugfs_pci_regs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= rsxx_attr_pci_regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stats);
+DEFINE_SHOW_ATTRIBUTE(pci_regs);
 
 static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 {
@@ -248,13 +225,13 @@ static void rsxx_debugfs_dev_new(struct rsxx_cardinfo *card)
 
 	debugfs_stats = debugfs_create_file("stats", 0444,
 					    card->debugfs_dir, card,
-					    &debugfs_stats_fops);
+					    &stats_fops);
 	if (IS_ERR_OR_NULL(debugfs_stats))
 		goto failed_debugfs_stats;
 
 	debugfs_pci_regs = debugfs_create_file("pci_regs", 0444,
 					       card->debugfs_dir, card,
-					       &debugfs_pci_regs_fops);
+					       &pci_regs_fops);
 	if (IS_ERR_OR_NULL(debugfs_pci_regs))
 		goto failed_debugfs_pci_regs;
 
-- 
2.17.0

