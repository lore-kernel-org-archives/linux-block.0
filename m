Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5924C433FE
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B8F61058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhI0WHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhI0WGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:36 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64043C051747;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zFQJLYbD2Zgj6Ir3zIPXJ5PGzNwoNjONV8OHW6B6xJ8=; b=wdM6b37mV4vqoQE1aJhOc0Qgtu
        4/AnQOVmVaox4BB2tG29Qg3l6p6UqAFtJe1sMfDgpIVcoTaFeJGfXAdpD7iuK+OW1HwhaWyzbykyp
        Scco11Xzmx7LpfAkRtu3e4Dn4rjAY0Loki3fzj3JGsR3kFFJDYNiyw2svulyap6PRqOlJP0TfVRVN
        ZuFEcYozSfax9dUDWxaar0S1gXojnpoDkFruowGV/DFLDvy5pnqyC/VPF5TCgGE/+k0y6BMHZMMkN
        +IyKp3O8LNBJ6lKASnOzuZPF7659LP41V7luf8M+/p2l3TSx7u+GwP5482VcHpi3a8TjJ6LaF+0CY
        0QX0y3vA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VIP-Nz; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 08/14] swim: add helper for disk cleanup
Date:   Mon, 27 Sep 2021 15:02:56 -0700
Message-Id: <20210927220302.1073499-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Disk cleanup can be shared between exit and bringup. Use a
helper to do the work required. The only functional change at
this point is we're being overly paraoid on exit to check for
a null disk as well now, and this should be safe.

We'll later expand on this, this change just makes subsequent
changes easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f085ea982bb7..3deb9d9a59c0 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -771,6 +771,17 @@ static const struct blk_mq_ops swim_mq_ops = {
 	.queue_rq = swim_queue_rq,
 };
 
+static void swim_cleanup_floppy_disk(struct floppy_state *fs)
+{
+	struct gendisk *disk = fs->disk;
+
+	if (!disk)
+		return;
+
+	blk_cleanup_disk(disk);
+	blk_mq_free_tag_set(&fs->tag_set);
+}
+
 static int swim_floppy_init(struct swim_priv *swd)
 {
 	int err;
@@ -835,12 +846,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 exit_put_disks:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	do {
-		struct gendisk *disk = swd->unit[drive].disk;
-
-		if (!disk)
-			continue;
-		blk_cleanup_disk(disk);
-		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
+		swim_cleanup_floppy_disk(&swd->unit[drive]);
 	} while (drive--);
 	return err;
 }
@@ -911,8 +917,7 @@ static int swim_remove(struct platform_device *dev)
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
-		blk_cleanup_disk(swd->unit[drive].disk);
-		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
+		swim_cleanup_floppy_disk(&swd->unit[drive]);
 	}
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
2.30.2

