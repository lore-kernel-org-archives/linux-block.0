Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E324C433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9D161151
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhDBRRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhDBRRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 13:17:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4AC0613E6
        for <linux-block@vger.kernel.org>; Fri,  2 Apr 2021 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FWfJErjejlS1AYa5YQVNFahI6M7MjB4yvilNvAkOIj8=; b=e0iGTrPLC4vha6HQNyPkZOHiCX
        gLKx8ibsJB6/MhNB8xNsLRVqkeB3gVnBiyLbus3d02V7V2NHTfkMq2swMt7LHe50C+d/r2mGsVe3I
        Akpdv2zBdfmwTVV37Vr1Dvjr+hxlSCPP442dYTtAOishP8e8PwF95rAusEcWHx8m4UJZyg/+9i5wV
        vwntKyYH6/MwSg+l+r1bnocDiDw1MaOOOczq7J+NLLex/evTWmPMlq9HZAZfgUUwETMDvskfTYTN7
        Vfbdn/nJrUFJIVr7YJT8v0U6gbU5g5nZ7blTehzgLebAqi2h+E9rMGgnCDeX5Jxr+NGM6IcrfkNlg
        majTEoIQ==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lSNQL-00FV9p-PZ; Fri, 02 Apr 2021 17:17:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: update a few comments in uapi/linux/blkpg.h
Date:   Fri,  2 Apr 2021 19:17:31 +0200
Message-Id: <20210402171731.389733-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The big top of the file comment talk about grand plans that never
happened, so remove them to not confuse the readers.  Also mark the
devname and volname fields as ignored as they were never used by the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/blkpg.h | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/blkpg.h b/include/uapi/linux/blkpg.h
index ac6474e4f29d5a..d0a64ee97c6df0 100644
--- a/include/uapi/linux/blkpg.h
+++ b/include/uapi/linux/blkpg.h
@@ -2,29 +2,6 @@
 #ifndef _UAPI__LINUX_BLKPG_H
 #define _UAPI__LINUX_BLKPG_H
 
-/*
- * Partition table and disk geometry handling
- *
- * A single ioctl with lots of subfunctions:
- *
- * Device number stuff:
- *    get_whole_disk()		(given the device number of a partition,
- *                               find the device number of the encompassing disk)
- *    get_all_partitions()	(given the device number of a disk, return the
- *				 device numbers of all its known partitions)
- *
- * Partition stuff:
- *    add_partition()
- *    delete_partition()
- *    test_partition_in_use()	(also for test_disk_in_use)
- *
- * Geometry stuff:
- *    get_geometry()
- *    set_geometry()
- *    get_bios_drivedata()
- *
- * For today, only the partition stuff - aeb, 990515
- */
 #include <linux/compiler.h>
 #include <linux/ioctl.h>
 
@@ -52,9 +29,8 @@ struct blkpg_partition {
 	long long start;		/* starting offset in bytes */
 	long long length;		/* length in bytes */
 	int pno;			/* partition number */
-	char devname[BLKPG_DEVNAMELTH];	/* partition name, like sda5 or c0d1p2,
-					   to be used in kernel messages */
-	char volname[BLKPG_VOLNAMELTH];	/* volume label */
+	char devname[BLKPG_DEVNAMELTH];	/* unused / ignored */
+	char volname[BLKPG_VOLNAMELTH];	/* unused / ignore */
 };
 
 #endif /* _UAPI__LINUX_BLKPG_H */
-- 
2.30.1

