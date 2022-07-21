Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7787C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiGUNJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGUNJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC021FCD0
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jN+D1Ce/M7DtmD0mo8lf61NYk3QiO8Mk5OkJeEu7qYA=; b=WncudjTpzsCU9vNJ8iITKo2Enh
        CuVAz5KOfT9Gm/gFgysVqdBwJOZeFgQ5mS8/OMAEnKrtIEON0eWRpoz8GKiBBApReGnyUB2NyxzXf
        K1rv5NfI6CPEJ7yJhE127QvF3srQhqg7QiN/njcnUedhIChQ8SC4vhcSUiZBR+u3tIjV1XVFnQpZS
        FVy9vwDTJgFzqFlMFdomiohaDZYFl25kZV5NyxRjC7PKNCh99g4TUXeecVu6MB5r8jwzRCI03jUlL
        4Sm1IO9hudXCX0G3qq/J31L30Snld4LW7ki4q0JM1fJYYcKOT966ROZd6dG15oVevXj5RzctZsEuv
        +Zt6cvyg==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvl-006mqm-Qe; Thu, 21 Jul 2022 13:09:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/8] ublk: simplify ublk_ch_open and ublk_ch_release
Date:   Thu, 21 Jul 2022 15:09:12 +0200
Message-Id: <20220721130916.1869719-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

fops->open and fops->release are always paired.  Use simple atomic bit
ops ot indicate if the device is opened instead of a count that can
only be 0 and 1 and a useless cmpxchg loop in ublk_ch_release.

Also don't bother clearing file->private_data is the file is about to
be freed anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index deabcb23ae2af..1f7bbbc3276a2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -125,7 +125,8 @@ struct ublk_device {
 	struct cdev		cdev;
 	struct device		cdev_dev;
 
-	atomic_t		ch_open_cnt;
+#define UB_STATE_OPEN		(1 << 0)
+	unsigned long		state;
 	int			ub_number;
 
 	struct mutex		mutex;
@@ -647,21 +648,17 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	struct ublk_device *ub = container_of(inode->i_cdev,
 			struct ublk_device, cdev);
 
-	if (atomic_cmpxchg(&ub->ch_open_cnt, 0, 1) == 0) {
-		filp->private_data = ub;
-		return 0;
-	}
-	return -EBUSY;
+	if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
+		return -EBUSY;
+	filp->private_data = ub;
+	return 0;
 }
 
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
-	while (atomic_cmpxchg(&ub->ch_open_cnt, 1, 0) != 1)
-		cpu_relax();
-
-	filp->private_data = NULL;
+	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
 
-- 
2.30.2

