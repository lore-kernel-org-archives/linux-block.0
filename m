Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D466C636CA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0E66127C
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 21:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGOVC5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:57 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41829 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhGOVCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:50 -0400
Received: by mail-pl1-f175.google.com with SMTP id e14so1323088plh.8;
        Thu, 15 Jul 2021 13:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoFaLAk+cz2X85Cq0Vekfi5aqqkDNDdt4P2wEqpziyE=;
        b=cyJayVnFVxMRNm8GDyvcggIqhNWNaLrk+UFNnfyWloTPGFnkoypxY6gwphbF78WyF3
         kJnHPeS2RvmBwgdB8TJzdyhi4t/NhO2KQzT6ufNLTx42Ns2yNZJ3wU8iW06VIOnMyYU6
         Ortf+zrtYgGm+Jokfx2HM7NdurT15e60ar+JZKdU9yoOljcozxGdd9WBZ5TaiCkyIZwW
         +0fyU78YMsNZ6T8YBArkm7xtnuawenv2PciSEOEj8FGs/K/u8PfKcwDAQalpCs+FPhLe
         FV29uESXAXkis3VFOIANXRF3kc6laMRZ7qLYuvgbB5BOJt8CSkBaB8qdrmjzulPCvKYx
         +JOw==
X-Gm-Message-State: AOAM532uHTFf6G1spbMvOUMaznGg+bUzHG/IE/L0VPt0B1Th+sEV8/Mq
        JsMk+FPf3I7IB3GmS5TVMd8=
X-Google-Smtp-Source: ABdhPJzfNfao+EqeGoWTrgXHJdm80QQfwpOv6NgdewrkGs804D2OVUQbABgPPXheVvmulV/GaR89wA==
X-Received: by 2002:a17:902:eb52:b029:129:bc24:ce5e with SMTP id i18-20020a170902eb52b0290129bc24ce5emr4918316pli.67.1626382796477;
        Thu, 15 Jul 2021 13:59:56 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id d2sm7653297pfa.84.2021.07.15.13.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:55 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 12/12] block: make probe in blk_request_module() return an error
Date:   Thu, 15 Jul 2021 13:59:20 -0700
Message-Id: <20210715205920.2023980-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This makes the probe callback use din blk_request_module() return
an error. We do this as add_disk() now has error handling, and
so we can bail earlier than before. If a probe is not implemented
then its not used.

This is mostly useful for the following drivers:

  * ataflop
  * brd
  * floppy
  * loop
  * scsi/sd

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c           | 15 +++++++++------
 drivers/block/ataflop.c | 20 +++++++++++++++-----
 drivers/block/brd.c     |  7 +++++--
 drivers/block/floppy.c  | 14 ++++++++++----
 drivers/block/loop.c    |  6 +++---
 drivers/scsi/sd.c       |  3 ++-
 fs/block_dev.c          |  5 ++++-
 include/linux/genhd.h   |  4 ++--
 8 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 72703d243b44..ca6393df09ad 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -161,7 +161,7 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
-	void (*probe)(dev_t devt);
+	int (*probe)(dev_t devt);
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 
@@ -190,7 +190,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
  *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
- * @probe: allback that is called on access to any minor number of @major
+ * @probe: callback that is called on access to any minor number of @major
  *
  * The @name must be unique within the system.
  *
@@ -208,7 +208,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * Use register_blkdev instead for any new code.
  */
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+		int (*probe)(dev_t devt))
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -728,17 +728,18 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
-void blk_request_module(dev_t devt)
+int blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
+	int err;
 
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
 		if ((*n)->major == major && (*n)->probe) {
-			(*n)->probe(devt);
+			err = (*n)->probe(devt);
 			mutex_unlock(&major_names_lock);
-			return;
+			return err;
 		}
 	}
 	mutex_unlock(&major_names_lock);
@@ -746,6 +747,8 @@ void blk_request_module(dev_t devt)
 	if (request_module("block-major-%d-%d", MAJOR(devt), MINOR(devt)) > 0)
 		/* Make old-style 2.4 aliases work */
 		request_module("block-major-%d", MAJOR(devt));
