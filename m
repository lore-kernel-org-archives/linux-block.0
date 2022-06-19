Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B9C43334
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 06:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiFSGGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiFSGGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 02:06:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AA4EE30
        for <linux-block@vger.kernel.org>; Sat, 18 Jun 2022 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Py1+JvqftMHgd8Qbrshl75vgMLcKdebxa7S0H9X09FM=; b=isaVdQpy5r6Q0qTyUsUWdHquwB
        Zxe5oxv5bI5++dbJP48U4jVuwog6A7UtIfJF5sLd8CdUWTE3tt3u8QD75mgOlvdBaYMjPwL3k6FMQ
        NwiVSSqB/i+z2/1TtUklFDIVnto6SBzQCdf2v6eC8slmPEC5jfjV+Kfs1Pu9iWTAAtgJtC4r3fbye
        o5qs1hYWps7Z2ou8wAT+U7cwySCpcCIc8qXyW7KiqvJfi8ET/wJ9s119rVPWMKXquypqOJNTT93Xv
        rO/ECPiPYzeWc+S5UeBnCfHStYVu2zOnbnoqNGo6j9tCidrwkOqCME3bawgNExz1yFAHpq+Sv8iUw
        MoUhScAg==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o4L-00DJmL-UP; Sun, 19 Jun 2022 06:05:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH 1/6] mtip32xx: remove the device_status debugfs file
Date:   Sun, 19 Jun 2022 08:05:47 +0200
Message-Id: <20220619060552.1850436-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
References: <20220619060552.1850436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This file is a huge mess that iterates over all devices and is in the
way of fixing the device removal in this driver, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 141 +-----------------------------
 drivers/block/mtip32xx/mtip32xx.h |   4 -
 2 files changed, 1 insertion(+), 144 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 27386a572ba49..4151c80f5bfcc 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -94,17 +94,12 @@
 /* Device instance number, incremented each time a device is probed. */
 static int instance;
 
-static LIST_HEAD(online_list);
-static LIST_HEAD(removing_list);
-static DEFINE_SPINLOCK(dev_lock);
-
 /*
  * Global variable used to hold the major block device number
  * allocated in mtip_init().
  */
 static int mtip_major;
 static struct dentry *dfs_parent;
-static struct dentry *dfs_device_status;
 
 static u32 cpu_use[NR_CPUS];
 
@@ -2170,106 +2165,6 @@ static const struct attribute_group *mtip_disk_attr_groups[] = {
 	NULL,
 };
 
