Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C2FC6FA99
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 22:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCJWkh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjCJWkb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:31 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0712CBC2;
        Fri, 10 Mar 2023 14:40:25 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678488023;
        bh=+UTAaXGkgmAmWSjDuYQAkSUNuPdrcalL9bcOhrDdMuQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OQ8tyTwN5R40txrQUsBdTu+rcZWbmZoMOeUNXbMCOjhN1/Sg2FGZjL0FyEoNZorJ/
         Ycuu5chL06HeN493xHqo2z04KS6fGv0omZs//xzjERvkfVZh/DBMIUUqxVrqxo2nII
         Tqupoqaog3m/qGvvdxjSvEv45axu/YoAhEJyfpEs=
Date:   Fri, 10 Mar 2023 22:40:04 +0000
Subject: [PATCH v2 3/4] blk-integrity: register sysfs attributes on struct
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v2-3-761a50d71900@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678488015; l=3028;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+UTAaXGkgmAmWSjDuYQAkSUNuPdrcalL9bcOhrDdMuQ=;
 b=hIgrVmHSDQ+sqtFKQql3Y2uN1i1jm49G9gDuB+fGgjgl9Jsi8TneswZKYnJ8fb+C5fSEfSL6B
 VgguqewROs8ALZ/5NzMxCF4hJahwRwF0Jn09Ryc70BtzlxVjdWvuf/S
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "integrity" kobject only acted as a holder for static sysfs entries.
It also was embedded into struct gendisk without managing it, violating
assumptions of the driver core.

Instead register the sysfs entries directly onto the struct device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c | 50 +++++---------------------------------------------
 1 file changed, 5 insertions(+), 45 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index e1c3e3591c82..79eb21482036 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -212,33 +212,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	return true;
 }
 
-static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
-				   char *page)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-
-	return dev_attr->show(dev, dev_attr, page);
-}
-
-static ssize_t integrity_attr_store(struct kobject *kobj,
-				    struct attribute *attr, const char *page,
-				    size_t count)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-	ssize_t ret = 0;
-
-	if (dev_attr->store)
-		ret = dev_attr->store(dev, dev_attr, page, count);
-
-	return ret;
-}
-
 static inline struct blk_integrity *dev_to_bi(struct device *dev)
 {
 	return &dev_to_disk(dev)->queue->integrity;
@@ -340,17 +313,12 @@ static struct attribute *integrity_attrs[] = {
 	&dev_attr_device_is_integrity_capable.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(integrity);
 
-static const struct sysfs_ops integrity_ops = {
-	.show	= &integrity_attr_show,
-	.store	= &integrity_attr_store,
+static const struct attribute_group integrity_group  = {
+	.name = "integrity", .attrs = integrity_attrs,
 };
 
-static const struct kobj_type integrity_ktype = {
-	.default_groups = integrity_groups,
-	.sysfs_ops	= &integrity_ops,
-};
+__ATTRIBUTE_GROUPS(integrity);
 
 static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
 {
@@ -431,18 +399,10 @@ EXPORT_SYMBOL(blk_integrity_unregister);
 
 int blk_integrity_add(struct gendisk *disk)
 {
-	int ret;
-
-	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				   &disk_to_dev(disk)->kobj, "%s", "integrity");
-	if (!ret)
-		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
-	return ret;
+	return device_add_groups(disk_to_dev(disk), integrity_groups);
 }
 
 void blk_integrity_del(struct gendisk *disk)
 {
-	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
-	kobject_del(&disk->integrity_kobj);
-	kobject_put(&disk->integrity_kobj);
+	device_remove_groups(disk_to_dev(disk), integrity_groups);
 }

-- 
2.39.2

