Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C3C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiBPPJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:09:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBPPJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:09:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0ED204D9C
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E7Uyl7G0unJ9YVGSQZEva2pB8H/CYU1rQkVTcEFAy+k=; b=lPm+vTHT8A6vXwyX+mJFuk5bKD
        oPJf9C5HYgpRdpWz3ReYN+k24L20/hHAYG6T4sfNbaUJ6v+yGmtphnLIJyNy182WmXq5ri2vGx3IH
        IWrK3NJDiMe00pzHt79RWEVoKy4VD8l2TK5pmfZCVPkT0E/QSIB7k9hluWHIO+rQ4JHKiEZVZPQrL
        E31IQJ9dQsHDJF56PPefXXh1rf8M8nAKY3GWrarduzEFMXvzM7h5JIXtt+90ZEeikm5z/7S0kpFdB
        6e5mBHxSB5htwtUXr2u7Z+jY2YsCUbBb3shV1Re5n22iGPegdzJZVRb3eGoI/B/JbNJ2oRu0a4uQO
        JTmfTZpg==;
Received: from [2001:4bb8:184:543c:6e8c:bf25:364a:5dde] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKLvW-007RN4-AZ; Wed, 16 Feb 2022 15:09:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for surprise removals
Date:   Wed, 16 Feb 2022 16:09:01 +0100
Message-Id: <20220216150901.4166235-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For surprise removals that have already marked the disk dead, there is
no point in calling fsync_bdev as all I/O will fail anyway, so skip it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..f68bdfe4f883b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->open_mutex);
 
-	fsync_bdev(disk->part0);
+	/*
+	 * If this is not a surprise removal see if there is a file system
+	 * mounted on this device and sync it (although this won't work for
+	 * partitions).  For surprise removals that have already marked the
+	 * disk dead skip this call as no I/O is possible anyway.
+	 */
+	if (!test_bit(GD_DEAD, &disk->state))
+		fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
 	/*
-- 
2.30.2

