Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA577C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B577220721
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 12:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dm6ZYDaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgEDM5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729142AbgEDM5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 08:57:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C540C061A0E;
        Mon,  4 May 2020 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JHS0YR+wOvaEwIaZytCv+lJ3qHKIJOdQekzLDwhoG6E=; b=Dm6ZYDawblKR670LWyyASeMYTB
        o2nHZdO11JbT1rNjnoO1goswf70yI5ulHnaGO36woPeiz8BRlA46/b+aGiazgADm67v259P2d8WkI
        kWsRF9o83eA6unTihzmYHrYo4EvuxpWryZpLKBp/bVW0O/B7QNUnQYXnQhSGgdUz++cLakPNR9vsD
        HQexfw3fLw3NgVgYPdoJyR4g68YYyqd+V88mMGibXXg8WZ0Gta669S1rFhzzp9bF5F9z8UoM7jIvY
        ke1Jg4+a0BidNIeg7zYBMSabnJN0JocBaekZ4huKELZm0Uwbe+b7VNBIXcKkxIDFU2bxujzjR/MeY
        K4rPLsEw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaee-0007eH-9e; Mon, 04 May 2020 12:57:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] bdi: remove bdi_register_owner
Date:   Mon,  4 May 2020 14:47:59 +0200
Message-Id: <20200504124801.2832087-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split out a new bdi_set_owner helper to set the owner, and move the policy
for creating the bdi name back into genhd.c, where it belongs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/genhd.c               |  8 +++++---
 include/linux/backing-dev.h |  2 +-
 mm/backing-dev.c            | 12 ++----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c05d509877fa7..27511b3d164dd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -840,13 +840,15 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	} else {
+		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
+		struct device *dev = disk_to_dev(disk);
 		int ret;
 
 		/* Register BDI before referencing it from bdev */
-		disk_to_dev(disk)->devt = devt;
-		ret = bdi_register_owner(disk->queue->backing_dev_info,
-						disk_to_dev(disk));
+		dev->devt = devt;
+		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
+		bdi_set_owner(bdi, dev);
 		blk_register_region(disk_devt(disk), disk->minors, NULL,
 				    exact_match, exact_lock, disk);
 	}
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c9ad5c3b7b4b2..4098ed6ba6b43 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -33,7 +33,7 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...);
 __printf(2, 0)
 int bdi_register_va(struct backing_dev_info *bdi, const char *fmt,
 		    va_list args);
-int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
+void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
 
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index eb6b51e49d11f..bb993f99d4244 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -977,20 +977,12 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 }
 EXPORT_SYMBOL(bdi_register);
 
-int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
+void bdi_set_owner(struct backing_dev_info *bdi, struct device *owner)
 {
-	int rc;
-
-	rc = bdi_register(bdi, "%u:%u", MAJOR(owner->devt), MINOR(owner->devt));
-	if (rc)
-		return rc;
-	/* Leaking owner reference... */
-	WARN_ON(bdi->owner);
+	WARN_ON_ONCE(bdi->owner);
 	bdi->owner = owner;
 	get_device(owner);
-	return 0;
 }
-EXPORT_SYMBOL(bdi_register_owner);
 
 /*
  * Remove bdi from bdi_list, and ensure that it is no longer visible
-- 
2.26.2

