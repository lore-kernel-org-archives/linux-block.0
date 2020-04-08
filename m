Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D90C2D0F4
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583EE2075E
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HQrkRVL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgDHTo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:44:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDHTo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 15:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gXgklFUzM8WqeF/kVmfPL5DEFYfPnsK4+i73wy067BY=; b=HQrkRVL54iSZ0Aizg5wKt1BL2s
        SKURkscTE930uqrc9wfrniY8XdQzMwneVenENUAnZcDskyQi6Tq+rbcj680GSB1f/+pbGDfOYjP2V
        gApwv3e7rgXHPnNGb60y3AlQIk+Pfjf2tjbjfgz8MQ8oMBo7OqncDjdQpKl2fDtaxWlklhPYjxrYg
        ffstGq96Fji+9QkTA14NL5HNvfbT+YQefIdujgT4RvFsU4a8K72qyV7vmQxRi1/O5xH+pW2OJYlNY
        pEcCsM1uX8ftyFb1sg5rM5JfVQ2d4pfCZbksMNxBSvMS91OlKuUinw+E5LnUOAYrIoxv7dH0bfY/t
        LI49zPwg==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMGd8-0004Ln-Ms; Wed, 08 Apr 2020 19:44:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 07/10] block: don't call invalidate_partition from blk_drop_partitions
Date:   Wed,  8 Apr 2020 21:44:36 +0200
Message-Id: <20200408194439.1580699-8-hch@lst.de>
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

Given that the device must not be busy, most of the calls from
invalidate_partition that are related to file system metadata are
guranteed to not happen.  Just open code the calls to sync_blockdev
and invalidate_bdev instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8a41c25022ab..3fe383adb42a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -607,15 +607,14 @@ int blk_drop_partitions(struct block_device *bdev)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
-	int res;
 
 	if (!disk_part_scan_enabled(bdev->bd_disk))
 		return 0;
 	if (bdev->bd_part_count || bdev->bd_openers)
 		return -EBUSY;
-	res = invalidate_partition(bdev->bd_disk, 0);
-	if (res)
-		return res;
+
+	sync_blockdev(bdev);
+	invalidate_bdev(bdev);
 
 	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);
 	while ((part = disk_part_iter_next(&piter)))
-- 
2.25.1

