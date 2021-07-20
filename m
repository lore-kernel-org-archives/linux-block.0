Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A027C636C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE224610A7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGTRku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:40:50 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:34748 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGTRkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:16 -0400
Received: by mail-pf1-f170.google.com with SMTP id o201so245414pfd.1;
        Tue, 20 Jul 2021 11:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IuTvqRp9Gt/l3C48oyR+GgBsjs5V5CG3iY3YyWwYw1U=;
        b=SZreosOYoO8uBqmDh/MBFnbeb1WD0unP+DUTSUGwjJo909vLpcbjs8mHzYQfZusUJo
         rB/jXV7xBdtSH9M72j9XhbSWDb7kLgNCAV3Wtyev1Lv5kF0tu7Gg/VfqXQaWnWhPMV5L
         vrBLauQCigsydH+3J23MRjifNQdRPJeII595zHeW8aj1Hnj85P/yem6H1vzYkOsbyHER
         R5aGLS2zhOFmcrUK5D+fi+G//71UC/m4jwlf6vSQjyxhZ5vMf/Na2WT57qvmTP9/33eV
         EWB8R5BGyiMuUF91ulo9ezBVBzrh0PR3P5oLptBlgurwo4OJ5HEv7YcbKlc4/WP68TOz
         vQQA==
X-Gm-Message-State: AOAM5330/ZLlkfjzmmRvan+9ffv1/rYo6ghDcQTysG2oqIGSiEtcWu/L
        e4cbj8XsSgkmXd6B6WJKlnk=
X-Google-Smtp-Source: ABdhPJx0MZOtOo1ik8OlDewYWPyiJ+dXNDwYnW1arJgCKNpIdK4y+WdQ/CfTnbkHw//kLjktFHLnpA==
X-Received: by 2002:a65:6494:: with SMTP id e20mr32367308pgv.101.1626805254539;
        Tue, 20 Jul 2021 11:20:54 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id j3sm24055015pfc.10.2021.07.20.11.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:20:53 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/5] block: add flag for add_disk() completion notation
Date:   Tue, 20 Jul 2021 11:20:44 -0700
Message-Id: <20210720182048.1906526-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Often drivers may have complex setups where it is not
clear if their disk completed their respective *add_disk*()
call. They either have to invent a setting or, they
incorrectly use GENHD_FL_UP. Using GENHD_FL_UP however is
used internally so we know when we can add / remove
partitions safely. We can easily fail along the way
prior to add_disk() completing and still have
GENHD_FL_UP set, so it would not be correct in that case
to call del_gendisk() on the disk.

Provide a new flag then which allows us to check if
*add_disk*() completed, and conversely just make
del_gendisk() check for this for drivers so that
they can safely call del_gendisk() and we'll figure
it out if it is safe for you to call this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c         |  8 ++++++++
 include/linux/genhd.h | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..a858eed05e55 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -539,6 +539,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
+
+	disk->flags |= GENHD_FL_DISK_ADDED;
 }
 
 void device_add_disk(struct device *parent, struct gendisk *disk,
@@ -569,6 +571,9 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
  *
+ * Drivers can safely call this even if they are not sure if the respective
+ * __device_add_disk() call succeeded.
+ *
  * Drivers exist which depend on the release of the gendisk to be synchronous,
  * it should not be deferred.
  *
@@ -578,6 +583,9 @@ void del_gendisk(struct gendisk *disk)
 {
 	might_sleep();
 
+	if (!blk_disk_added(disk))
+		return;
+
 	if (WARN_ON_ONCE(!disk->queue))
 		return;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..2470c8b56599 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -56,6 +56,10 @@ struct partition_meta_info {
  * Must not be set for devices which are removed entirely when the
  * media is removed.
  *
+ * ``GENHD_FL_DISK_ADDED`` (0x0002): used to clarify that the
+ * respective add_disk*() call completed successfully, so that
+ * we know we can safely process del_gendisk() on the disk.
+ *
  * ``GENHD_FL_CD`` (0x0008): the block device is a CD-ROM-style
  * device.
  * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
@@ -94,7 +98,7 @@ struct partition_meta_info {
  * Used for multipath devices.
  */
 #define GENHD_FL_REMOVABLE			0x0001
-/* 2 is unused (used to be GENHD_FL_DRIVERFS) */
+#define GENHD_FL_DISK_ADDED			0x0002
 /* 4 is unused (used to be GENHD_FL_MEDIA_CHANGE_NOTIFY) */
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_UP				0x0010
@@ -189,6 +193,11 @@ struct gendisk {
 #define disk_to_cdi(disk)	NULL
 #endif
 
+static inline bool blk_disk_added(struct gendisk *disk)
+{
+	return disk && (disk->flags & GENHD_FL_DISK_ADDED);
+}
+
 static inline int disk_max_parts(struct gendisk *disk)
 {
 	if (disk->flags & GENHD_FL_EXT_DEVT)
-- 
2.27.0