+
+	return 0;
 }
 
 /*
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 4b3f1158fa04..ce08b8e60163 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2005,22 +2005,32 @@ static void atari_floppy_disk_remove(void)
 
 }
 
-static void ataflop_probe(dev_t dev)
+static int ataflop_probe(dev_t dev)
 {
 	int drive = MINOR(dev) & 3;
 	int type  = MINOR(dev) >> 2;
+	int err = -ENODEV;
 
 	if (type)
 		type--;
 
-	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
-		return;
+	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&ataflop_probe_lock);
 	if (!unit[drive].disk[type]) {
-		if (ataflop_alloc_disk(drive, type) == 0)
-			add_disk(unit[drive].disk[type]);
+		if (ataflop_alloc_disk(drive, type) == 0) {
+			err = add_disk(unit[drive].disk[type]);
+			if (err)
+				blk_cleanup_disk(unit[drive].disk[type]);
+		}
 	}
 	mutex_unlock(&ataflop_probe_lock);
+
+out:
+	return err;
 }
 
 static int __init atari_floppy_init (void)
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index ca017ca315c5..104adf70a15a 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -429,10 +429,11 @@ static int brd_alloc(int i)
 	return err;
 }
 
-static void brd_probe(dev_t dev)
+static int brd_probe(dev_t dev)
 {
 	int i = MINOR(dev) / max_part;
 	struct brd_device *brd;
+	int err = 0;
 
 	mutex_lock(&brd_devices_mutex);
 	list_for_each_entry(brd, &brd_devices, brd_list) {
@@ -440,9 +441,11 @@ static void brd_probe(dev_t dev)
 			goto out_unlock;
 	}
 
-	brd_alloc(i);
+	err = brd_alloc(i);
 out_unlock:
 	mutex_unlock(&brd_devices_mutex);
+
+	return err;
 }
 
 static void brd_del_one(struct brd_device *brd)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index cad17b49e700..52bc645f3060 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4517,21 +4517,27 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 
 static DEFINE_MUTEX(floppy_probe_lock);
 
-static void floppy_probe(dev_t dev)
+static int floppy_probe(dev_t dev)
 {
 	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
 	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
+	int err;
 
 	if (drive >= N_DRIVE || !floppy_available(drive) ||
 	    type >= ARRAY_SIZE(floppy_type))
-		return;
+		return -EINVAL;
 
 	mutex_lock(&floppy_probe_lock);
 	if (!disks[drive][type]) {
-		if (floppy_alloc_disk(drive, type) == 0)
-			add_disk(disks[drive][type]);
+		if (floppy_alloc_disk(drive, type) == 0) {
+			err = add_disk(disks[drive][type]);
+			if (err)
+				blk_cleanup_disk(disks[drive][type]);
+		}
 	}
 	mutex_unlock(&floppy_probe_lock);
+
+	return err;
 }
 
 static int __init do_floppy_init(void)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index efbd8e29aca7..081cccd39bc9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2358,13 +2358,13 @@ static void loop_remove(struct loop_device *lo)
 	kfree(lo);
 }
 
-static void loop_probe(dev_t dev)
+static int loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
 
 	if (max_loop && idx >= max_loop)
-		return;
-	loop_add(idx);
+		return -EINVAL;
+	return loop_add(idx);
 }
 
 static int loop_control_remove(int idx)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 01af61a38e4e..800dfd5984bd 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -633,8 +633,9 @@ static struct scsi_driver sd_template = {
  * Don't request a new module, as that could deadlock in multipath
  * environment.
  */
-static void sd_default_probe(dev_t devt)
+static int sd_default_probe(dev_t devt)
 {
+	return 0;
 }
 
 /*
diff --git a/fs/block_dev.c b/fs/block_dev.c
index c41d0e550d39..531feb097cb2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1326,10 +1326,13 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 {
 	struct block_device *bdev;
 	struct gendisk *disk;
+	int err;
 
 	bdev = bdget(dev);
 	if (!bdev) {
-		blk_request_module(dev);
+		err = blk_request_module(dev);
+		if (err)
+			return NULL;
 		bdev = bdget(dev);
 		if (!bdev)
 			return NULL;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 73024416d2d5..9db56d4562ae 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -312,7 +312,7 @@ struct gendisk *__blk_alloc_disk(int node);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+		int (*probe)(dev_t devt));
 #define register_blkdev(major, name) \
 	__register_blkdev(major, name, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
@@ -342,7 +342,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
 dev_t blk_lookup_devt(const char *name, int partno);
-void blk_request_module(dev_t devt);
+int blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
 void printk_all_partitions(void);
 #else /* CONFIG_BLOCK */
-- 
2.27.0

