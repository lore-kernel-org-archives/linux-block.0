Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6193C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDC6613B1
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhFIMWF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 08:22:05 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5308 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFIMWF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 08:22:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0QzL75b4z19S5w;
        Wed,  9 Jun 2021 20:15:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:20:03 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:20:02 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mtip32xx: remove unnecessary oom message
Date:   Wed, 9 Jun 2021 20:19:58 +0800
Message-ID: <20210609121958.13992-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 589cb0f1e030..ff3e7b3f5ad8 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2238,7 +2238,6 @@ static ssize_t show_device_status(struct device_driver *drv, char *buf)
 static ssize_t mtip_hw_read_device_status(struct file *f, char __user *ubuf,
 						size_t len, loff_t *offset)
 {
-	struct driver_data *dd =  (struct driver_data *)f->private_data;
 	int size = *offset;
 	char *buf;
 	int rv = 0;
@@ -2247,11 +2246,8 @@ static ssize_t mtip_hw_read_device_status(struct file *f, char __user *ubuf,
 		return 0;
 
 	buf = kzalloc(MTIP_DFS_MAX_BUF_SIZE, GFP_KERNEL);
-	if (!buf) {
-		dev_err(&dd->pdev->dev,
-			"Memory allocation: status buffer\n");
+	if (!buf)
 		return -ENOMEM;
-	}
 
 	size += show_device_status(NULL, buf);
 
@@ -2277,11 +2273,8 @@ static ssize_t mtip_hw_read_registers(struct file *f, char __user *ubuf,
 		return 0;
 
 	buf = kzalloc(MTIP_DFS_MAX_BUF_SIZE, GFP_KERNEL);
-	if (!buf) {
-		dev_err(&dd->pdev->dev,
-			"Memory allocation: register buffer\n");
+	if (!buf)
 		return -ENOMEM;
-	}
 
 	size += sprintf(&buf[size], "H/ S ACTive      : [ 0x");
 
@@ -2343,11 +2336,8 @@ static ssize_t mtip_hw_read_flags(struct file *f, char __user *ubuf,
 		return 0;
 
 	buf = kzalloc(MTIP_DFS_MAX_BUF_SIZE, GFP_KERNEL);
-	if (!buf) {
-		dev_err(&dd->pdev->dev,
-			"Memory allocation: flag buffer\n");
+	if (!buf)
 		return -ENOMEM;
-	}
 
 	size += sprintf(&buf[size], "Flag-port : [ %08lX ]\n",
 							dd->port->flags);
@@ -2884,11 +2874,8 @@ static int mtip_hw_init(struct driver_data *dd)
 
 	dd->port = kzalloc_node(sizeof(struct mtip_port), GFP_KERNEL,
 				dd->numa_node);
-	if (!dd->port) {
-		dev_err(&dd->pdev->dev,
-			"Memory allocation: port structure\n");
+	if (!dd->port)
 		return -ENOMEM;
-	}
 
 	/* Continue workqueue setup */
 	for (i = 0; i < MTIP_MAX_SLOT_GROUPS; i++)
@@ -4002,11 +3989,8 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		cpu_to_node(raw_smp_processor_id()), raw_smp_processor_id());
 
 	dd = kzalloc_node(sizeof(struct driver_data), GFP_KERNEL, my_node);
-	if (dd == NULL) {
-		dev_err(&pdev->dev,
-			"Unable to allocate memory for driver data\n");
+	if (!dd)
 		return -ENOMEM;
-	}
 
 	/* Attach the private data to this PCI device.  */
 	pci_set_drvdata(pdev, dd);
-- 
2.25.1


