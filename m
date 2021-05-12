Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C76C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9BE610A7
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhELHDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:21 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:33573 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhELHDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:16 -0400
Received: by mail-pj1-f50.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so1002880pjo.0;
        Wed, 12 May 2021 00:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9xWyIt+M2Ul+XOAUCZ5mkanX2OLCMFRGNsaqRwjMSM=;
        b=K8eqNNHXgyl+xjczx19xYR7NRxaFhAZ+LLIUggUW1EQu+zDosry9TxUcT+Cv8iLIK2
         tqIRXNv9Wsq/w3njTdIOx11Qr3Zf0BWdsIfdQuBW0PchKhCsLwm5HrYWi1wvoScFld5N
         ue12hTlrRQTEREpz26AuPnMap4Negr1pC0C17BqlWZDj0VQ3UCeVhH4i9Mi954DXHtDN
         k3SoKsmxBDN2GxpAQjrYRgneY0cmFTnhCQ6IqUNkFp/B5GqaXM5ppkR3fMLyC6JK/aot
         I3uyuiVfENFJX4/n95y18GExm2rIVGm/6AJHkxDEIjFw4nRTyoC5PzDzmemQcArVGvor
         Ss7Q==
X-Gm-Message-State: AOAM533GLT40WiPf/MD8TD3YVGefTAL5AEDqOlGYd22h5PJHzU9xoZzH
        OSSLsz2i4MRuSZJbtdjJg6E=
X-Google-Smtp-Source: ABdhPJx0x1toQi2VR2s06jsBSAYUe/iCHDxy4C9qb0vDCyZ+S0Qkwgd5ld7YNXEBYlBzEYQYNaqqcA==
X-Received: by 2002:a17:90a:1382:: with SMTP id i2mr38084191pja.176.1620802929195;
        Wed, 12 May 2021 00:02:09 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g15sm14537679pfv.127.2021.05.12.00.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3DA7B42403; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 4/8] block: move disk unregistration work from del_gendisk() to a helper
Date:   Wed, 12 May 2021 06:46:25 +0000
Message-Id: <20210512064629.13899-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is quite a bit of code on del_gendisk() which relates to
unregistering the disk, using register_disk() as an counter.
Move all this code into a helper instead of re-writing our own,
which we'll need later to handle errors on add_disk().

Since disk unregistrationa also deals with parition unregistration,
provide a halper for that as well, as we'll later need this when
adding error handling for add_disk().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 56 +++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 40a34981f9e2..baa68192ebb3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -438,6 +438,31 @@ static void disk_announce(struct gendisk *disk)
 	disk_uevent(disk, KOBJ_ADD);
 }
 
+static void unregister_disk_partitions(struct gendisk *disk)
+{
+	/*
+	 * Block lookups of the disk until all bdevs are unhashed and the
+	 * disk is marked as dead (GENHD_FL_UP cleared).
+	 */
+	down_write(&bdev_lookup_sem);
+
+	mutex_lock(&disk->part0->bd_mutex);
+	blk_drop_partitions(disk);
+	mutex_unlock(&disk->part0->bd_mutex);
+	fsync_bdev(disk->part0);
+	__invalidate_device(disk->part0, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it can't be looked
+	 * up any more even if openers still hold references to it.
+	 */
+	remove_inode_hash(disk->part0->bd_inode);
+
+	set_capacity(disk, 0);
+	disk->flags &= ~GENHD_FL_UP;
+	up_write(&bdev_lookup_sem);
+}
+
 static void disk_invalidate(struct gendisk *disk)
 {
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
@@ -463,6 +488,12 @@ static void disk_invalidate(struct gendisk *disk)
 	device_del(disk_to_dev(disk));
 }
 
+static void unregister_disk(struct gendisk *disk)
+{
+	unregister_disk_partitions(disk);
+	disk_invalidate(disk);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -639,30 +670,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_integrity_del(disk);
 	disk_del_events(disk);
-	/*
-	 * Block lookups of the disk until all bdevs are unhashed and the
-	 * disk is marked as dead (GENHD_FL_UP cleared).
-	 */
-	down_write(&bdev_lookup_sem);
-
-	mutex_lock(&disk->part0->bd_mutex);
-	blk_drop_partitions(disk);
-	mutex_unlock(&disk->part0->bd_mutex);
-
-	fsync_bdev(disk->part0);
-	__invalidate_device(disk->part0, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(disk->part0->bd_inode);
-
-	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
-	up_write(&bdev_lookup_sem);
-
-	disk_invalidate(disk);
+	unregister_disk(disk);
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.30.2

