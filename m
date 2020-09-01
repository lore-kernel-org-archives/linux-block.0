Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B560C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 09:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B389206A5
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 09:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oMkIzyFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgIAJ7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAJ7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 05:59:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5DC061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E4iBZUhV5cqi/Ov55CXOrSEBtjwgHJdyBmBgFNWzSPg=; b=oMkIzyFcoXvOHP1Jfqw8q2reXK
        Gg4XSUgCMCgTxj5Wp7e+fEjU9uvmUl56Jl3djFXF57Y+i35mVtg2AtUuLWK+vhjpXa+5vz83D3FQL
        kZouBxAQfITGOIR/Ua5YVRyMFZlvox9Q2nlF+3KbqifOPOM86xFOg/uL2kyGE9SOy60jeQIb554Tc
        k17NkE4aIE44P+rAekvWaB3S0d44KtWPyZUqD8mTMU2aPzryKMLvF0kk3BQgmfBsHnsdc+A0Uabgt
        92eRc5e7X/VwpNLlSyX0oIWrKLv+yg0avnyamzUvCtXC7OqebEtUTeZd0JKpVy13pch5xH4K8rYY8
        JbG8UNbA==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD34p-0006Fq-L6; Tue, 01 Sep 2020 09:59:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com
Subject: [PATCH] block: fix locking in bdev_del_partition
Date:   Tue,  1 Sep 2020 11:59:41 +0200
Message-Id: <20200901095941.2626957-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to hold the whole device bd_mutex to protect against
other thread concurrently deleting out partition before we get
to it, and thus causing a use after free.

Fixes: cddae808aeb7 ("block: pass a hd_struct to delete_partition")
Reported-by: syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index e62a98a8eeb750..effaa8fd2ee486 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -524,19 +524,20 @@ int bdev_add_partition(struct block_device *bdev, int partno,
 int bdev_del_partition(struct block_device *bdev, int partno)
 {
 	struct block_device *bdevp;
-	struct hd_struct *part;
-	int ret = 0;
-
-	part = disk_get_part(bdev->bd_disk, partno);
-	if (!part)
-		return -ENXIO;
+	struct hd_struct *part = NULL;
+ 	int ret;
 
-	ret = -ENOMEM;
-	bdevp = bdget(part_devt(part));
+	bdevp = bdget_disk(bdev->bd_disk, partno);
 	if (!bdevp)
-		goto out_put_part;
+		return -ENOMEM;
 
 	mutex_lock(&bdevp->bd_mutex);
+	mutex_lock_nested(&bdev->bd_mutex, 1);
+
+	ret = -ENXIO;
+	part = disk_get_part(bdev->bd_disk, partno);
+	if (!part)
+		goto out_unlock;
 
 	ret = -EBUSY;
 	if (bdevp->bd_openers)
@@ -545,16 +546,14 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	sync_blockdev(bdevp);
 	invalidate_bdev(bdevp);
 
-	mutex_lock_nested(&bdev->bd_mutex, 1);
 	delete_partition(bdev->bd_disk, part);
-	mutex_unlock(&bdev->bd_mutex);
-
 	ret = 0;
 out_unlock:
+	mutex_unlock(&bdev->bd_mutex);
 	mutex_unlock(&bdevp->bd_mutex);
 	bdput(bdevp);
-out_put_part:
-	disk_put_part(part);
+	if (part)
+		disk_put_part(part);
 	return ret;
 }
 
-- 
2.28.0

