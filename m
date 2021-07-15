Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85200C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722EB61370
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhGOE6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:41 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:43991 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbhGOE6k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:40 -0400
Received: by mail-pj1-f44.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso3185656pjp.2;
        Wed, 14 Jul 2021 21:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIY5YsFS9a/gTtxa0zx/TpcbACx+0EdBSHCqP5kfZEw=;
        b=qWUxq/ddA6BWp/GRFF4WHkXgQknAS6X+XPJrLhu3nEfbvrqWlEa1aRR3Q4iOTL+khb
         E2Xp/uFJ4befbTCkRmPKDMw4XHdi/o65xXkb5qz9O9PVkAxePeZN/FHx/zxwhU9mfS1w
         fOXxBvUQsPLVINDCx94ZqqRtuuqjhUmvut/8uCqLpFknSuLGJepo8CG8GYdHWnGYLsxn
         JNEaY2XjwKSq/qvcV9U/ljaiTGLtTajzOrWx0NHwK0AI8oFxL5CARzadacPwC0ip3a8l
         ywBaj2VcpNjhETGh3udXm8rPSa/uUQeg39WTskGyU1vGDekX05uDfHRjGHNb52oAwIs3
         1gjg==
X-Gm-Message-State: AOAM531lJPZk84UvDWZNJ6nE6VxDTTRTVbFRnB5Ocapo8f7ijen+LvXE
        WlhKeg/ic/KhycbZYA1fY5Q=
X-Google-Smtp-Source: ABdhPJwiTp2QLY3F1oVtCotj3f0Q8MEaNTAyl0bVVI9ah/j6Eq6KnkOvyDFlcjTkCYBZivAM2tkf/A==
X-Received: by 2002:a17:90a:b398:: with SMTP id e24mr2017658pjr.151.1626324947276;
        Wed, 14 Jul 2021 21:55:47 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id a15sm4539321pff.128.2021.07.14.21.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:46 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 5/6] block: add initial error handling for *add_disk()* and friends
Date:   Wed, 14 Jul 2021 21:55:30 -0700
Message-Id: <20210715045531.420201-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds error handling to the *add_disk*() callers and the functions
it depends on. This is initial work as drivers are not converted. That
is separate work.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-integrity.c |  12 +++--
 block/blk-sysfs.c     |   5 +-
 block/blk.h           |   7 +--
 block/disk-events.c   |   8 +--
 block/genhd.c         | 118 ++++++++++++++++++++++++++++++------------
 include/linux/genhd.h |  14 ++---
 6 files changed, 112 insertions(+), 52 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 410da060d1f5..e46f47f2dec9 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -431,13 +431,17 @@ void blk_integrity_unregister(struct gendisk *disk)
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
+				 &disk_to_dev(disk)->kobj, "%s", "integrity");
+	if (ret)
+		return ret;
 
 	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+	return 0;
 }
 
 void blk_integrity_del(struct gendisk *disk)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 370d83c18057..7fd53bf3f8ad 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -862,9 +862,10 @@ int blk_register_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return -ENXIO;
 
-	WARN_ONCE(blk_queue_registered(q),
+	if (WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
-		  kobject_name(&dev->kobj));
+		  kobject_name(&dev->kobj)))
+		return -ENXIO;
 
 	blk_queue_update_readahead(q);
 
diff --git a/block/blk.h b/block/blk.h
index 4b885c0f6708..e24273ebc4bd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -132,7 +132,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
-void blk_integrity_add(struct gendisk *);
+int blk_integrity_add(struct gendisk *);
 void blk_integrity_del(struct gendisk *);
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool blk_integrity_merge_rq(struct request_queue *rq,
@@ -166,8 +166,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
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
@@ -360,7 +361,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 
 struct request_queue *blk_alloc_queue(int node_id);
 
-void disk_alloc_events(struct gendisk *disk);
+int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
 void disk_del_events(struct gendisk *disk);
 void disk_release_events(struct gendisk *disk);
diff --git a/block/disk-events.c b/block/disk-events.c
index a75931ff5da4..0262784be34c 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -410,17 +410,17 @@ module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
 /*
  * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
  */
-void disk_alloc_events(struct gendisk *disk)
+int disk_alloc_events(struct gendisk *disk)
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
@@ -432,6 +432,8 @@ void disk_alloc_events(struct gendisk *disk)
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
 	disk->ev = ev;
+
+	return 0;
 }
 
 void disk_add_events(struct gendisk *disk)
diff --git a/block/genhd.c b/block/genhd.c
index b84ba22eed39..c6c9c196ff27 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -449,8 +449,9 @@ static void unregister_disk(struct gendisk *disk)
 	disk_invalidate(disk);
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk,
-			  const struct attribute_group **groups)
+static int __must_check register_disk(struct device *parent,
+				      struct gendisk *disk,
+				      const struct attribute_group **groups)
 {
 	struct device *ddev = disk_to_dev(disk);
 	int err;
@@ -466,15 +467,21 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		WARN_ON(ddev->groups);
 		ddev->groups = groups;
 	}
