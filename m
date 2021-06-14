Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B4BC48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB956128B
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhFNGF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNGFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 02:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854DCC061574
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 23:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wuRym5G/sRElJDfqpK6/ZFHH5W5DmJ1OYP8YAeStdBc=; b=Bpfs3YxPD+Yg9n/kk2oBB7FjnC
        z6PMQ9v6ROWmdCH87tFMUGFBGCJPZPUu4/SMVMznkQULLfMOwAujTa8JV6mv2EAjlfID+bsJiuXWb
        +AmBnGeI5ioSMuhOLJdY1cz7E9V0yjvvVy2yIyFpzQrwsyVa6mvQk+IiNZtbpVke95L7J2mUgrVK4
        jY7AfiBHuDkLGHR3AtmkM2Bx4b6zhU8ievISJazAosrlwKryUHhflzuHoAGLFNqamzFnfp+RKE0Z9
        PrjwL1l5Zwf/e+aJhK3tX/3LiX8OJ0Hxewo0hgJ5a17/sK3GrRAZS6U08DlPOsQnNyc6NXL4GeDma
        RvN6VS7w==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfhQ-00CfsA-Q7; Mon, 14 Jun 2021 06:03:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] mtip32xx: simplify sysfs setup
Date:   Mon, 14 Jun 2021 08:03:42 +0200
Message-Id: <20210614060343.3965416-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614060343.3965416-1-hch@lst.de>
References: <20210614060343.3965416-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the driver specific attributes directly to device_add_disk instead
of manually creating them after the disk registration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 79 ++++++-------------------------
 1 file changed, 15 insertions(+), 64 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 589cb0f1e030..e2749698fb81 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2160,6 +2160,20 @@ static ssize_t mtip_hw_show_status(struct device *dev,
 
 static DEVICE_ATTR(status, 0444, mtip_hw_show_status, NULL);
 
+static struct attribute *mtip_disk_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static const struct attribute_group mtip_disk_attr_group = {
+	.attrs = mtip_disk_attrs,
+};
+
+static const struct attribute_group *mtip_disk_attr_groups[] = {
+	&mtip_disk_attr_group,
+	NULL,
+};
+
 /* debugsfs entries */
 
 static ssize_t show_device_status(struct device_driver *drv, char *buf)
@@ -2384,47 +2398,6 @@ static const struct file_operations mtip_flags_fops = {
 	.llseek = no_llseek,
 };
 
-/*
- * Create the sysfs related attributes.
- *
- * @dd   Pointer to the driver data structure.
- * @kobj Pointer to the kobj for the block device.
- *
- * return value
- *	0	Operation completed successfully.
- *	-EINVAL Invalid parameter.
- */
-static int mtip_hw_sysfs_init(struct driver_data *dd, struct kobject *kobj)
-{
-	if (!kobj || !dd)
-		return -EINVAL;
-
-	if (sysfs_create_file(kobj, &dev_attr_status.attr))
-		dev_warn(&dd->pdev->dev,
-			"Error creating 'status' sysfs entry\n");
-	return 0;
-}
-
-/*
- * Remove the sysfs related attributes.
- *
- * @dd   Pointer to the driver data structure.
- * @kobj Pointer to the kobj for the block device.
- *
- * return value
- *	0	Operation completed successfully.
- *	-EINVAL Invalid parameter.
- */
-static int mtip_hw_sysfs_exit(struct driver_data *dd, struct kobject *kobj)
-{
-	if (!kobj || !dd)
-		return -EINVAL;
-
-	sysfs_remove_file(kobj, &dev_attr_status.attr);
-
-	return 0;
-}
-
 static int mtip_hw_debugfs_init(struct driver_data *dd)
 {
 	if (!dfs_parent)
@@ -3579,7 +3552,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	int rv = 0, wait_for_rebuild = 0;
 	sector_t capacity;
 	unsigned int index = 0;
-	struct kobject *kobj;
 
 	if (dd->disk)
 		goto skip_create_disk; /* hw init done, before rebuild */
@@ -3685,17 +3657,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
-	device_add_disk(&dd->pdev->dev, dd->disk, NULL);
-
-	/*
-	 * Now that the disk is active, initialize any sysfs attributes
-	 * managed by the protocol layer.
-	 */
-	kobj = kobject_get(&disk_to_dev(dd->disk)->kobj);
-	if (kobj) {
-		mtip_hw_sysfs_init(dd, kobj);
-		kobject_put(kobj);
-	}
+	device_add_disk(&dd->pdev->dev, dd->disk, mtip_disk_attr_groups);
 
 	if (dd->mtip_svc_handler) {
 		set_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag);
@@ -3764,8 +3726,6 @@ static bool mtip_no_dev_cleanup(struct request *rq, void *data, bool reserv)
  */
 static int mtip_block_remove(struct driver_data *dd)
 {
-	struct kobject *kobj;
-
 	mtip_hw_debugfs_exit(dd);
 
 	if (dd->mtip_svc_handler) {
@@ -3774,15 +3734,6 @@ static int mtip_block_remove(struct driver_data *dd)
 		kthread_stop(dd->mtip_svc_handler);
 	}
 
-	/* Clean up the sysfs attributes, if created */
-	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag)) {
-		kobj = kobject_get(&disk_to_dev(dd->disk)->kobj);
-		if (kobj) {
-			mtip_hw_sysfs_exit(dd, kobj);
-			kobject_put(kobj);
-		}
-	}
-
 	if (!dd->sr) {
 		/*
 		 * Explicitly wait here for IOs to quiesce,
-- 
2.30.2

