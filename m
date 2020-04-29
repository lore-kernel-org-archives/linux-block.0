Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E3C83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AA9208FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146548;
	bh=j9/lHjbLRkY6bjVGKlUEVW0nbhWaLdXWkPsN+o4VWrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lVPQu3/yPiQRb2UYu3cIQTOQXkf52NyvyL2Ju+PKkGEoKV0aRwTsjAR0I+jGipSAo
	 khyqErWccgYmDALdWFH/3s94P5s0mNRalj43Jb4iyVtfal536K1JxSaMgGUqbEBbHT
	 LTwsWGh/i7Xi7mnrIn8iE9O3svFHA82oik7wvfUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgD2HtG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:49:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44991 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2Hsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id l20so634049pgb.11;
        Wed, 29 Apr 2020 00:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui7sUU2uXAen4F2aKDMyOb2hT6OZZtUnvlr6nEnP7hs=;
        b=t3LSKuOxGx0rorUKdS9445LKoJ+XTAYmYIiYCU4a8wQq6t7xQBay0HCgYDaE5QI1Wx
         sPY1Pgq7BrUp/cs8+7Q0BOzTLFgn5hXTCetwNrq+7YGTlDl/dOXUKE+F69rc6FbECUU3
         Kl/HfesZpShdKEMuMG/F8Fo9IjLYbPHTJ9/RNXo+ejeFMslZgglN1g38CD3EUJlzVKjk
         Y4ZAf0PDv7mON8Oucs7JA37ZUUtY330pO4cFfYVwNBt/wDWR4MDrCRTDL71XJplCoqlr
         fPAwk1Vklh6KB53czkhIzUDJROLZv+Y49mhZrgtkKUb09JbMGr6xizjUfIq2oAq/+wW0
         KK6A==
X-Gm-Message-State: AGi0PuYH86v/2vh559fq848fjwvKxe1tg6YB2HFpZpJIKMiAt8V5uS2q
        9rmXK/hxXF+kBSaUKcpczhDxZNnuLqw=
X-Google-Smtp-Source: APiQypIfqaJr6+tIpo4jSEWkvkcczNT6n+p/Gx6tidb1YRtSesFynHFWG42Edj+HXFJvdK0Y7GLNUQ==
X-Received: by 2002:aa7:9d84:: with SMTP id f4mr29376008pfq.290.1588146530685;
        Wed, 29 Apr 2020 00:48:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a12sm427432pfr.28.2020.04.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BCA8441C23; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 3/6] block: move disk invalidation from del_gendisk() into a helper
Date:   Wed, 29 Apr 2020 07:48:41 +0000
Message-Id: <20200429074844.6241-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
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
 block/genhd.c | 85 +++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 091208f5f27b..b4d75a15fd31 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -718,6 +718,50 @@ static void disk_announce(struct gendisk *disk)
 	disk_part_iter_exit(&piter);
 }
 
+static void invalidate_partition(struct gendisk *disk, int partno)
+{
+	struct block_device *bdev;
+
+	bdev = bdget_disk(disk, partno);
+	if (!bdev)
+		return;
+
+	fsync_bdev(bdev);
+	__invalidate_device(bdev, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it gets evicted as soon
+	 * as last inode reference is dropped.
+	 */
+	remove_inode_hash(bdev->bd_inode);
+	bdput(bdev);
+}
+
+static void disk_invalidate(struct gendisk *disk)
+{
+	struct disk_part_iter piter;
+	struct hd_struct *part;
+
+	/*
+	 * Block lookups of the disk until all bdevs are unhashed and the
+	 * disk is marked as dead (GENHD_FL_UP cleared).
+	 */
+	down_write(&disk->lookup_sem);
+	/* invalidate stuff */
+	disk_part_iter_init(&piter, disk,
+			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
+	while ((part = disk_part_iter_next(&piter))) {
+		invalidate_partition(disk, part->partno);
+		delete_partition(disk, part);
+	}
+	disk_part_iter_exit(&piter);
+
+	invalidate_partition(disk, 0);
+	set_capacity(disk, 0);
+	disk->flags &= ~GENHD_FL_UP;
+	up_write(&disk->lookup_sem);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -886,25 +930,6 @@ void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
 }
 EXPORT_SYMBOL(device_add_disk_no_queue_reg);
 
-static void invalidate_partition(struct gendisk *disk, int partno)
-{
-	struct block_device *bdev;
-
-	bdev = bdget_disk(disk, partno);
-	if (!bdev)
-		return;
-
-	fsync_bdev(bdev);
-	__invalidate_device(bdev, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it gets evicted as soon
-	 * as last inode reference is dropped.
-	 */
-	remove_inode_hash(bdev->bd_inode);
-	bdput(bdev);
-}
-
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -926,32 +951,12 @@ static void invalidate_partition(struct gendisk *disk, int partno)
  */
 void del_gendisk(struct gendisk *disk)
 {
-	struct disk_part_iter piter;
-	struct hd_struct *part;
-
 	might_sleep();
 
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
-	/*
-	 * Block lookups of the disk until all bdevs are unhashed and the
-	 * disk is marked as dead (GENHD_FL_UP cleared).
-	 */
-	down_write(&disk->lookup_sem);
-	/* invalidate stuff */
-	disk_part_iter_init(&piter, disk,
-			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
-	while ((part = disk_part_iter_next(&piter))) {
-		invalidate_partition(disk, part->partno);
-		delete_partition(disk, part);
-	}
-	disk_part_iter_exit(&piter);
-
-	invalidate_partition(disk, 0);
-	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
-	up_write(&disk->lookup_sem);
+	disk_invalidate(disk);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-- 
2.25.1

