Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73037C2BB85
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BB42074D
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBVVt23e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406630AbgDNH3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390794AbgDNH3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1XH5GbocTPgBE38P465Thqk6IEdigoyWMin6IJ+rU2o=; b=VBVVt23e1IRsYpSdhgD19IQdkc
        /T3j0Gm6RVvDK8n+/zJKQNT7NxYiWILmIAbjRoqlJFWQS3RlckyJePlP3skTse2y6IzxtKOA6v3sc
        k/vNKaoarV32kEq1PMc8xwcD0xS0k1Wfe/yEGMJLeZ+pbFd6P7Aqdi9swr3JI8cC03Ku8HN2CeUnU
        ZMiE51ribrN1oBxqthVXkQNrNXaIF6g0sWRPlRE6YqY5kTV1fVFuVQOpVDOVYdj3RM5O26XBiWMFm
        +rS9UtDmnxMSTFYPRHdMaZgbGWdXN5J7bUjVZXL9VpI6RemIAONiMSsPdNNvbCgW4Iz8K9vg9SzmS
        phGvu8eA==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0f-0005b8-Iu; Tue, 14 Apr 2020 07:29:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/10] block: simplify block device syncing in bdev_del_partition
Date:   Tue, 14 Apr 2020 09:29:00 +0200
Message-Id: <20200414072902.324936-9-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We just checked a little above that the block device for the partition
im busy.  That implies no file system is mounted, and thus the only
thing in fsync_bdev that actually is used is sync_blockdev.  Just call
sync_blockdev directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index a94d296d7aed..c085bf85509b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -531,7 +531,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	if (bdevp->bd_openers)
 		goto out_unlock;
 
-	fsync_bdev(bdevp);
+	sync_blockdev(bdevp);
 	invalidate_bdev(bdevp);
 
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-- 
2.25.1

