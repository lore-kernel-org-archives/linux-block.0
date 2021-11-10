Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBDEC4332F
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED907611CA
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 00:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKJAcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhKJAck (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 19:32:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFAC061764;
        Tue,  9 Nov 2021 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GXszyetCwwu5olwD1jYlisbHXeHdeSqds9gFGfTpmiw=; b=4u2WqKa4u3E4Wr/St42zwuYB4f
        TfCRBC6+XeCU+jtb1AC1msjZpgMD2jLu6vwq76fvUdVlhscsFl6au/FrTkB8hpAgL1wPnDiLlBQcC
        /6a/5xo9quwXh1J5swEKHgVYtpLEZuGguuC5DvWWCrnHYVVyVM0d8uDK84WYcuqgU7ZyFu/H39QRx
        7B0gMtOmhiTrinaA1mU8FLUrSoyiAsdyj9YJiDLY1Syyu78ubgrom+xp+COlkgoQsluUksfikF0AJ
        dJLjbfUSItPTFOEe8+NIuVQh32n+rTOGeCcSJaT665oSxtDGSOGBymialoENHpmJcmxmL2VJ1vSoR
        fp+zDQoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkbUt-004C08-HU; Wed, 10 Nov 2021 00:29:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hare@suse.de, hch@infradead.org, jack@suse.cz,
        tj@kernel.org, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: add __must_check for *add_disk*() callers
Date:   Tue,  9 Nov 2021 16:29:49 -0800
Message-Id: <20211110002949.999380-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have done a spring cleaning on all drivers and added
error checking / handling, let's keep it that way and ensure
no new drivers fail to stick with it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

OK this is ready now as Linus has merged all the add_disk() error
handling changes.

 block/genhd.c         | 6 +++---
 include/linux/genhd.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ca2fbab1d425..c5392cc24d37 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -394,8 +394,8 @@ static void disk_scan_partitions(struct gendisk *disk)
  * This function registers the partitioning information in @disk
  * with the kernel.
  */
-int device_add_disk(struct device *parent, struct gendisk *disk,
-		     const struct attribute_group **groups)
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -544,7 +544,7 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-	return WARN_ON_ONCE(ret); /* keep until all callers handle errors */
+	return ret;
 }
 EXPORT_SYMBOL(device_add_disk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 462634b4b48f..74c410263113 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -205,9 +205,9 @@ static inline dev_t disk_devt(struct gendisk *disk)
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 /* block/genhd.c */
-int device_add_disk(struct device *parent, struct gendisk *disk,
-		const struct attribute_group **groups);
-static inline int add_disk(struct gendisk *disk)
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups);
+static inline int __must_check add_disk(struct gendisk *disk)
 {
 	return device_add_disk(NULL, disk, NULL);
 }
-- 
2.33.0

