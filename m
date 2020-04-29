Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525CC83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49DC20787
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146536;
	bh=ElR77TAXo14L0C3VCh2U+U3sGaRrgQaKmPeQIKZJqsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwH1m4olR5Y0z3tTQ+znZF/m84HPrFc8zNnDyDGjmrTZwsmEGpDD0CZzUlXJ4pkGW
	 KMM3aPzpw7OZPs2Ti14xfsBCnQSEsgrbHpJZ+OQgov/aDAuiG5z3HKOeVWUAEc0BI7
	 BjsexOOSTYdCSBN8LcF56U8XodSHd4ARgIbm9hWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2Hsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:48:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38606 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgD2Hsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id p8so647003pgi.5;
        Wed, 29 Apr 2020 00:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8lMFynCntNB+AXqc1BOY20X/G4JO2Pdee6+p/874hE=;
        b=qDygY9aIs0W3EGRe3H+YeweqlGVK7tZDp/JjspOa6vSi2CGYNhis/vvKIcb3sHgnN4
         jNfpj3cAQ0cGD3zGcNczd92C+xFNxKgYLvBd3FzymyoOsN9ga3qD4ACzUaL34fLVUoM5
         910TJZLC5iot86BQ3q2cFp3BDRpdHbJ5a6oqQFwfQZ1loFmKITX6tgmkeljKVxqTdoBW
         UuPzCwc+5ZYP7V9p0dICqU4DypqxmM1ha7lGrR3myhZa69n1W+Jrfq5wfCF6LfNHbi6w
         J54OERHsL5nH0Fwyflh/GaA+t564VsXUG3CUFsJT7K17C4qW+Y2eDaT8NwZmZ0DsjtdM
         f0xg==
X-Gm-Message-State: AGi0Pubcpm0L+cxMUposOQ869UU27Vl7RqyGW28ISMsd3CzjugO9GgdF
        Cep9Ex2PP50/kGb9Z+b7148=
X-Google-Smtp-Source: APiQypJ0UnWlj/c1L6MIIGrLyDNrdlN4qptK9iAFpHAul7z1ReJB/qOgqylzl9DioyCYviPKmXlbrg==
X-Received: by 2002:aa7:9e07:: with SMTP id y7mr34541053pfq.257.1588146533428;
        Wed, 29 Apr 2020 00:48:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s199sm430982pfs.124.2020.04.29.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D78BC41DCA; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 5/6] block: add initial error handling for *add_disk()* and friends
Date:   Wed, 29 Apr 2020 07:48:43 +0000
Message-Id: <20200429074844.6241-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds error handling to the *add_disk*() callers and the functions
it depends on. This is initial work as drivers are not converted. That
is separate work.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-integrity.c |  13 ++-
 block/blk-sysfs.c     |   7 +-
 block/blk.h           |   5 +-
 block/genhd.c         | 210 +++++++++++++++++++++++++++++-------------
 include/linux/genhd.h |  16 ++--
 5 files changed, 171 insertions(+), 80 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index ff1070edbb40..c6ceb2a1bc66 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -426,13 +426,18 @@ void blk_integrity_unregister(struct gendisk *disk)
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
 
-void blk_integrity_add(struct gendisk *disk)
+int blk_integrity_add(struct gendisk *disk)
 {
-	if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				 &disk_to_dev(disk)->kobj, "%s", "integrity"))
-		return;
+	int ret;
+
+	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
+				   &disk_to_dev(disk)->kobj, "%s", "integrity");
+	if (ret)
+		return ret;
 
 	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+
+	return 0;
 }
 
 void blk_integrity_del(struct gendisk *disk)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f758a7e06671..aee2503ec120 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -939,9 +939,10 @@ int blk_register_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return -ENXIO;
 
