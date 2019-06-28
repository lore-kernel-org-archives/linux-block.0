Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C69C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 19:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E752086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 19:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfF1T41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:56:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfF1T41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 15:56:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so3522647pfc.1
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 12:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YB/2JR2jAw/IkswCTmL2cVE4y0V41wJIfAv0cXVbXs4=;
        b=jAgAIBHsWs0tb9KnhR6yenqbY2tA6+ixCXOmM7Fl4FOITozykW7yld65K9R+Hi3Rwg
         tjRvOgRr3DHyz6xGnrThEaXI+NHSoTZIzvLzsLmQLFxYPGRky9hEzC7UFR8O9Qf/mYK2
         0Z/EYf02bDIoeVK46oomwXOOzqahDQoxLy4KU+KLd7iKi70apjRFhejssjG0XmUyTpFy
         y+O2zqEvXOzLqPHM3b6zQMDPi+VtqNwFln+hY4dcvZUybDG/4DUl9Zyz8zj8qu+kuFyT
         afY+HBXQK3okSJdq94Bg/4iCoj5VOLPZUaTkOob2tlez0uRKxulHhbdPDyjkg8lBT/kZ
         aMhg==
X-Gm-Message-State: APjAAAX/yKkNGvb7Stwt0Np5BUoIWeA93+sAbW7DsbL6PpnCOAYXVlvg
        rd0P3rxW0fWfJ4WCReVB6B/6Lxd5Gvk=
X-Google-Smtp-Source: APXvYqy/U55uOvNEb2h1YCh0AX5sR8FBS5AQCgYCRTGJgxxNKh8FNZW1Xsx3J75PACbxzty2ElTRWA==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr10630855pgq.399.1561751785861;
        Fri, 28 Jun 2019 12:56:25 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f2sm2370522pgs.83.2019.06.28.12.56.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:56:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] block: Rename hd_struct.policy into hd_struct.read_only
Date:   Fri, 28 Jun 2019 12:56:15 -0700
Message-Id: <20190628195615.201990-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since nobody knows what "policy" means, rename the field to "read_only"
for clarity. Martin Petersen proposed this earlier - see also his patch
"scsi: sd: block: Fix regressions in read-only block device handling"
(https://www.spinics.net/lists/linux-scsi/msg129146.html). This patch
is an extension of a subset of Martin's patch.

The only change in this patch is if another value than 0 or 1 is passed
to set_device_ro() that that function converts that value into a
boolean. This change is not user visible because the BLKROGET ioctl
implementation converts the part->policy value into a boolean anyway.

The policy member was introduced by commit 4d466c1fcdce ("[PATCH] r/o
state moved to gendisks") # v2.6.12.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c          |  2 +-
 block/genhd.c             | 18 +++++++++---------
 block/ioctl.c             |  2 +-
 block/partition-generic.c |  4 ++--
 include/linux/fs.h        |  2 +-
 include/linux/genhd.h     | 11 ++++++-----
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6361419f0b6e..cfa0687bf86c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -802,7 +802,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 {
 	const int op = bio_op(bio);
 
-	if (part->policy && op_is_write(op)) {
+	if (part->read_only && op_is_write(op)) {
 		char b[BDEVNAME_SIZE];
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
diff --git a/block/genhd.c b/block/genhd.c
index 97887e59f3b2..290deeb3bacf 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1558,36 +1558,36 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_device_ro(struct block_device *bdev, int flag)
+void set_device_ro(struct block_device *bdev, bool read_only)
 {
-	bdev->bd_part->policy = flag;
+	bdev->bd_part->read_only = read_only;
 }
 
 EXPORT_SYMBOL(set_device_ro);
 
-void set_disk_ro(struct gendisk *disk, int flag)
+void set_disk_ro(struct gendisk *disk, bool read_only)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	if (disk->part0.policy != flag) {
-		set_disk_ro_uevent(disk, flag);
-		disk->part0.policy = flag;
+	if (disk->part0.read_only != read_only) {
+		set_disk_ro_uevent(disk, read_only);
+		disk->part0.read_only = read_only;
 	}
 
 	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-		part->policy = flag;
+		part->read_only = read_only;
 	disk_part_iter_exit(&piter);
 }
 
 EXPORT_SYMBOL(set_disk_ro);
 
-int bdev_read_only(struct block_device *bdev)
+bool bdev_read_only(struct block_device *bdev)
 {
 	if (!bdev)
 		return 0;
-	return bdev->bd_part->policy;
+	return bdev->bd_part->read_only;
 }
 
 EXPORT_SYMBOL(bdev_read_only);
diff --git a/block/ioctl.c b/block/ioctl.c
index 15a0eb80ada9..4871f58eaea2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -545,7 +545,7 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 			return -EINVAL;
 		return put_long(arg, (bdev->bd_bdi->ra_pages*PAGE_SIZE) / 512);
 	case BLKROGET:
-		return put_int(arg, bdev_read_only(bdev) != 0);
+		return put_int(arg, bdev_read_only(bdev));
 	case BLKBSZGET: /* get block device soft block size (cf. BLKSSZGET) */
 		return put_int(arg, block_size(bdev));
 	case BLKSSZGET: /* get block device logical block size */
diff --git a/block/partition-generic.c b/block/partition-generic.c
index aee643ce13d1..4ab79a66a5a6 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -98,7 +98,7 @@ static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%d\n", p->policy ? 1 : 0);
+	return sprintf(buf, "%d\n", p->read_only);
 }
 
 static ssize_t part_alignment_offset_show(struct device *dev,
@@ -345,7 +345,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		queue_limit_discard_alignment(&disk->queue->limits, start);
 	p->nr_sects = len;
 	p->partno = partno;
-	p->policy = get_disk_ro(disk);
+	p->read_only = get_disk_ro(disk);
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..bb679ab2bfe7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3034,7 +3034,7 @@ static inline void remove_inode_hash(struct inode *inode)
 extern void inode_sb_list_add(struct inode *inode);
 
 #ifdef CONFIG_BLOCK
-extern int bdev_read_only(struct block_device *);
+extern bool bdev_read_only(struct block_device *);
 #endif
 extern int set_blocksize(struct block_device *, int);
 extern int sb_set_blocksize(struct super_block *, int);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8b5330dd5ac0..797043ff699b 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -118,7 +118,8 @@ struct hd_struct {
 	unsigned int discard_alignment;
 	struct device __dev;
 	struct kobject *holder_dir;
-	int policy, partno;
+	bool read_only;
+	int partno;
 	struct partition_meta_info *info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
@@ -438,12 +439,12 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
-extern void set_disk_ro(struct gendisk *disk, int flag);
+extern void set_device_ro(struct block_device *bdev, bool read_only);
+extern void set_disk_ro(struct gendisk *disk, bool read_only);
 
-static inline int get_disk_ro(struct gendisk *disk)
+static inline bool get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0.policy;
+	return disk->part0.read_only;
 }
 
 extern void disk_block_events(struct gendisk *disk);
-- 
2.22.0.410.gd8fdbe21b5-goog

