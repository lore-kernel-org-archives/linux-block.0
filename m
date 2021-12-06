Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41DC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 07:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhLFHHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbhLFHHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 02:07:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A012C0613F8
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 23:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QHAHZlMNQGb4KVFPPzA6N4ajCZQ9WftbO+IR0HHWWwI=; b=s5oEX1MVSvY/GgOYP8e6o5R0uZ
        3Spest4ct6CNsEkx2qn88rjoKP+FHZmYdPie6xMHs2VOS+VWB395AacYTF8rd41GIM19mKLTkIE42
        T380PAPemU+BzN4sA2J5MzPytqnxfde53VNgS4ASERKlRBpKSMd3rpgXVp6eD2+LgLnhofOkat9F8
        FadF/p+5hDyzm7jvNyoscEKePAY6la3Dme/PXxJmdsUYRwikfWm80MPlt4diAGv4oUCK7LzNeZMDf
        0POPmJEEZ9T8U2XPfMG7JBv2SkS3iUj75heZWQlXDosSOi1xOSITuH0OTkn4kAoOQHWO3S13vr6TT
        I+6bVBUQ==;
Received: from [2001:4bb8:188:5f81:7111:bfb1:4076:ce0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu82j-003NsJ-DX; Mon, 06 Dec 2021 07:04:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
Date:   Mon,  6 Dec 2021 08:04:09 +0100
Message-Id: <20211206070409.2836165-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.

Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/mtd_blkdevs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 113f86df76038..243f28a3206b4 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -346,7 +346,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	gd->minors = 1 << tr->part_bits;
 	gd->fops = &mtd_block_ops;
 
-	if (tr->part_bits)
+	if (tr->part_bits) {
 		if (new->devnum < 26)
 			snprintf(gd->disk_name, sizeof(gd->disk_name),
 				 "%s%c", tr->name, 'a' + new->devnum);
@@ -355,9 +355,11 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 				 "%s%c%c", tr->name,
 				 'a' - 1 + new->devnum / 26,
 				 'a' + new->devnum % 26);
-	else
+	} else {
 		snprintf(gd->disk_name, sizeof(gd->disk_name),
 			 "%s%d", tr->name, new->devnum);
+		gd->flags |= GENHD_FL_NO_PART;
+	}
 
 	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
 
-- 
2.30.2