-	WARN_ONCE(blk_queue_registered(q),
-		  "%s is registering an already registered queue\n",
-		  kobject_name(&dev->kobj));
+	if (WARN_ONCE(blk_queue_registered(q),
+		      "%s is registering an already registered queue\n",
+		      kobject_name(&dev->kobj)))
+		return -ENXIO;
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
diff --git a/block/blk.h b/block/blk.h
index 46d867a7f5bc..7c239ce14e79 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -151,7 +151,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
-void blk_integrity_add(struct gendisk *);
+int blk_integrity_add(struct gendisk *);
 void blk_integrity_del(struct gendisk *);
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool integrity_req_gap_back_merge(struct request *req,
@@ -175,8 +175,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
 static inline void bio_integrity_free(struct bio *bio)
 {
 }
-static inline void blk_integrity_add(struct gendisk *disk)
+static inline int blk_integrity_add(struct gendisk *disk)
 {
+	return 0;
 }
 static inline void blk_integrity_del(struct gendisk *disk)
 {
diff --git a/block/genhd.c b/block/genhd.c
index ed2a0eaa4e7b..f3b6ed2dd4d8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -42,8 +42,8 @@ static const struct device_type disk_type;
 
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
-static void disk_alloc_events(struct gendisk *disk);
-static void disk_add_events(struct gendisk *disk);
+static int disk_alloc_events(struct gendisk *disk);
+static int disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
@@ -669,11 +669,11 @@ static char *bdevt_str(dev_t devt, char *buf)
  * range must be nonzero
  * The hash chain is sorted on range, so that subranges can override.
  */
-void blk_register_region(dev_t devt, unsigned long range, struct module *module,
-			 struct kobject *(*probe)(dev_t, int *, void *),
-			 int (*lock)(dev_t, void *), void *data)
+int blk_register_region(dev_t devt, unsigned long range, struct module *module,
+			struct kobject *(*probe)(dev_t, int *, void *),
+			int (*lock)(dev_t, void *), void *data)
 {
-	kobj_map(bdev_map, devt, range, module, probe, lock, data);
+	return kobj_map(bdev_map, devt, range, module, probe, lock, data);
 }
 
 EXPORT_SYMBOL(blk_register_region);
@@ -784,12 +784,12 @@ static void unregister_disk(struct gendisk *disk)
 	device_del(disk_to_dev(disk));
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk,
-			  const struct attribute_group **groups)
+static int __must_check register_disk(struct device *parent,
+				      struct gendisk *disk,
+				      const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
-	struct block_device *bdev;
-
+	struct block_device *bdev = NULL;
 	int err;
 
 	ddev->parent = parent;
@@ -803,15 +803,26 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		WARN_ON(ddev->groups);
 		ddev->groups = groups;
 	}
-	if (device_add(ddev))
-		return;
+
+	err = device_add(ddev);
+	if (err) {
+		/*
+		 * We don't put_device(ddev) until later as we need to wait
+		 * until all the device users are unregistered as well. An
+		 * example is that we still have the device associated with a
+		 * bdi with bdi_register_owner().
+		 *
+		 * The driver issues the last put_device(ddev), however it uses
+		 * put_disk() instead.
+		 */
+		return err;
+	}
+
 	if (!sysfs_deprecated) {
 		err = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
-		if (err) {
-			device_del(ddev);
-			return;
-		}
+		if (err)
+			goto exit_del_device;
 	}
 
 	/*
@@ -826,36 +837,54 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		dev_set_uevent_suppress(ddev, 0);
-		return;
+		return 0;
 	}
 
 	/* No minors to use for partitions */
 	if (!disk_part_scan_enabled(disk))
-		goto exit;
+		goto exit_success;
 
 	/* No such device (e.g., media were just removed) */
-	if (!get_capacity(disk))
-		goto exit;
+	if (!get_capacity(disk)) {
+		err = -ENODEV;
+		goto exit_sysfs_deprecated;
+	}
 
 	bdev = bdget_disk(disk, 0);
-	if (!bdev)
-		goto exit;
+	if (!bdev) {
+		err = -ENODEV;
+		goto exit_sysfs_deprecated;
+	}
 
 	bdev->bd_invalidated = 1;
 	err = blkdev_get(bdev, FMODE_READ, NULL);
 	if (err < 0)
-		goto exit;
+		goto exit_bdput;
 	blkdev_put(bdev, FMODE_READ);
 
-exit:
+exit_success:
 	disk_announce(disk);
 
 	if (disk->queue->backing_dev_info->dev) {
 		err = sysfs_create_link(&ddev->kobj,
 			  &disk->queue->backing_dev_info->dev->kobj,
 			  "bdi");
-		WARN_ON(err);
+		if (WARN_ON(err))
+			goto exit_bdput;
 	}
+
+	return 0;
+
+exit_bdput:
+	if (bdev)
+		bdput(bdev);
+exit_sysfs_deprecated:
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+exit_del_device:
+	device_del(ddev);
+
+	return err;
 }
 
 /**
@@ -867,21 +896,25 @@ static void register_disk(struct device *parent, struct gendisk *disk,
  *
  * This function registers the partitioning information in @disk
  * with the kernel.
- *
- * FIXME: error handling
  */
