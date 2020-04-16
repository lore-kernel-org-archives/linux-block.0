Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C19C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F218D2222D
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L8FlcY6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgDPQzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732912AbgDPQzO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB318C061A0C;
        Thu, 16 Apr 2020 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MaJ8cbIF05R65GgF6it7FdrfP3dwxxXDqItQO95YJTU=; b=L8FlcY6tf6g3ibHnA2U+CfXpXc
        laC5jN2/ahLl/dz8SoUjdmtK5wNSgg7XA7gC1nv9Ik79gJw878qaipx/E3qW3gO+evY9hVL+0cir6
        bSqQHbCi2q202EMZFI7UVHtCTlkoMBPiXucROnKR/75xKLqe7TwQhQ8zDSrxtvW/3DPzAf+zZhOsO
        KLi1brpvtPTc4tSdpwsL1jnFFKlxg7jRf2f86k5yFT5RjeZpwOGRoJqJcFu4ErimeYsxiQT4cbp3O
        8OCSnr0GCgQZHyvkPAZyEs4qaJIzT+9F1GAmTT2ly3+cYEU2A8pCTp8sLoqVGI40PhXF0pVe4H6im
        18rrolxg==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7nC-0003jl-F3; Thu, 16 Apr 2020 16:55:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] bdi: remove bdi_register_owner
Date:   Thu, 16 Apr 2020 18:54:51 +0200
Message-Id: <20200416165453.1080463-7-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416165453.1080463-1-hch@lst.de>
References: <20200416165453.1080463-1-hch@lst.de>
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
---
 block/genhd.c               |  8 +++++---
 include/linux/backing-dev.h |  2 +-
 mm/backing-dev.c            | 12 ++----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..7d10cfc38c70 100644
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
index c9ad5c3b7b4b..4098ed6ba6b4 100644
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
index eb6b51e49d11..bb993f99d424 100644
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
2.25.1

