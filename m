Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306CC5ACD6
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 08:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B82076C
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 08:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UwfTMz36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCRIMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:12:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCRIMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 04:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0pCkFfpLvsOhJB+Wj0rCJ7N0wVgmkKYMyCqbolddp/c=; b=UwfTMz366+tipxvjgL3gbnATFV
        hWNDsL00AWbE1EY9lhTRI5VU0uPAnjGA8O2T4cAfgNaEPGYrzfwSlvDDz9OIG4XMxwn48Hd5OqdEp
        tk9Id9YxCDK/V+vwGxXs9qHJwgCn9YwyVe5EWALTG4XcB21TS518KdehSXQUxvyuVLKTbGgkSwSO9
        dOnl+HVXzIXxUwggh+znqxNBtT/rBd7IQWTHdAbzBnPykbZ3kq/u8k1s6i0vPl2LmehZRBVCG+ZVq
        94Fqz0GVGauovDHHo78qWfn4s1gkmI4NZj4E/Bun8WoX3qlJrfpoPrsgJSnpuYDDi6qaxbcHjYNz9
        Cz5y4xRg==;
Received: from [2001:4bb8:188:30cd:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jETo8-0007Vi-TH; Wed, 18 Mar 2020 08:12:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     zhe.he@windriver.com, linux-block@vger.kernel.org
Subject: [PATCH] block: fix a device invalidation regression
Date:   Wed, 18 Mar 2020 09:12:06 +0100
Message-Id: <20200318081206.1075464-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Historically we only set the capacity to zero for devices that support
partitions (independ of actually having partitions created).  Doing that
is rather inconsistent, but changing it broke legacy udisks polling for
legacy ide-cdrom devices.  Use the crude a crude check for devices that
either are non-removable or partitionable to get the sane behavior for
most device while not breaking userspace for this particular setup.

Fixes: a1548b674403 ("block: move rescan_partitions to fs/block_dev.c")
Reported-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: He Zhe <zhe.he@windriver.com>
---
 fs/block_dev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..9501880dff5e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1520,10 +1520,22 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	if (ret)
 		return ret;
 
-	if (invalidate)
-		set_capacity(disk, 0);
-	else if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
+	/*
+	 * Historically we only set the capacity to zero for devices that
+	 * support partitions (independ of actually having partitions created).
+	 * Doing that is rather inconsistent, but changing it broke legacy
+	 * udisks polling for legacy ide-cdrom devices.  Use the crude check
+	 * below to get the sane behavior for most device while not breaking
+	 * userspace for this particular setup.
+	 */
+	if (invalidate) {
+		if (disk_part_scan_enabled(disk) ||
+		    !(disk->flags & GENHD_FL_REMOVABLE))
+			set_capacity(disk, 0);
+	} else {
+		if (disk->fops->revalidate_disk)
+			disk->fops->revalidate_disk(disk);
+	}
 
 	check_disk_size_change(disk, bdev, !invalidate);
 
-- 
2.24.1

