Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A47CC61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCPCP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBCPCO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 10:02:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CB8A0014
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=B1vW15NVsDYkOW+hLKUEtNXh9hHRNpIWYc+VEKOiTp4=; b=N2IWMcx+JN+UqFVdmYrP8hlbdX
        37YTzgoTjxlWomv8SBbLIJIDczaBUeoj/fwOhfV/Qfpkpfk8tMp2vEinNcgBwV19hiyf1b4xW8WLG
        6AIXY/bReSZgUX+ZlXGD32GsvvgiLJK9JUB4cNzGWLqtY0QVz9n+d7XjrD0iMXZ/5wflyeUUV4tf1
        AnVIbZeNBCo+q+X4cpys3tJPrbEXfLwg3OEciej/XyW8lOqf1DAq5JjHs+1zRFBl27qoVa3TV+VMI
        bwn2Osb8cwNmnV5YLK+xKGMuLgfT6l0wDDTEXFicO3+kwHbvJOEquPmnsFrAjJAvxSxrVvgQ1S5mh
        mLs/iR3g==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxZs-002ZeI-4T; Fri, 03 Feb 2023 15:02:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: stub out and deprecated the capability attribute on the gendisk
Date:   Fri,  3 Feb 2023 16:02:09 +0100
Message-Id: <20230203150209.3199115-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The capability attribute was added in 2017 to expose the kernel internal
GENHD_FL_MEDIA_CHANGE_NOTIFY to userspace without ever adding a value to
an UAPI header, and without ever setting it in any driver until it was
finally removed in Linux 5.7.

Deprecate the file and always return 0 instead of exposing the other
internal and frequently renumbered other gendisk flags.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/capability.rst | 10 ----------
 Documentation/block/index.rst      |  1 -
 block/genhd.c                      |  5 ++---
 3 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/block/capability.rst

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
deleted file mode 100644
index 2ae7f064736ad3..00000000000000
--- a/Documentation/block/capability.rst
+++ /dev/null
@@ -1,10 +0,0 @@
-===============================
-Generic Block Device Capability
-===============================
-
-This file documents the sysfs file ``block/<disk>/capability``.
-
-``capability`` is a bitfield, printed in hexadecimal, indicating which
-capabilities a specific block device supports:
-
-.. kernel-doc:: include/linux/blkdev.h
diff --git a/Documentation/block/index.rst b/Documentation/block/index.rst
index c4c73db748a81f..102953166429bf 100644
--- a/Documentation/block/index.rst
+++ b/Documentation/block/index.rst
@@ -10,7 +10,6 @@ Block
    bfq-iosched
    biovecs
    blk-mq
-   capability
    cmdline-partition
    data-integrity
    deadline-iosched
diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331cde..093ef292e98f7f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1016,9 +1016,8 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 static ssize_t disk_capability_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct gendisk *disk = dev_to_disk(dev);
-
-	return sprintf(buf, "%x\n", disk->flags);
+	dev_warn_once(dev, "the capability attribute has been deprecated.\n");
+	return sprintf(buf, "0\n");
 }
 
 static ssize_t disk_alignment_offset_show(struct device *dev,
-- 
2.39.0

