Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C2C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC23E6192B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhELHDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:22 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33487 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhELHDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:20 -0400
Received: by mail-pg1-f176.google.com with SMTP id i5so12775199pgm.0;
        Wed, 12 May 2021 00:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/hh6bk1wtNYHq61QrcR1LQZXgbzl7sn79USXwdg4bI=;
        b=fhjCG33JK7l/SIleI3A8lAlLMpQlTs4PYQ2fBplIzUNFeocBGu0ozmPJPGmPDoI2VQ
         6RXTf2MEIfcmj79Nn7MeoWeuRl8sO9NoJccW/Zn/wgMEaaw8Opo2MyxKISO0TgmmZqHt
         xVZISlYBFeLZ9WN5dloj+dVvFBUqU6KLvu+vovH0WhJeFMJrbkKGtKoH1cOLuXy1yiSg
         2cR+HQj3nZu34gmakv+wAjPmkk/dSkWKytLXNFflOZdRC1FRnxLp+uV7ThioqojMV/E8
         xz1lqzCiXNflSEPS2E6rkOakfuDcp7Z6paV/bG618l4NxagLZ4+V/7kDE/4WbalK157W
         2sYA==
X-Gm-Message-State: AOAM532KiBI78gFtMhG9lQqZT7hzPB2yILLHJO/w6Kgpy4hR2ur3lBwe
        CzoyVsRi2sx0FXvuWg1wbC4=
X-Google-Smtp-Source: ABdhPJyUHuhTDooZR9xE/k7Zf63/FJgJ6ccsE4853CUhNK7tKKmJLqX9QOGqQHPWyQySKypbwN7kqg==
X-Received: by 2002:a62:92d7:0:b029:2c7:faf1:b1bd with SMTP id o206-20020a6292d70000b02902c7faf1b1bdmr8914228pfd.41.1620802931507;
        Wed, 12 May 2021 00:02:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y14sm3668174pjr.51.2021.05.12.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3283F423E5; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 3/8] block: move disk invalidation from del_gendisk() into a helper
Date:   Wed, 12 May 2021 06:46:24 +0000
Message-Id: <20210512064629.13899-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the disk / partition invalidation into a helper. This will make
reading del_gendisk easier to read, in preparation for adding support
to add error handling later on register_disk() and to later share more
code with del_gendisk.

This change has no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 484cda981b4e..40a34981f9e2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -438,6 +438,31 @@ static void disk_announce(struct gendisk *disk)
 	disk_uevent(disk, KOBJ_ADD);
 }
 
+static void disk_invalidate(struct gendisk *disk)
+{
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+
+		/*
+		 * Unregister bdi before releasing device numbers (as they can
+		 * get reused and we'd get clashes in sysfs).
+		 */
+		bdi_unregister(disk->queue->backing_dev_info);
+	}
+
+	blk_unregister_queue(disk);
+
+	kobject_put(disk->part0->bd_holder_dir);
+	kobject_put(disk->slave_dir);
+
+	part_stat_set_all(disk->part0, 0);
+	disk->part0->bd_stamp = 0;
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
+	device_del(disk_to_dev(disk));
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -614,7 +639,6 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_integrity_del(disk);
 	disk_del_events(disk);
-
 	/*
 	 * Block lookups of the disk until all bdevs are unhashed and the
 	 * disk is marked as dead (GENHD_FL_UP cleared).
@@ -638,27 +662,7 @@ void del_gendisk(struct gendisk *disk)
 	disk->flags &= ~GENHD_FL_UP;
 	up_write(&bdev_lookup_sem);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-
-		/*
-		 * Unregister bdi before releasing device numbers (as they can
-		 * get reused and we'd get clashes in sysfs).
-		 */
-		bdi_unregister(disk->queue->backing_dev_info);
-	}
-
-	blk_unregister_queue(disk);
-
-	kobject_put(disk->part0->bd_holder_dir);
-	kobject_put(disk->slave_dir);
-
-	part_stat_set_all(disk->part0, 0);
-	disk->part0->bd_stamp = 0;
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
-	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
-	device_del(disk_to_dev(disk));
+	disk_invalidate(disk);
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.30.2

