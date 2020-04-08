Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082C6C2BB1D
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9D20768
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ShjMphoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgDHTou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:44:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgDHTou (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 15:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Wml7/xX2IDkCSxaxAQtskneh/deGc50NOSntC92sdYg=; b=ShjMphoK9COXRZM/bzso9hS1UX
        AdN5i4+iAFiH1gNQ1l1whtCPqtdnm3YP2JaMjqbXLG+5doufa39H1cSgscgknCU9hLzwHBxExEqIk
        FNm2TucytguFNHLWMXa2NPLFaj8BZOiAv2rgsFDHHYFEamv3jyrx6jNkn1Aq66uHoMz9J8sIcRrzQ
        slcSRKhSMcbvCk6FQMsNVREdIwdlssUueo9bDWZOBejSLUL3vgXDFI6IJCe9YNu0xtcGh1/eUhlcy
        bzXYgHWK7omt796ew6g6ybrcRwTdTV6zrgfLklzd1zRalCp43bEPHG/jcjJQTZbdsw1fWsqOAad9h
        6B46UcMg==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGcy-0004HP-RA; Wed, 08 Apr 2020 19:44:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 03/10] block: cleanup hd_struct freeing
Date:   Wed,  8 Apr 2020 21:44:32 +0200
Message-Id: <20200408194439.1580699-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408194439.1580699-1-hch@lst.de>
References: <20200408194439.1580699-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move hd_ref_init out of line as there it isn't anywhere near a fast path,
and rename the rcu ref freeing callbacks to be more descriptive.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h             | 10 +---------
 block/partitions/core.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 0cbf64108922..b1a0b8cd87f0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -389,7 +389,6 @@ char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-void __delete_partition(struct percpu_ref *ref);
 void delete_partition(struct gendisk *disk, struct hd_struct *part);
 int bdev_add_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
@@ -397,14 +396,7 @@ int bdev_del_partition(struct block_device *bdev, int partno);
 int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
-
-static inline int hd_ref_init(struct hd_struct *part)
-{
-	if (percpu_ref_init(&part->ref, __delete_partition, 0,
-				GFP_KERNEL))
-		return -ENOMEM;
-	return 0;
-}
+int hd_ref_init(struct hd_struct *part);
 
 static inline void hd_struct_get(struct hd_struct *part)
 {
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 0b1b67f50652..13d61ed76e0e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -274,10 +274,10 @@ struct device_type part_type = {
 	.uevent		= part_uevent,
 };
 
-static void delete_partition_work_fn(struct work_struct *work)
+static void hd_struct_free_work(struct work_struct *work)
 {
-	struct hd_struct *part = container_of(to_rcu_work(work), struct hd_struct,
-					rcu_work);
+	struct hd_struct *part =
+		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
 
 	part->start_sect = 0;
 	part->nr_sects = 0;
@@ -285,13 +285,21 @@ static void delete_partition_work_fn(struct work_struct *work)
 	put_device(part_to_dev(part));
 }
 
-void __delete_partition(struct percpu_ref *ref)
+static void hd_struct_free(struct percpu_ref *ref)
 {
 	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
-	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
+
+	INIT_RCU_WORK(&part->rcu_work, hd_struct_free_work);
 	queue_rcu_work(system_wq, &part->rcu_work);
 }
 
+int hd_ref_init(struct hd_struct *part)
+{
+	if (percpu_ref_init(&part->ref, hd_struct_free, 0, GFP_KERNEL))
+		return -ENOMEM;
+	return 0;
+}
+
 /*
  * Must be called either with bd_mutex held, before a disk can be opened or
  * after all disk users are gone.
-- 
2.25.1