-/* debugsfs entries */
-
-static ssize_t show_device_status(struct device_driver *drv, char *buf)
-{
-	int size = 0;
-	struct driver_data *dd, *tmp;
-	unsigned long flags;
-	char id_buf[42];
-	u16 status = 0;
-
-	spin_lock_irqsave(&dev_lock, flags);
-	size += sprintf(&buf[size], "Devices Present:\n");
-	list_for_each_entry_safe(dd, tmp, &online_list, online_list) {
-		if (dd->pdev) {
-			if (dd->port &&
-			    dd->port->identify &&
-			    dd->port->identify_valid) {
-				strlcpy(id_buf,
-					(char *) (dd->port->identify + 10), 21);
-				status = *(dd->port->identify + 141);
-			} else {
-				memset(id_buf, 0, 42);
-				status = 0;
-			}
-
-			if (dd->port &&
-			    test_bit(MTIP_PF_REBUILD_BIT, &dd->port->flags)) {
-				size += sprintf(&buf[size],
-					" device %s %s (ftl rebuild %d %%)\n",
-					dev_name(&dd->pdev->dev),
-					id_buf,
-					status);
-			} else {
-				size += sprintf(&buf[size],
-					" device %s %s\n",
-					dev_name(&dd->pdev->dev),
-					id_buf);
-			}
-		}
-	}
-
-	size += sprintf(&buf[size], "Devices Being Removed:\n");
-	list_for_each_entry_safe(dd, tmp, &removing_list, remove_list) {
-		if (dd->pdev) {
-			if (dd->port &&
-			    dd->port->identify &&
-			    dd->port->identify_valid) {
-				strlcpy(id_buf,
-					(char *) (dd->port->identify+10), 21);
-				status = *(dd->port->identify + 141);
-			} else {
-				memset(id_buf, 0, 42);
-				status = 0;
-			}
-
-			if (dd->port &&
-			    test_bit(MTIP_PF_REBUILD_BIT, &dd->port->flags)) {
-				size += sprintf(&buf[size],
-					" device %s %s (ftl rebuild %d %%)\n",
-					dev_name(&dd->pdev->dev),
-					id_buf,
-					status);
-			} else {
-				size += sprintf(&buf[size],
-					" device %s %s\n",
-					dev_name(&dd->pdev->dev),
-					id_buf);
-			}
-		}
-	}
-	spin_unlock_irqrestore(&dev_lock, flags);
-
-	return size;
-}
-
-static ssize_t mtip_hw_read_device_status(struct file *f, char __user *ubuf,
-						size_t len, loff_t *offset)
-{
-	int size = *offset;
-	char *buf;
-	int rv = 0;
-
-	if (!len || *offset)
-		return 0;
-
-	buf = kzalloc(MTIP_DFS_MAX_BUF_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	size += show_device_status(NULL, buf);
-
-	*offset = size <= len ? size : len;
-	size = copy_to_user(ubuf, buf, *offset);
-	if (size)
-		rv = -EFAULT;
-
-	kfree(buf);
-	return rv ? rv : *offset;
-}
-
 static ssize_t mtip_hw_read_registers(struct file *f, char __user *ubuf,
 				  size_t len, loff_t *offset)
 {
@@ -2363,13 +2258,6 @@ static ssize_t mtip_hw_read_flags(struct file *f, char __user *ubuf,
 	return rv ? rv : *offset;
 }
 
-static const struct file_operations mtip_device_status_fops = {
-	.owner  = THIS_MODULE,
-	.open   = simple_open,
-	.read   = mtip_hw_read_device_status,
-	.llseek = no_llseek,
-};
-
 static const struct file_operations mtip_regs_fops = {
 	.owner  = THIS_MODULE,
 	.open   = simple_open,
@@ -3905,7 +3793,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	const struct cpumask *node_mask;
 	int cpu, i = 0, j = 0;
 	int my_node = NUMA_NO_NODE;
-	unsigned long flags;
 
 	/* Allocate memory for this devices private data. */
 	my_node = pcibus_to_node(pdev->bus);
@@ -3952,9 +3839,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	dd->pdev	= pdev;
 	dd->numa_node	= my_node;
 
-	INIT_LIST_HEAD(&dd->online_list);
-	INIT_LIST_HEAD(&dd->remove_list);
-
 	memset(dd->workq_name, 0, 32);
 	snprintf(dd->workq_name, 31, "mtipq%d", dd->instance);
 
@@ -4047,11 +3931,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	else
 		rv = 0; /* device in rebuild state, return 0 from probe */
 
-	/* Add to online list even if in ftl rebuild */
-	spin_lock_irqsave(&dev_lock, flags);
-	list_add(&dd->online_list, &online_list);
-	spin_unlock_irqrestore(&dev_lock, flags);
-
 	goto done;
 
 block_initialize_err:
@@ -4085,15 +3964,10 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 static void mtip_pci_remove(struct pci_dev *pdev)
 {
 	struct driver_data *dd = pci_get_drvdata(pdev);
-	unsigned long flags, to;
+	unsigned long to;
 
 	set_bit(MTIP_DDF_REMOVAL_BIT, &dd->dd_flag);
 
-	spin_lock_irqsave(&dev_lock, flags);
-	list_del_init(&dd->online_list);
-	list_add(&dd->remove_list, &removing_list);
-	spin_unlock_irqrestore(&dev_lock, flags);
-
 	mtip_check_surprise_removal(dd);
 	synchronize_irq(dd->pdev->irq);
 
@@ -4124,10 +3998,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	spin_lock_irqsave(&dev_lock, flags);
-	list_del_init(&dd->remove_list);
-	spin_unlock_irqrestore(&dev_lock, flags);
-
 	kfree(dd);
 
 	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
@@ -4250,15 +4120,6 @@ static int __init mtip_init(void)
 		pr_warn("Error creating debugfs parent\n");
 		dfs_parent = NULL;
 	}
-	if (dfs_parent) {
-		dfs_device_status = debugfs_create_file("device_status",
-					0444, dfs_parent, NULL,
-					&mtip_device_status_fops);
-		if (IS_ERR_OR_NULL(dfs_device_status)) {
-			pr_err("Error creating device_status node\n");
-			dfs_device_status = NULL;
-		}
-	}
 
 	/* Register our PCI operations. */
 	error = pci_register_driver(&mtip_pci_driver);
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 6816beb45352b..a80419c57bbe4 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -462,10 +462,6 @@ struct driver_data {
 
 	int isr_binding;
 
-	struct list_head online_list; /* linkage for online list */
-
-	struct list_head remove_list; /* linkage for removing list */
-
 	int unal_qdepth; /* qdepth of unaligned IO queue */
 };
 
-- 
2.30.2