-static void __device_add_disk(struct device *parent, struct gendisk *disk,
-			      const struct attribute_group **groups,
-			      bool register_queue)
+
+static int __device_add_disk(struct device *parent, struct gendisk *disk,
+			     const struct attribute_group **groups,
+			     bool register_queue)
 {
 	dev_t devt;
 	int retval;
 
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
-	 * so that it sticks around as long as @disk is there.
+	 * so that it sticks around as long as @disk is there. The driver
+	 * must call blk_cleanup_queue() and then put_disk() on error from
+	 * this function.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	if (WARN_ON_ONCE(!blk_get_queue(disk->queue))) {
+		disk->queue = NULL;
+		return -ESHUTDOWN;
+	}
 
 	/*
 	 * The disk queue should now be all set with enough information about
@@ -896,21 +929,24 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * be accompanied with EXT_DEVT flag.  Make sure all
 	 * parameters make sense.
 	 */
-	WARN_ON(disk->minors && !(disk->major || disk->first_minor));
-	WARN_ON(!disk->minors &&
-		!(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN)));
+	if (WARN_ON(disk->minors && !(disk->major || disk->first_minor)))
+		return -EINVAL;
+	if (WARN_ON(!disk->minors &&
+		    !(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN))))
+		return -EINVAL;
 
 	disk->flags |= GENHD_FL_UP;
 
 	retval = blk_alloc_devt(&disk->part0, &devt);
-	if (retval) {
-		WARN_ON(1);
-		return;
-	}
+	if (WARN_ON(retval))
+		return retval;
+
 	disk->major = MAJOR(devt);
 	disk->first_minor = MINOR(devt);
 
-	disk_alloc_events(disk);
+	retval = disk_alloc_events(disk);
+	if (retval)
+		goto exit_blk_free_devt;
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
@@ -920,35 +956,75 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
-		int ret;
-
 		/* Register BDI before referencing it from bdev */
 		disk_to_dev(disk)->devt = devt;
-		ret = bdi_register_owner(disk->queue->backing_dev_info,
-						disk_to_dev(disk));
-		WARN_ON(ret);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
+
+		retval = bdi_register_owner(disk->queue->backing_dev_info,
+					    disk_to_dev(disk));
+		if (WARN_ON(retval))
+			goto exit_disk_release_events;
+		retval = blk_register_region(disk_devt(disk), disk->minors,
+					     NULL,
+					     exact_match, exact_lock, disk);
+		if (retval)
+			goto exit_unregister_bdi;
 	}
-	register_disk(parent, disk, groups);
+
+	retval = register_disk(parent, disk, groups);
+	if (retval)
+		goto exit_unregister_regions;
+
+	if (register_queue) {
+		retval = blk_register_queue(disk);
+		if (retval)
+			goto exit_unregister_disk;
+	}
+
+	retval = disk_add_events(disk);
+	if (retval)
+		goto exit_unregister_queue;
+
+	retval = blk_integrity_add(disk);
+	if (retval)
+		goto exit_del_events;
+
+	return 0;
+
+exit_del_events:
+	disk_del_events(disk);
+exit_unregister_queue:
 	if (register_queue)