-	if (device_add(ddev))
-		return;
+	err = device_add(ddev);
+	if (err) {
+		/*
+		 * We don't put_device(ddev), the driver is responsible to
+		 * issue the last put_device(ddev), however it does this
+		 * inderectly with put_disk(), or typically more often with
+		 * just blk_cleanup_disk().
+		 */
+		return err;
+	}
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
@@ -489,7 +496,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 
 	if (disk->flags & GENHD_FL_HIDDEN)
-		return;
+		return 0;
 
 	disk_scan_partitions(disk);
 	disk_announce(disk);
@@ -498,8 +505,19 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		err = sysfs_create_link(&ddev->kobj,
 			  &disk->queue->backing_dev_info->dev->kobj,
 			  "bdi");
-		WARN_ON(err);
+		if (WARN_ON(err))
+			goto exit_del_block_depr;
 	}
+	return 0;
+
+exit_del_block_depr:
+	unregister_disk_partitions(disk);
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+exit_del_device:
+	device_del(ddev);
+
+	return err;
 }
 
 /**
@@ -512,22 +530,24 @@ static void register_disk(struct device *parent, struct gendisk *disk,
  * This function registers the partitioning information in @disk
  * with the kernel.
  *
- * FIXME: error handling
  */
-static void __device_add_disk(struct device *parent, struct gendisk *disk,
-			      const struct attribute_group **groups,
-			      bool register_queue)
+static int __device_add_disk(struct device *parent, struct gendisk *disk,
+			     const struct attribute_group **groups,
+			     bool register_queue)
 {
 	int ret;
 
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
-	 * so that it sticks around as long as @disk is there.
+	 * so that it sticks around as long as @disk is there. The driver
+	 * must call blk_cleanup_disk() on error from this function.
 	 */
-	if (blk_get_queue(disk->queue))
-		set_bit(GD_QUEUE_REF, &disk->state);
-	else
-		WARN_ON_ONCE(1);
+	if (WARN_ON_ONCE(!blk_get_queue(disk->queue))) {
+		disk->queue = NULL;
+		return -ESHUTDOWN;
+	}
+
+	set_bit(GD_QUEUE_REF, &disk->state);
 
 	/*
 	 * The disk queue should now be all set with enough information about
@@ -546,7 +566,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * and all partitions from the extended dev_t space.
 	 */
 	if (disk->major) {
-		WARN_ON(!disk->minors);
+		if (WARN_ON(!disk->minors))
+			return -EINVAL;
 
 		if (disk->minors > DISK_MAX_PARTS) {
 			pr_err("block: can't allocate more than %d partitions\n",
@@ -554,12 +575,13 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 			disk->minors = DISK_MAX_PARTS;
 		}
 	} else {
-		WARN_ON(disk->minors);
+		if (WARN_ON(disk->minors))
+			return -EINVAL;
 
 		ret = blk_alloc_ext_minor();
 		if (ret < 0) {
 			WARN_ON(1);
-			return;
+			return ret;
 		}
 		disk->major = BLOCK_EXT_MAJOR;
 		disk->first_minor = MINOR(ret);
@@ -568,7 +590,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->flags |= GENHD_FL_UP;
 
-	disk_alloc_events(disk);
+	ret = disk_alloc_events(disk);
+	if (ret)
+		goto exit_free_ext_minor;
 
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
@@ -585,29 +609,57 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		dev->devt = MKDEV(disk->major, disk->first_minor);
 		ret = bdi_register(bdi, "%u:%u",
 				   disk->major, disk->first_minor);
-		WARN_ON(ret);
+		if (WARN_ON(ret))
+			goto exit_disk_release_events;
 		bdi_set_owner(bdi, dev);
 		bdev_add(disk->part0, dev->devt);
 	}
-	register_disk(parent, disk, groups);
-	if (register_queue)
-		blk_register_queue(disk);
+	ret = register_disk(parent, disk, groups);
+	if (ret)
+		goto exit_unregister_bdi;
+
+	if (register_queue) {
+		ret = blk_register_queue(disk);
+		if (ret)
+			goto exit_unregister_disk;
+	}
 
 	disk_add_events(disk);
-	blk_integrity_add(disk);
+
+	ret = blk_integrity_add(disk);
+	if (ret)
+		goto exit_del_events;
+
+	return 0;
+exit_del_events:
+	disk_del_events(disk);
+exit_unregister_disk:
+	unregister_disk(disk);
+	return ret;
+
+exit_unregister_bdi:
+	if (disk->queue && !(disk->flags & GENHD_FL_HIDDEN))
+		bdi_unregister(disk->queue->backing_dev_info);
+exit_disk_release_events:
+	disk_release_events(disk);
+exit_free_ext_minor:
+	if (disk->major == BLOCK_EXT_MAJOR)
+		blk_free_ext_minor(disk->first_minor);
+
+	return ret;
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
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..51f27b9b38b5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -210,16 +210,16 @@ static inline dev_t disk_devt(struct gendisk *disk)
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
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
-- 
2.27.0

