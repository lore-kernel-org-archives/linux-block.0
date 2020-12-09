Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28235C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD7023BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgLINJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:09:15 -0500
Received: from mx4.veeam.com ([104.41.138.86]:33956 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgLINJE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 08:09:04 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 08:09:02 EST
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 6573FB9A6F;
        Wed,  9 Dec 2020 16:01:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1607518910; bh=/xuQD7v393TvlYTOY+wfRjPvoSZ5yMpkOEbp/g6NwMA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X3k4xoB41/kSZCSYBbNYq0IjOh7AUDvFpa57zDh6VJM8fz49FqLwkWSiF2/8Ffj1x
         w4zoXXYLjWdUJ6WzKMsmuIzS3223+qBUihnc74i4++8lp5sv8qs0JQ7eShx9lvhqvh
         khVQbxOYyIKDq1iqbmDFwyBTnGSK0WB4bF7FcTw8=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 9 Dec 2020 14:01:48 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <johannes.thumshirn@wdc.com>,
        <koct9i@gmail.com>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <hare@suse.de>, <josef@toxicpanda.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel.tide@veeam.com>, <sergei.shtepa@veeam.com>
Subject: [PATCH 2/3] block: blk_interposer - sample
Date:   Wed, 9 Dec 2020 16:01:50 +0300
Message-ID: <1607518911-30692-3-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627160
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This sample demonstrates how to use blk_interposer.
It show how to properly connect the interposer module to kernel,
and perform the simplest monitoring of the number of bio.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 samples/blk_interposer/Makefile         |   2 +
 samples/blk_interposer/blk-interposer.c | 276 ++++++++++++++++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 samples/blk_interposer/Makefile
 create mode 100644 samples/blk_interposer/blk-interposer.c

diff --git a/samples/blk_interposer/Makefile b/samples/blk_interposer/Makefile
new file mode 100644
index 000000000000..b11aefde2b1c
--- /dev/null
+++ b/samples/blk_interposer/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SAMPLE_BLK_INTERPOSER) += blk-interposer.o
diff --git a/samples/blk_interposer/blk-interposer.c b/samples/blk_interposer/blk-interposer.c
new file mode 100644
index 000000000000..92b4c1fcf8f7
--- /dev/null
+++ b/samples/blk_interposer/blk-interposer.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Block layer interposer allow to interpose bio requests from kernel module.
+ * This allows you to monitor requests, modify requests, add new request,
+ * or even redirect requests to another devices.
+ *
+ * This sample demonstrates how to use blk_interposer.
+ * It show how to properly connect the interposer module to kernel,
+ * and perform the simplest monitoring of the number of bio.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/blkdev.h>
+#include <linux/genhd.h>
+#include <linux/blk-mq.h>
+
+int device_major = 8;
+int device_minor;
+int fmode = FMODE_READ | FMODE_WRITE;
+
+/*
+ * Each interposer must have a common part in the form of the blk_interposer structure,
+ * as well as its own unique data.
+ */
+struct my_interposer {
+	/*
+	 * Common part of block device interposer.
+	 */
+	struct blk_interposer interposer;
+	/*
+	 * Specific part for our interposer data.
+	 */
+	atomic_t counter;
+};
+
+struct my_interposer my_ip;
+
+/**
+ * blk_interposer_attach - Attach interposer to disk
+ * @disk: target disk
+ * @interposer: block device interposer
+ */
+static int blk_interposer_attach(struct gendisk *disk, struct blk_interposer *interposer)
+{
+	int ret = 0;
+
+	/*
+	 * Stop disks queue processing.
+	 */
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+
+	/*
+	 * Check if the interposer is already busy.
+	 * The interposer will only connect if it is not busy.
+	 */
+	if (blk_has_interposer(disk)) {
+		pr_info("The interposer is already busy.\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * Attach the interposer.
+	 */
+	disk->interposer = interposer;
+	/*
+	 * And while the queue is stopped, we can do something specific for our module.
+	 */
+	pr_info("Block device interposer attached successfully.\n");
+
+out:
+	/*
+	 * Resume disks queue processing
+	 */
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return ret;
+}
+
+/**
+ * blk_interposer_detach - Detach interposer from disk
+ * @disk: target disk
+ * @interposer: block device interposer
+ */
+static int blk_interposer_detach(struct gendisk *disk, struct blk_interposer *interposer)
+{
+	int ret = 0;
+
+	if (WARN_ON(!disk))
+		return -EINVAL;
+
+	/*
+	 * Stop disks queue processing.
+	 */
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+
+	/*
+	 * Check if the interposer is still available.
+	 */
+	if (!disk->interposer) {
+		pr_info("The interposer is not available.\n");
+		return -ENOENT;
+		goto out;
+	}
+	/*
+	 * Check if it is really our interposer.
+	 */
+	if (disk->interposer->ip_submit_bio != interposer->ip_submit_bio) {
+		pr_info("The interposer found is not ours.\n");
+		return -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Detach interposer.
+	 */
+	disk->interposer = NULL;
+	/*
+	 * And while the queue is stopped, we can do something specific for our module.
+	 */
+	pr_info("Block device interposer detached successfully.\n");
+
+out:
+	/*
+	 * Resume disks queue processing.
+	 */
+	blk_mq_unquiesce_queue(disk->queue);
+	blk_mq_unfreeze_queue(disk->queue);
+
+	return ret;
+}
+
+/**
+ * blk_interposer_submit_bio - Interpose bio
+ * @interposer: block device interposer
+ * @bio: interposed bio
+ */
+static void blk_interposer_submit_bio(struct blk_interposer *interposer, struct bio *bio)
+{
+	struct my_interposer *ip = container_of(interposer, struct my_interposer, interposer);
+
+	atomic_inc(&ip->counter);
+	if (atomic_read(&ip->counter) < 10)
+		pr_info("%s - %d", __func__, atomic_read(&ip->counter));
+	else if (atomic_read(&ip->counter) == 10)
+		pr_info("%s the flooding of log has stopped", __func__);
+
+	/*
+	 * Here we can submit a new child bio requests before the original.
+	 * If the new bio should not be interposed, set BIO_INTERPOSED flag.
+	 */
+
+	/*
+	 * We can resubmit the original bio or just add it to the current->bio_list.
+	 * In the second case, we do not call submit_bio_checks() twice.
+	 */
+	bio_list_add(&current->bio_list[0], bio);
+
+	/*
+	 * Here we can submit a new bio requests after the original,
+	 * although I don't know how it might be useful.
+	 */
+
+	/*
+	 * All submitted bio will be just placed in the current->bio_list.
+	 * We can't wait for the bio request to complete.
+	 */
+
+	/*
+	 * The function doesn't return anything, because it can only return BLK_QC_T_NONE.
+	 */
+}
+
+static int __init blk_interposer_init(void)
+{
+	int ret = 0;
+	dev_t dev_id;
+	struct block_device *bdev;
+
+	pr_info("Loading module\n");
+
+	pr_info("Tracking device: %d:%d\n", device_major, device_minor);
+	dev_id = MKDEV(device_major, device_minor);
+
+	/*
+	 * Open block device
+	 */
+	bdev = blkdev_get_by_dev(dev_id, fmode, &my_ip);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
+		pr_err("Unable to open device [%d:%d]: blkdev_get_by_dev return %d\n",
+		       MAJOR(dev_id), MINOR(dev_id), 0-ret);
+		return ret;
+	}
+
+	/*
+	 * Initialize block device interposer fields.
+	 */
+	my_ip.interposer.ip_submit_bio = blk_interposer_submit_bio;
+
+	/*
+	 * Initialize our interposer specific fields
+	 */
+	atomic_set(&my_ip.counter, 0);
+
+	/*
+	 * Attach interposer to disk
+	 */
+	ret = blk_interposer_attach(bdev->bd_disk, &my_ip.interposer);
+	if (ret)
+		pr_info("Failed to attach the block device interposer.\n");
+	/*
+	 * Close device
+	 */
+	blkdev_put(bdev, fmode);
+
+	return ret;
+}
+
+static void __exit blk_interposer_exit(void)
+{
+	int ret;
+	dev_t dev_id;
+	struct block_device *bdev;
+
+	pr_info("Unloading module\n");
+
+	dev_id = MKDEV(device_major, device_minor);
+
+	/*
+	 * Open block device
+	 */
+	bdev = blkdev_get_by_dev(dev_id, fmode, &my_ip);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
+		pr_err("Unable to open device [%d:%d]: blkdev_get_by_dev return %d\n",
+		       MAJOR(dev_id), MINOR(dev_id), 0-ret);
+		return;
+	}
+
+	/*
+	 * Detach interposer from disk
+	 */
+	ret = blk_interposer_detach(bdev->bd_disk, &my_ip.interposer);
+	if (ret)
+		pr_info("Failed to detach the block device interposer.\n");
+	/*
+	 * Close device
+	 */
+	blkdev_put(bdev, fmode);
+
+	/*
+	 * The counter shows how much bio was interposed.
+	 */
+	pr_info("%d bio was interposed.\n", atomic_read(&my_ip.counter));
+}
+
+module_init(blk_interposer_init);
+module_exit(blk_interposer_exit);
+
+MODULE_DESCRIPTION("Block Layer Interposer Sample kernel module");
+MODULE_AUTHOR("Veeam Software Group GmbH");
+MODULE_LICENSE("GPL");
+
+module_param_named(device_major, device_major, int, 0644);
+MODULE_PARM_DESC(device_major, "Tracking device major number");
+module_param_named(device_minor, device_minor, int, 0644);
+MODULE_PARM_DESC(device_minor, "Tracking device minor number");
-- 
2.20.1