-		blk_register_queue(disk);
+		blk_unregister_queue(disk);
+exit_unregister_disk:
+	disk_invalidate(disk);
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+	unregister_disk(disk);
+exit_unregister_regions:
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		blk_unregister_region(disk_devt(disk), disk->minors);
+exit_unregister_bdi:
+	if (disk->queue && !(disk->flags & GENHD_FL_HIDDEN))
+		bdi_unregister(disk->queue->backing_dev_info);
+exit_disk_release_events:
+	disk_release_events(disk);
+exit_blk_free_devt:
+	blk_free_devt(disk_devt(disk));
 
-	disk_add_events(disk);
-	blk_integrity_add(disk);
+	return retval;
 }
 
-void device_add_disk(struct device *parent, struct gendisk *disk,
-		     const struct attribute_group **groups)
+int device_add_disk(struct device *parent, struct gendisk *disk,
+		    const struct attribute_group **groups)
 
 {
-	__device_add_disk(parent, disk, groups, true);
+	return __device_add_disk(parent, disk, groups, true);
 }
 EXPORT_SYMBOL(device_add_disk);
 
-void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
+int device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 {
-	__device_add_disk(parent, disk, NULL, false);
+	return __device_add_disk(parent, disk, NULL, false);
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
@@ -2313,17 +2389,17 @@ module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
 /*
  * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
  */
-static void disk_alloc_events(struct gendisk *disk)
+static int disk_alloc_events(struct gendisk *disk)
 {
 	struct disk_events *ev;
 
 	if (!disk->fops->check_events || !disk->events)
-		return;
+		return 0;
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
 	if (!ev) {
 		pr_warn("%s: failed to initialize events\n", disk->disk_name);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&ev->node);
@@ -2335,17 +2411,23 @@ static void disk_alloc_events(struct gendisk *disk)
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
 	disk->ev = ev;
+
+	return 0;
 }
 
-static void disk_add_events(struct gendisk *disk)
+static int disk_add_events(struct gendisk *disk)
 {
-	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
+	int ret;
+
+	ret = sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	if (ret < 0) {
 		pr_warn("%s: failed to create sysfs files for events\n",
 			disk->disk_name);
+		return ret;
+	}
 
 	if (!disk->ev)
-		return;
+		return 0;
 
 	mutex_lock(&disk_events_mutex);
 	list_add_tail(&disk->ev->node, &disk_events);
@@ -2356,6 +2438,8 @@ static void disk_add_events(struct gendisk *disk)
 	 * unblock kicks it into action.
 	 */
 	__disk_unblock_events(disk, true);
+
+	return 0;
 }
 
 static void disk_del_events(struct gendisk *disk)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 899760cf8c37..76fc8abd5899 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -291,16 +291,16 @@ extern void disk_part_iter_exit(struct disk_part_iter *piter);
 extern bool disk_has_partitions(struct gendisk *disk);
 
 /* block/genhd.c */
-extern void device_add_disk(struct device *parent, struct gendisk *disk,
-			    const struct attribute_group **groups);
-static inline void add_disk(struct gendisk *disk)
+extern int device_add_disk(struct device *parent, struct gendisk *disk,
+			   const struct attribute_group **groups);
+static inline int add_disk(struct gendisk *disk)
 {
-	device_add_disk(NULL, disk, NULL);
+	return device_add_disk(NULL, disk, NULL);
 }
-extern void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
-static inline void add_disk_no_queue_reg(struct gendisk *disk)
+extern int device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
+static inline int add_disk_no_queue_reg(struct gendisk *disk)
 {
-	device_add_disk_no_queue_reg(NULL, disk);
+	return device_add_disk_no_queue_reg(NULL, disk);
 }
 
 extern void del_gendisk(struct gendisk *gp);
@@ -350,7 +350,7 @@ extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern struct kobject *get_disk_and_module(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
 extern void put_disk_and_module(struct gendisk *disk);
-extern void blk_register_region(dev_t devt, unsigned long range,
+extern int blk_register_region(dev_t devt, unsigned long range,
 			struct module *module,
 			struct kobject *(*probe)(dev_t, int *, void *),
 			int (*lock)(dev_t, void *),
-- 
2.25.1

