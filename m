Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A13C433E6
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F0B64F65
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhBCP47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:56:59 -0500
Received: from mx2.veeam.com ([64.129.123.6]:56872 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234691AbhBCP4v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 10:56:51 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id ACD584159C;
        Wed,  3 Feb 2021 10:54:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1612367689; bh=fypuNIL3IiNG+w81W5Dyl+Eq2Mzu4AwDcNRA7TfznU8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=cxI7i634PPasqV6DLURmXOJJqhrXuLeysJ9B3gPfpxaXTQkM/YBbVlzFMIl4Hpbyo
         z4eWQFWAdBYGTUanojepPUm7BUg91SdQtZe0w9G/X7VQeRgVfLPQvsl7Wsy/xkHZBQ
         nU1XJ+bWo0no6GrucgLcEKKWNEs6FzNWLBq93l8k=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Feb 2021 16:54:26 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <Damien.LeMoal@wdc.com>, <snitzer@redhat.com>, <hare@suse.de>,
        <ming.lei@redhat.com>, <agk@redhat.com>, <corbet@lwn.net>,
        <axboe@kernel.dk>, <jack@suse.cz>, <johannes.thumshirn@wdc.com>,
        <gregkh@linuxfoundation.org>, <koct9i@gmail.com>, <steve@sk2.org>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavgel.tide@veeam.com>
Subject: [PATCH v4 5/6] dm: add 'noexcl' option for dm-linear
Date:   Wed, 3 Feb 2021 18:53:57 +0300
Message-ID: <1612367638-3794-6-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
References: <1612367638-3794-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265667062
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'noexcl' option allow to open underlying block-device
without FMODE_EXCL.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-linear.c        | 14 +++++++++++++-
 drivers/md/dm-table.c         | 12 +++++++-----
 drivers/md/dm.c               | 24 +++++++++++++++++-------
 drivers/md/dm.h               |  2 +-
 include/linux/device-mapper.h |  7 +++++++
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..b16d89802b9d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -33,7 +33,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	char dummy;
 	int ret;
 
-	if (argc != 2) {
+	if ((argc < 2) || (argc > 3)) {
 		ti->error = "Invalid argument count";
 		return -EINVAL;
 	}
@@ -51,6 +51,18 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	lc->start = tmp;
 
+	ti->non_exclusive = false;
+	if (argc > 2) {
+		if (strcmp("noexcl", argv[2]) == 0)
+			ti->non_exclusive = true;
+		else if (strcmp("excl", argv[2]) == 0)
+			ti->non_exclusive = false;
+		else {
+			ti->error = "Invalid exclusive option";
+			return -EINVAL;
+		}
+	}
+
 	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &lc->dev);
 	if (ret) {
 		ti->error = "Device lookup failed";
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 4acf2342f7ad..f15bc2171f25 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -322,7 +322,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
  * device and not to touch the existing bdev field in case
  * it is accessed concurrently.
  */
-static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
+static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode, bool non_exclusive,
 			struct mapped_device *md)
 {
 	int r;
@@ -330,7 +330,7 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
 
 	old_dev = dd->dm_dev;
 
-	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,
+	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev, non_exclusive,
 				dd->dm_dev->mode | new_mode, &new_dev);
 	if (r)
 		return r;
@@ -387,7 +387,8 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (!dd)
 			return -ENOMEM;
 
-		if ((r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {
+		r = dm_get_table_device(t->md, dev, mode, ti->non_exclusive, &dd->dm_dev);
+		if (r) {
 			kfree(dd);
 			return r;
 		}
@@ -396,8 +397,9 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		list_add(&dd->list, &t->devices);
 		goto out;
 
-	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
+	} else if ((dd->dm_dev->mode != (mode | dd->dm_dev->mode)) &&
+		   (dd->dm_dev->non_exclusive != ti->non_exclusive)) {
+		r = upgrade_mode(dd, mode, ti->non_exclusive, t->md);
 		if (r)
 			return r;
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0b184dfec233..c34c75467399 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1107,6 +1107,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 
 	td->dm_dev.bdev = bdev;
 	td->dm_dev.dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+	td->dm_dev.non_exclusive = non_exclusive;
 	return 0;
 }
 
@@ -1118,33 +1119,41 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 	if (!td->dm_dev.bdev)
 		return;
 
-	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
-	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	if (td->dm_dev.non_exclusive)
+		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
+	else {
+		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
+		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	}
+
 	put_dax(td->dm_dev.dax_dev);
 	td->dm_dev.bdev = NULL;
 	td->dm_dev.dax_dev = NULL;
+	td->dm_dev.non_exclusive = false;
 }
 
 static struct table_device *find_table_device(struct list_head *l, dev_t dev,
-					      fmode_t mode)
+					      fmode_t mode, bool non_exclusive)
 {
 	struct table_device *td;
 
 	list_for_each_entry(td, l, list)
-		if (td->dm_dev.bdev->bd_dev == dev && td->dm_dev.mode == mode)
+		if (td->dm_dev.bdev->bd_dev == dev &&
+		    td->dm_dev.mode == mode &&
+		    td->dm_dev.non_exclusive == non_exclusive)
 			return td;
 
 	return NULL;
 }
 
-int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
+int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode, bool non_exclusive,
 			struct dm_dev **result)
 {
 	int r;
 	struct table_device *td;
 
 	mutex_lock(&md->table_devices_lock);
-	td = find_table_device(&md->table_devices, dev, mode);
+	td = find_table_device(&md->table_devices, dev, mode, non_exclusive);
 	if (!td) {
 		td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
 		if (!td) {
@@ -1155,7 +1164,8 @@ int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
 		td->dm_dev.mode = mode;
 		td->dm_dev.bdev = NULL;
 
-		if ((r = open_table_device(td, dev, md))) {
+		r = open_table_device(td, dev, md, non_exclusive);
+		if (r) {
 			mutex_unlock(&md->table_devices_lock);
 			kfree(td);
 			return r;
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index fffe1e289c53..7bf20fb2de74 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -179,7 +179,7 @@ int dm_open_count(struct mapped_device *md);
 int dm_lock_for_deletion(struct mapped_device *md, bool mark_deferred, bool only_deferred);
 int dm_cancel_deferred_remove(struct mapped_device *md);
 int dm_request_based(struct mapped_device *md);
-int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
+int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode, bool non_exclusive,
 			struct dm_dev **result);
 void dm_put_table_device(struct mapped_device *md, struct dm_dev *d);
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 61a66fb8ebb3..70002363bfc0 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -150,6 +150,7 @@ struct dm_dev {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	fmode_t mode;
+	bool non_exclusive;
 	char name[16];
 };
 
@@ -325,6 +326,12 @@ struct dm_target {
 	 * whether or not its underlying devices have support.
 	 */
 	bool discards_supported:1;
+
+	/*
+	 * Set if this target needs to open device without FMODE_EXCL
+	 * mode.
+	 */
+	bool non_exclusive:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.20.1

